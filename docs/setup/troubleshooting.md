# Troubleshooting

## Docker가 보이지 않음

증상:

```text
Cannot connect to the Docker daemon
```

확인:

```bash
docker info
```

Windows/macOS에서는 Docker Desktop이 실행 중인지 확인합니다. Linux에서는 Docker service와 현재 사용자의 Docker 권한을 확인합니다.

참고:

- [Docker Desktop Troubleshooting](https://docs.docker.com/desktop/troubleshoot/)
- [Docker Engine Troubleshooting](https://docs.docker.com/engine/daemon/troubleshoot/)

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

## Cilium이 설치되지 않음

확인:

```bash
helm list -n kube-system
kubectl -n kube-system get pods -l k8s-app=cilium
kubectl -n kube-system get cm cilium-config -o yaml
```

kind 클러스터 생성 시 `disableDefaultCNI: true`가 적용되어야 합니다. 이 저장소의 [infra/kind/cluster.yaml](../../infra/kind/cluster.yaml)을 사용했는지 확인합니다.

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
