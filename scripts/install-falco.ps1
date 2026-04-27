param(
    [string]$DriverKind = "modern_ebpf"
)

$ErrorActionPreference = "Stop"

foreach ($command in @("kubectl", "helm")) {
    if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
        throw "Required command '$command' was not found."
    }
}

Write-Host "Adding Falco Helm repository..."
helm repo add falcosecurity https://falcosecurity.github.io/charts | Out-Null
helm repo update falcosecurity | Out-Null

Write-Host "Installing or upgrading Falco with driver.kind=$DriverKind..."
helm upgrade --install falco falcosecurity/falco `
    --namespace falco `
    --create-namespace `
    --set "driver.kind=$DriverKind" `
    --set "falco.jsonOutput=true" `
    --set "tty=true"

Write-Host "Waiting for Falco..."
kubectl -n falco rollout status daemonset/falco --timeout=5m
kubectl -n falco get pods

Write-Host "Falco is ready. Continue with labs/10-falco-detection/README.md"
