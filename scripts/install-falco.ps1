param(
    [string]$DriverKind = "modern_ebpf"
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

Write-Host "Adding Falco Helm repository..."
Invoke-Native helm @("repo", "add", "falcosecurity", "https://falcosecurity.github.io/charts", "--force-update")
Invoke-Native helm @("repo", "update", "falcosecurity")

Write-Host "Installing or upgrading Falco with driver.kind=$DriverKind..."
Invoke-Native helm @(
    "upgrade", "--install", "falco", "falcosecurity/falco",
    "--namespace", "falco",
    "--create-namespace",
    "--set", "driver.kind=$DriverKind",
    "--set", "falco.jsonOutput=true",
    "--set", "tty=true"
)

Write-Host "Waiting for Falco..."
Invoke-Native kubectl @("-n", "falco", "rollout", "status", "daemonset/falco", "--timeout=5m")
Invoke-Native kubectl @("-n", "falco", "get", "pods")

Write-Host "Falco is ready. Continue with labs/06-monitoring-logging-runtime/falco-detection/README.md"
