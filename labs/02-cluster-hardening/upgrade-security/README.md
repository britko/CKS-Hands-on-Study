# Upgrade Security Checklist

## 목표

- Kubernetes upgrade를 보안 취약점 회피 관점에서 이해한다.
- 시험에서 version 확인과 upgrade 필요성 판단을 빠르게 수행한다.

## 확인 명령

```bash
kubectl version
kubectl get nodes -o wide
kubeadm version
kubelet --version
```

## 체크리스트

- 현재 cluster/server version 확인
- node별 kubelet version 확인
- 알려진 취약점이 있는 version인지 확인
- upgrade 전 백업과 rollback 계획 확인
- control plane과 worker 순서 확인

## 시험 포인트

CKS에서 전체 upgrade 절차를 길게 수행하기보다, 취약 버전을 식별하거나 보안상 upgrade 필요성을 판단하는 문제가 나올 수 있습니다. CKA upgrade 절차를 이미 알고 있어야 합니다.

## 참고

- [Kubernetes Version Skew Policy](https://kubernetes.io/releases/version-skew-policy/)
- [kubeadm upgrade](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)
