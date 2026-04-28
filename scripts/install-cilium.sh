#!/usr/bin/env bash
set -euo pipefail

cilium_version="${CILIUM_VERSION:-1.19.2}"
k8s_service_host="${K8S_SERVICE_HOST:-}"
k8s_service_port="${K8S_SERVICE_PORT:-6443}"
enable_l7_proxy="${ENABLE_CILIUM_L7_PROXY:-false}"

for command in kubectl helm; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Required command '$command' was not found." >&2
    exit 1
  fi
done

echo "Adding Cilium Helm repository..."
helm repo add cilium https://helm.cilium.io/ --force-update >/dev/null
helm repo update cilium >/dev/null

echo "Installing or upgrading Cilium ${cilium_version}..."
helm_args=(
  upgrade --install cilium cilium/cilium
  --version "$cilium_version"
  --namespace kube-system
  --set image.pullPolicy=IfNotPresent
  --set ipam.mode=kubernetes
  --set kubeProxyReplacement=true
  --set bpf.masquerade=true
  --set "l7Proxy=${enable_l7_proxy}"
  --set hubble.enabled=true
  --set hubble.relay.enabled=true
  --set hubble.ui.enabled=true
)

if [[ "$enable_l7_proxy" != "true" ]]; then
  helm_args+=(
    --set-string extraConfig.install-iptables-rules=false
    --set-string extraConfig.dnsproxy-enable-transparent-mode=false
  )
fi

if [[ -n "$k8s_service_host" ]]; then
  helm_args+=(
    --set "k8sServiceHost=${k8s_service_host}"
    --set "k8sServicePort=${k8s_service_port}"
  )
fi

helm "${helm_args[@]}"

echo "Waiting for Cilium..."
kubectl -n kube-system rollout status daemonset/cilium --timeout=5m
kubectl -n kube-system rollout status deployment/cilium-operator --timeout=5m
echo "Waiting for CoreDNS..."
kubectl -n kube-system rollout status deployment/coredns --timeout=5m
kubectl -n kube-system rollout status deployment/hubble-relay --timeout=5m

if command -v cilium >/dev/null 2>&1; then
  if ! cilium status --wait; then
    echo "[INFO] Optional 'cilium status --wait' did not complete successfully. Kubernetes rollout checks already passed."
  fi
else
  echo "[INFO] Optional Cilium CLI not found. This is OK for the labs; kubectl and Helm checks already verified Cilium."
fi

echo "Cilium and Hubble are ready."
