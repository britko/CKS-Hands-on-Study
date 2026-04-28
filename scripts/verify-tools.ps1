$ErrorActionPreference = "Stop"

$required = @("kubectl", "kind", "helm")
$optional = @("cilium", "hubble", "trivy", "cosign")

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
        return "docker"
    }

    Write-Host "[INFO] docker is not usable. Trying podman..."

    if (Test-ContainerRuntime podman) {
        return "podman"
    }

    throw "Neither Docker nor Podman is available. See docs/setup/windows.md."
}

foreach ($command in $required) {
    if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
        throw "Required command '$command' was not found. See docs/setup/windows.md."
    }
    Write-Host "[OK] $command"
}

foreach ($command in $optional) {
    if (Get-Command $command -ErrorAction SilentlyContinue) {
        Write-Host "[OK] optional: $command"
    } else {
        Write-Host "[SKIP] optional command not found: $command"
    }
}

$runtime = Select-ContainerRuntime
Write-Host "[OK] container runtime: $runtime"
Write-Host "All required tools are available."
