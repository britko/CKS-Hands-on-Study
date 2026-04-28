#!/usr/bin/env bash
set -euo pipefail
trap 'echo "Cluster setup failed before readiness completed." >&2' ERR

cluster_name="${CLUSTER_NAME:-cks}"
config_path="${CONFIG_PATH:-infra/kind/cluster.yaml}"

for command in kind kubectl helm; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Required command '$command' was not found." >&2
    exit 1
  fi
done

if [[ "${KIND_EXPERIMENTAL_PROVIDER:-}" == "podman" ]]; then
  if command -v podman >/dev/null 2>&1 && podman version >/dev/null 2>&1; then
    container_runtime="podman"
  else
    echo "KIND_EXPERIMENTAL_PROVIDER is set to podman, but Podman is not usable." >&2
    exit 1
  fi
elif command -v docker >/dev/null 2>&1 && docker version >/dev/null 2>&1; then
  container_runtime="docker"
  unset KIND_EXPERIMENTAL_PROVIDER
elif command -v podman >/dev/null 2>&1 && podman version >/dev/null 2>&1; then
  container_runtime="podman"
  export KIND_EXPERIMENTAL_PROVIDER="podman"
else
  echo "Neither Docker nor Podman is available. Install one container runtime and retry." >&2
  exit 1
fi

echo "Using container runtime: ${container_runtime}"

if [[ "${container_runtime}" == "podman" ]]; then
  podman_rootless="$(podman info --format '{{.Host.Security.Rootless}}' 2>/dev/null || true)"
  if [[ "${podman_rootless}" == "true" ]]; then
    echo "[WARN] Podman is running rootless. kind may fail to start kubelet; try 'podman machine set --rootful' or use Docker Desktop."
  fi
fi

if kind get clusters | grep -qx "$cluster_name"; then
  echo "kind cluster '$cluster_name' already exists."
else
  echo "Creating kind cluster '$cluster_name'..."
  kind create cluster --name "$cluster_name" --config "$config_path"
fi

kubectl config use-context "kind-$cluster_name"
control_plane_ip="$(kubectl get node "${cluster_name}-control-plane" -o 'jsonpath={.status.addresses[?(@.type=="InternalIP")].address}')"
K8S_SERVICE_HOST="$control_plane_ip" K8S_SERVICE_PORT="6443" "$(dirname "$0")/install-cilium.sh"
kubectl get nodes

echo
echo "Cluster, Cilium, and Hubble are ready."
echo "Next learning path: README.md#추천-학습-순서"
echo "Start at step 1: labs/01-cluster-setup/README.md"
