param(
    [string]$CiliumVersion = "1.19.2",
    [string]$K8sServiceHost = "",
    [string]$K8sServicePort = "6443",
    [switch]$EnableL7Proxy
)

$ErrorActionPreference = "Stop"

foreach ($command in @("kubectl", "helm")) {
    if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
        throw "Required command '$command' was not found."
    }
}

function Invoke-Native {
    param(
        [string]$Command,
        [string[]]$Arguments
    )

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code ${LASTEXITCODE}: $Command $($Arguments -join ' ')"
    }
}

Write-Host "Adding Cilium Helm repository..."
Invoke-Native helm @("repo", "add", "cilium", "https://helm.cilium.io/", "--force-update")
Invoke-Native helm @("repo", "update", "cilium")

Write-Host "Installing or upgrading Cilium $CiliumVersion..."
$l7ProxyEnabled = $EnableL7Proxy.IsPresent -or ($env:ENABLE_CILIUM_L7_PROXY -eq "true")
$helmArgs = @(
    "upgrade", "--install", "cilium", "cilium/cilium",
    "--version", $CiliumVersion,
    "--namespace", "kube-system",
    "--set", "image.pullPolicy=IfNotPresent",
    "--set", "ipam.mode=kubernetes",
    "--set", "kubeProxyReplacement=true",
    "--set", "bpf.masquerade=true",
    "--set", "l7Proxy=$($l7ProxyEnabled.ToString().ToLowerInvariant())",
    "--set", "hubble.enabled=true",
    "--set", "hubble.relay.enabled=true",
    "--set", "hubble.ui.enabled=true"
)

if (-not $l7ProxyEnabled) {
    $helmArgs += @(
        "--set-string", "extraConfig.install-iptables-rules=false",
        "--set-string", "extraConfig.dnsproxy-enable-transparent-mode=false"
    )
}

if ($K8sServiceHost) {
    $helmArgs += @(
        "--set", "k8sServiceHost=$K8sServiceHost",
        "--set", "k8sServicePort=$K8sServicePort"
    )
}

Invoke-Native helm $helmArgs

Write-Host "Waiting for Cilium..."
Invoke-Native kubectl @("-n", "kube-system", "rollout", "status", "daemonset/cilium", "--timeout=5m")
Invoke-Native kubectl @("-n", "kube-system", "rollout", "status", "deployment/cilium-operator", "--timeout=5m")
Write-Host "Waiting for CoreDNS..."
Invoke-Native kubectl @("-n", "kube-system", "rollout", "status", "deployment/coredns", "--timeout=5m")
Invoke-Native kubectl @("-n", "kube-system", "rollout", "status", "deployment/hubble-relay", "--timeout=5m")

if (Get-Command cilium -ErrorAction SilentlyContinue) {
    & cilium status --wait
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[INFO] Optional 'cilium status --wait' did not complete successfully. Kubernetes rollout checks already passed."
    }
} else {
    Write-Host "[INFO] Optional Cilium CLI not found. This is OK for the labs; kubectl and Helm checks already verified Cilium."
}

Write-Host "Cilium and Hubble are ready."
