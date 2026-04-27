param(
    [string]$CiliumVersion = "1.19.2"
)

$ErrorActionPreference = "Stop"

foreach ($command in @("kubectl", "helm")) {
    if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
        throw "Required command '$command' was not found."
    }
}

Write-Host "Adding Cilium Helm repository..."
helm repo add cilium https://helm.cilium.io/ | Out-Null
helm repo update cilium | Out-Null

Write-Host "Installing or upgrading Cilium $CiliumVersion..."
helm upgrade --install cilium cilium/cilium `
    --version $CiliumVersion `
    --namespace kube-system `
    --set image.pullPolicy=IfNotPresent `
    --set ipam.mode=kubernetes `
    --set hubble.enabled=true `
    --set hubble.relay.enabled=true `
    --set hubble.ui.enabled=true

Write-Host "Waiting for Cilium..."
kubectl -n kube-system rollout status daemonset/cilium --timeout=5m
kubectl -n kube-system rollout status deployment/cilium-operator --timeout=5m
kubectl -n kube-system rollout status deployment/hubble-relay --timeout=5m

if (Get-Command cilium -ErrorAction SilentlyContinue) {
    cilium status --wait
} else {
    Write-Host "Optional command 'cilium' not found. Skipping 'cilium status --wait'."
}

Write-Host "Cilium and Hubble are ready."
