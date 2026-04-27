# 00. Environment

CKS 실습을 시작하기 전에 로컬 도구와 kind 클러스터를 준비합니다.

## 학습 순서

1. [kind, Cilium, Falco 준비](kind-cilium-falco/README.md)
2. [기존 상세 랩: kind 클러스터와 Cilium 준비](../01-kind-cluster/README.md)

## 완료 기준

```bash
kubectl config current-context
kubectl get nodes
kubectl -n kube-system rollout status ds/cilium
kubectl get pods -n falco
```

## 시험 환경 차이

로컬 kind는 반복 실습용입니다. control plane manifest, kubelet, etcd, systemd 작업은 killer.sh 또는 kubeadm 기반 VM에서 최종 확인합니다.
