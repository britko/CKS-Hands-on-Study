param(
    [string]$ClusterName = "cks"
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command kind -ErrorAction SilentlyContinue)) {
    throw "Required command 'kind' was not found."
}

$existingClusters = kind get clusters
if ($existingClusters -contains $ClusterName) {
    Write-Host "Deleting kind cluster '$ClusterName'..."
    kind delete cluster --name $ClusterName
} else {
    Write-Host "kind cluster '$ClusterName' does not exist."
}
