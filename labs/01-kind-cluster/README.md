# 01. kind 클러스터와 Cilium 준비

## 목표

- CKS 실습용 `kind` 클러스터를 생성한다.
- Cilium CNI와 Hubble 상태를 확인한다.
- `kubectl` context, 노드, 핵심 시스템 Pod 상태를 확인한다.
- 이후 랩에서 사용할 기본 확인 명령에 익숙해진다.

## 실습

저장소 루트에서 OS에 맞게 실행합니다.

```powershell
.\scripts\create-kind-cluster.ps1
```

```bash
./scripts/create-kind-cluster.sh
```

현재 context 확인:

```bash
kubectl config current-context
```

기대 결과:

```text
kind-cks
```

노드 확인:

```bash
kubectl get nodes -o wide
```

Cilium 확인:

```bash
kubectl -n kube-system rollout status ds/cilium
kubectl -n kube-system get pods -l k8s-app=cilium
kubectl -n kube-system get pods -l k8s-app=hubble-relay
kubectl get crd | grep cilium
```

Hubble UI 확인:

```bash
kubectl -n kube-system port-forward svc/hubble-ui 12000:80
```

브라우저에서 `http://localhost:12000`에 접속합니다.

## 검증

```bash
kubectl get ns
kubectl get pods -A
kubectl cluster-info
```

모든 노드가 `Ready`이면 다음 랩으로 진행합니다.

## 시험 전 확인할 문서

- [kind Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [Cilium Installation Using Kind](https://docs.cilium.io/en/stable/installation/kind/)
- [Hubble Observability](https://docs.cilium.io/en/stable/observability/hubble/)

## kind와 시험 환경 차이

kind는 로컬 Docker 또는 Podman 위에서 노드를 실행하므로 실제 시험의 kubeadm 기반 control plane과 다릅니다. CNI 상태 확인, namespace/context 확인, `kubectl` 검증 습관은 그대로 가져가되, control plane manifest 수정은 killer.sh 또는 시험 유사 환경에서 추가로 연습합니다.

## 정리

전체 실습이 끝난 뒤에만 삭제합니다.

```powershell
.\scripts\delete-kind-cluster.ps1
```

```bash
./scripts/delete-kind-cluster.sh
```

## 시험 팁

- 시험에서는 context가 여러 개일 수 있으므로 작업 전 `kubectl config current-context`를 확인합니다.
- namespace를 명시하지 않아 생기는 실수가 많으므로 `-n <namespace>`를 습관화합니다.
- CNI가 Ready가 아니면 NetworkPolicy 결과가 의미 없으므로 `ds/cilium` 상태를 먼저 봅니다.
