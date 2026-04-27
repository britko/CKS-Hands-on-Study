$ErrorActionPreference = "Stop"

$required = @("docker", "kubectl", "kind", "helm")
$optional = @("cilium", "hubble", "trivy", "cosign")

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

docker version | Out-Null
Write-Host "All required tools are available."
