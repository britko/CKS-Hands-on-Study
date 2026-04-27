#!/usr/bin/env bash
set -euo pipefail

driver_kind="${FALCO_DRIVER_KIND:-modern_ebpf}"

for command in kubectl helm; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Required command '$command' was not found." >&2
    exit 1
  fi
done

echo "Adding Falco Helm repository..."
helm repo add falcosecurity https://falcosecurity.github.io/charts >/dev/null
helm repo update falcosecurity >/dev/null

echo "Installing or upgrading Falco with driver.kind=${driver_kind}..."
helm upgrade --install falco falcosecurity/falco \
  --namespace falco \
  --create-namespace \
  --set "driver.kind=${driver_kind}" \
  --set "falco.jsonOutput=true" \
  --set "tty=true"

echo "Waiting for Falco..."
kubectl -n falco rollout status daemonset/falco --timeout=5m
kubectl -n falco get pods

echo "Falco is ready. Continue with labs/10-falco-detection/README.md"
