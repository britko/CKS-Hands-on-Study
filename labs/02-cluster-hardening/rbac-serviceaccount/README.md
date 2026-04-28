# RBAC와 ServiceAccount

## 목표

- ServiceAccount에 namespace 범위의 최소 권한을 부여한다.
- 허용된 동작과 거부된 동작을 `kubectl auth can-i`로 검증한다.

## 시험형 연습

- [Task](task.md)
- [Hints](hints.md)
- [Solution](solution.md)

## 배경 개념

RBAC는 `Role`에 권한을 정의하고 `RoleBinding`으로 주체에게 연결합니다. Pod가 Kubernetes API에 접근할 때는 보통 ServiceAccount를 사용합니다.

## 실습

```powershell
kubectl apply -f labs/02-cluster-hardening/rbac-serviceaccount/manifests/rbac.yaml
```

생성된 리소스 확인:

```powershell
kubectl get sa,role,rolebinding -n cks-rbac
```

허용된 권한 확인:

```powershell
kubectl auth can-i get pods --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
kubectl auth can-i list pods --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
```

거부되어야 하는 권한 확인:

```powershell
kubectl auth can-i delete pods --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
kubectl auth can-i get secrets --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
```

## 검증

허용 명령은 `yes`, 거부 명령은 `no`가 나와야 합니다.

## 시험 전 확인할 문서

- [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
- [kubectl auth can-i](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_auth/kubectl_auth_can-i/)

## 정리

```powershell
kubectl delete -f labs/02-cluster-hardening/rbac-serviceaccount/manifests/rbac.yaml
```

## 시험 팁

- namespace 범위면 `Role`과 `RoleBinding`을 먼저 고려합니다.
- `ClusterRoleBinding`은 영향 범위가 크므로 문제에서 요구할 때만 사용합니다.
- 검증은 항상 `kubectl auth can-i ... --as ...`로 마무리합니다.
