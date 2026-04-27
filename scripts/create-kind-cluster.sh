#!/usr/bin/env bash
set -euo pipefail

cluster_name="${CLUSTER_NAME:-cks}"
config_path="${CONFIG_PATH:-infra/kind/cluster.yaml}"

for command in docker kind kubectl helm; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Required command '$command' was not found." >&2
    exit 1
  fi
done

if kind get clusters | grep -qx "$cluster_name"; then
  echo "kind cluster '$cluster_name' already exists."
else
  echo "Creating kind cluster '$cluster_name'..."
  kind create cluster --name "$cluster_name" --config "$config_path"
fi

kubectl config use-context "kind-$cluster_name"
"$(dirname "$0")/install-cilium.sh"
kubectl get nodes

echo
echo "Cluster is ready. Start with: labs/01-kind-cluster/README.md"
