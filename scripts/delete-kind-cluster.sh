#!/usr/bin/env bash
set -euo pipefail

cluster_name="${CLUSTER_NAME:-cks}"

if ! command -v kind >/dev/null 2>&1; then
  echo "Required command 'kind' was not found." >&2
  exit 1
fi

if kind get clusters | grep -qx "$cluster_name"; then
  echo "Deleting kind cluster '$cluster_name'..."
  kind delete cluster --name "$cluster_name"
else
  echo "kind cluster '$cluster_name' does not exist."
fi
