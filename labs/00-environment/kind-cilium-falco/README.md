# kind, Cilium, Falco 준비

기존 [kind 클러스터와 Cilium 준비](../../01-kind-cluster/README.md) 랩을 공식 커리큘럼 흐름의 선행 단계로 재배치한 경로입니다.

## 실행

Windows:

```powershell
.\scripts\verify-tools.ps1
.\scripts\create-kind-cluster.ps1
.\scripts\install-falco.ps1
```

Linux/macOS:

```bash
./scripts/verify-tools.sh
./scripts/create-kind-cluster.sh
./scripts/install-falco.sh
```

## 검증

```bash
kubectl get nodes
kubectl -n kube-system get pods -l k8s-app=cilium
kubectl -n falco get pods
```
