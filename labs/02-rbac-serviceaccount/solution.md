# Solution: RBAC 최소 권한 구성

## 적용

```bash
kubectl apply -f labs/02-rbac-serviceaccount/manifests/rbac.yaml
```

## 확인

```bash
kubectl get sa,role,rolebinding -n cks-rbac
kubectl describe role pod-read-only -n cks-rbac
```

권한 검증:

```bash
kubectl auth can-i get pods --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
kubectl auth can-i list pods --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
kubectl auth can-i delete pods --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
kubectl auth can-i get secrets --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
```

## 해설

`Role`은 namespace 안에서만 유효하므로 이 문제에 적합하다. `RoleBinding`은 `pod-reader` ServiceAccount를 `pod-read-only` Role에 연결한다. Secret 조회 권한을 주지 않았기 때문에 `get secrets`는 `no`가 되어야 한다.

## 정리

```bash
kubectl delete -f labs/02-rbac-serviceaccount/manifests/rbac.yaml
```
