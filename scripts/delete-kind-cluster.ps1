param(
    [string]$ClusterName = "cks"
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command kind -ErrorAction SilentlyContinue)) {
    throw "Required command 'kind' was not found."
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

$runtime = Select-ContainerRuntime
Write-Host "Using container runtime: $runtime"

$existingClusters = Invoke-NativeOutput kind @("get", "clusters")
if ($existingClusters -contains $ClusterName) {
    Write-Host "Deleting kind cluster '$ClusterName'..."
    Invoke-Native kind @("delete", "cluster", "--name", $ClusterName)
} else {
    Write-Host "kind cluster '$ClusterName' does not exist."
}
