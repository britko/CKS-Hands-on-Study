#!/usr/bin/env bash
set -euo pipefail

cilium_version="${CILIUM_VERSION:-1.19.2}"

for command in kubectl helm; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Required command '$command' was not found." >&2
    exit 1
  fi
done

echo "Adding Cilium Helm repository..."
helm repo add cilium https://helm.cilium.io/ >/dev/null
helm repo update cilium >/dev/null

echo "Installing or upgrading Cilium ${cilium_version}..."
helm upgrade --install cilium cilium/cilium \
  --version "$cilium_version" \
  --namespace kube-system \
  --set image.pullPolicy=IfNotPresent \
  --set ipam.mode=kubernetes \
  --set hubble.enabled=true \
  --set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true

echo "Waiting for Cilium..."
kubectl -n kube-system rollout status daemonset/cilium --timeout=5m
kubectl -n kube-system rollout status deployment/cilium-operator --timeout=5m
kubectl -n kube-system rollout status deployment/hubble-relay --timeout=5m

if command -v cilium >/dev/null 2>&1; then
  cilium status --wait
else
  echo "Optional command 'cilium' not found. Skipping 'cilium status --wait'."
fi

echo "Cilium and Hubble are ready."
