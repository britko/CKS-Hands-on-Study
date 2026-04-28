param(
    [string]$ClusterName = "cks",
    [string]$ConfigPath = "infra/kind/cluster.yaml",
    [switch]$EnableCiliumL7Proxy
)

$ErrorActionPreference = "Stop"

function Test-Command {
    param([string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found. Install it and retry."
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

function Invoke-NativeOutput {
    param(
        [string]$Command,
        [string[]]$Arguments
    )

    $output = & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code ${LASTEXITCODE}: $Command $($Arguments -join ' ')"
    }

    return $output
}

function Test-ContainerRuntime {
    param([string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        return $false
    }

    & $Name version *> $null
    return $LASTEXITCODE -eq 0
}

function Test-PodmanRootless {
    $rootless = & podman info --format "{{.Host.Security.Rootless}}" 2>$null
    if ($LASTEXITCODE -ne 0) {
        return $null
    }

    $rootlessText = ($rootless | Select-Object -First 1).ToString().Trim()
    return $rootlessText.ToLowerInvariant() -eq "true"
}

function Select-ContainerRuntime {
    if ($env:KIND_EXPERIMENTAL_PROVIDER -eq "podman") {
        if (Test-ContainerRuntime podman) {
            return "podman"
        }

        throw "KIND_EXPERIMENTAL_PROVIDER is set to podman, but Podman is not usable."
    }

    if (Test-ContainerRuntime docker) {
        Remove-Item Env:\KIND_EXPERIMENTAL_PROVIDER -ErrorAction SilentlyContinue
        return "docker"
    }

    Write-Host "[INFO] Docker is not usable. Trying Podman..."

    if (Test-ContainerRuntime podman) {
        $env:KIND_EXPERIMENTAL_PROVIDER = "podman"
        return "podman"
    }

    throw "Neither Docker nor Podman is available. Install one container runtime and retry."
}

try {
    Test-Command kind
    Test-Command kubectl
    Test-Command helm

    $runtime = Select-ContainerRuntime
    Write-Host "Using container runtime: $runtime"

    if ($runtime -eq "podman") {
        $isRootless = Test-PodmanRootless
        if ($isRootless -eq $true) {
            Write-Host "[WARN] Podman is running rootless. kind may fail to start kubelet; try 'podman machine set --rootful' or use Docker Desktop."
        }
    }

    $existingClusters = Invoke-NativeOutput kind @("get", "clusters")
    if ($existingClusters -contains $ClusterName) {
        Write-Host "kind cluster '$ClusterName' already exists."
    } else {
        Write-Host "Creating kind cluster '$ClusterName'..."
        Invoke-Native kind @("create", "cluster", "--name", $ClusterName, "--config", $ConfigPath)
    }

    Invoke-Native kubectl @("config", "use-context", "kind-$ClusterName")
    $controlPlaneIp = Invoke-NativeOutput kubectl @("get", "node", "$ClusterName-control-plane", "-o", "jsonpath={.status.addresses[?(@.type=='InternalIP')].address}")
    $controlPlaneIp = ($controlPlaneIp | Select-Object -First 1).ToString().Trim()
    if ($EnableCiliumL7Proxy) {
        & "$PSScriptRoot/install-cilium.ps1" -K8sServiceHost $controlPlaneIp -K8sServicePort "6443" -EnableL7Proxy
    } else {
        & "$PSScriptRoot/install-cilium.ps1" -K8sServiceHost $controlPlaneIp -K8sServicePort "6443"
    }
    Invoke-Native kubectl @("get", "nodes")

    Write-Host ""
    Write-Host "Cluster, Cilium, and Hubble are ready."
    Write-Host "Next learning path: README.md#추천-학습-순서"
    Write-Host "Start at step 1: labs/01-cluster-setup/README.md"
} catch {
    [Console]::Error.WriteLine("Cluster setup failed: $($_.Exception.Message)")
    exit 1
}
