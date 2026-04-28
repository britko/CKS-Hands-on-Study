#!/usr/bin/env bash
set -euo pipefail

cluster_name="${CLUSTER_NAME:-cks}"

if ! command -v kind >/dev/null 2>&1; then
  echo "Required command 'kind' was not found." >&2
  exit 1
fi

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

if kind get clusters | grep -qx "$cluster_name"; then
  echo "Deleting kind cluster '$cluster_name'..."
  kind delete cluster --name "$cluster_name"
else
  echo "kind cluster '$cluster_name' does not exist."
fi
