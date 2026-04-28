# Troubleshooting

## 컨테이너 런타임이 보이지 않음

증상:

```text
Cannot connect to the Docker daemon
Cannot connect to Podman
```

확인:

```bash
docker info
# 또는
podman info
```

Docker와 Podman 중 하나만 정상 동작하면 됩니다. Windows/macOS에서는 Docker Desktop 또는 Podman machine이 실행 중인지 확인합니다. Linux에서는 Docker service, Podman socket 또는 현재 사용자의 런타임 권한을 확인합니다.

스크립트는 Docker가 사용 가능하면 Docker를 쓰고, Docker가 없거나 응답하지 않으면 Podman을 사용하며 `KIND_EXPERIMENTAL_PROVIDER=podman`을 설정합니다.

참고:

- [Docker Desktop Troubleshooting](https://docs.docker.com/desktop/troubleshoot/)
- [Docker Engine Troubleshooting](https://docs.docker.com/engine/daemon/troubleshoot/)
- [Podman Troubleshooting](https://podman-desktop.io/docs/troubleshooting)

## kind 노드가 Ready가 아님

확인:

```bash
kubectl get nodes
kubectl get pods -A
kubectl describe node cks-control-plane
```

Cilium이 아직 준비되지 않았거나 이미지 pull이 지연될 수 있습니다.

```bash
kubectl -n kube-system rollout status ds/cilium --timeout=5m
kubectl -n kube-system describe pod -l k8s-app=cilium
```

## Podman에서 kubelet healthz 실패

증상:

```text
failed to init node with kubeadm
[kubelet-check] The kubelet is not healthy after 4m
dial tcp 127.0.0.1:10248: connect: connection refused
```

이 오류는 Cilium 문제가 아니라 `kind` control-plane 컨테이너 안에서 kubelet이 뜨지 못한 상태입니다. Windows/macOS의 Podman machine이나 rootless Podman에서는 systemd, cgroup, privileged container 동작 차이 때문에 발생할 수 있습니다.

먼저 실패한 클러스터 잔여물을 지우고 런타임 상태를 확인합니다.

```powershell
.\scripts\delete-kind-cluster.ps1
podman machine stop
podman machine set --rootful
podman machine start
podman info
```

`podman info --format "{{.Host.Security.Rootless}}"`가 `true`를 반환하면 rootless 상태입니다. 다시 실패하면 Windows/macOS에서는 Docker Desktop WSL2 backend를 우선 사용합니다. Podman은 Docker를 사용할 수 없는 환경의 대안이지만, `kind`와 eBPF/Falco 실습은 VM 설정에 따라 안정성이 달라질 수 있습니다.

## Cilium이 설치되지 않음

확인:

```bash
helm list -n kube-system
kubectl -n kube-system get pods -l k8s-app=cilium
kubectl -n kube-system get cm cilium-config -o yaml
```

kind 클러스터 생성 시 `disableDefaultCNI: true`가 적용되어야 합니다. 이 저장소의 [infra/kind/cluster.yaml](../../infra/kind/cluster.yaml)을 사용했는지 확인합니다.

## CoreDNS 0/1과 Hubble Relay timeout

증상:

```text
deployment "hubble-relay" timed out waiting for the condition
CoreDNS: Still waiting on: "kubernetes"
CoreDNS: Get "https://10.96.0.1:443/...": TLS handshake timeout
```

이 경우 Hubble 문제가 아니라 Pod 내부에서 Kubernetes service IP로 API server에 도달하지 못하는 service routing 문제입니다. 특히 worker 노드의 CoreDNS만 실패한다면 Pod-to-API-server 반환 경로에서 masquerade가 동작하지 않는 경우가 많습니다.

이 저장소는 Podman/kind 환경에서 kube-proxy와 iptables 경로가 흔들리는 것을 피하기 위해 `kubeProxyMode: none`, Cilium `kubeProxyReplacement=true`, `bpf.masquerade=true`를 기본값으로 사용합니다. WSL2/Podman에서 `xt_socket --transparent`가 없어 Cilium iptables reconciliation이 실패할 수 있으므로 기본 설치는 L7 proxy와 일부 iptables rule 설치를 끄고, HTTP L7 정책은 별도 심화 실습에서 명시적으로 켭니다.

확인:

```bash
kubectl -n kube-system logs ds/cilium --tail=100 | grep -E "iptables|transparent|masquerade"
kubectl -n kube-system exec ds/cilium -- cilium-dbg status --verbose
kubectl -n kube-system logs deploy/coredns --tail=100
```

`infra/kind/cluster.yaml` 변경은 기존 클러스터에는 적용되지 않으므로 클러스터를 삭제하고 다시 만듭니다.

```powershell
.\scripts\delete-kind-cluster.ps1
.\scripts\create-kind-cluster.ps1
```

참고:

- [Cilium Installation Using Kind](https://docs.cilium.io/en/stable/installation/kind/)
- [Cilium Troubleshooting](https://docs.cilium.io/en/stable/operations/troubleshooting/)

## NetworkPolicy가 동작하지 않음

NetworkPolicy는 CNI가 강제해야 합니다. Cilium Pod가 Ready인지 먼저 확인합니다.

```bash
kubectl -n kube-system rollout status ds/cilium
kubectl get networkpolicy -A
```

CiliumNetworkPolicy는 Cilium CRD가 설치되어 있어야 합니다.

```bash
kubectl get crd | grep cilium
```

## Falco Pod가 CrashLoopBackOff

확인:

```bash
kubectl get pods -n falco
kubectl logs -n falco -l app.kubernetes.io/name=falco --tail=100
kubectl describe pod -n falco -l app.kubernetes.io/name=falco
```

Falco driver가 host kernel과 맞지 않을 수 있습니다. 기본 스크립트는 `modern_ebpf`를 사용합니다. 환경에 따라 Helm value에서 driver를 조정해야 할 수 있습니다.

참고:

- [Falco Kubernetes 설치](https://falco.org/docs/setup/kubernetes/)
- [Falco Troubleshooting](https://falco.org/docs/troubleshooting/)

## Hubble UI 접근

```bash
kubectl -n kube-system port-forward svc/hubble-ui 12000:80
```

브라우저에서 `http://localhost:12000`으로 접속합니다.

참고:

- [Hubble Setup](https://docs.cilium.io/en/stable/observability/hubble/setup/)
- [Hubble UI](https://docs.cilium.io/en/stable/observability/hubble/hubble-ui/)

## 시험 환경 검증

로컬 문제를 해결해도 실제 시험의 원격 desktop, control plane 파일 경로, kubelet/systemd 조사 방식은 다를 수 있습니다. 최종 점검은 [killer.sh CKS simulator](https://killer.sh/cks) 또는 kubeadm 기반 환경에서 진행합니다.
