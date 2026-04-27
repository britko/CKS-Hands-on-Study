# 02. Cluster Hardening

비중: 15%

Cluster Hardening은 Kubernetes API와 권한 모델을 안전하게 제한하는 영역입니다. RBAC, ServiceAccount, API 접근 제한, 취약점 회피를 위한 upgrade가 핵심입니다.

## 시험에서 나오는 작업

- Role/ClusterRole과 Binding을 최소 권한으로 구성한다.
- default ServiceAccount 사용을 피하고 token automount를 제한한다.
- Kubernetes API 접근 권한과 인증/인가 설정을 확인한다.
- 취약점 회피를 위한 upgrade 필요성을 판단한다.

## 필수 명령

```bash
kubectl auth can-i <verb> <resource> --as system:serviceaccount:<ns>:<sa> -n <ns>
kubectl get role,rolebinding,clusterrole,clusterrolebinding -A
kubectl describe serviceaccount -n <namespace> <name>
kubectl get --raw /readyz
kubectl version
```

## 실수 포인트

- namespace 범위 문제에 `ClusterRoleBinding`을 사용해 권한을 과도하게 준다.
- ServiceAccount token 자동 마운트를 끄지 않는다.
- `apiGroups: [""]`를 빠뜨려 core resource 권한이 적용되지 않는다.
- `--as` 주체 형식을 잘못 입력해 권한 검증을 틀린다.

## 연결 실습

- [Cluster Hardening 랩](../../labs/02-cluster-hardening/README.md)
