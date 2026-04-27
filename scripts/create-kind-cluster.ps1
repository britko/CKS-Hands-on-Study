param(
    [string]$ClusterName = "cks",
    [string]$ConfigPath = "infra/kind/cluster.yaml"
)

$ErrorActionPreference = "Stop"

function Test-Command {
    param([string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found. Install it and retry."
    }
}

Test-Command docker
Test-Command kind
Test-Command kubectl
Test-Command helm

$existingClusters = kind get clusters
if ($existingClusters -contains $ClusterName) {
    Write-Host "kind cluster '$ClusterName' already exists."
} else {
    Write-Host "Creating kind cluster '$ClusterName'..."
    kind create cluster --name $ClusterName --config $ConfigPath
}

kubectl config use-context "kind-$ClusterName"
& "$PSScriptRoot/install-cilium.ps1"
kubectl get nodes

Write-Host ""
Write-Host "Cluster is ready. Start with: labs/01-kind-cluster/README.md"
