# 클러스터 설정과 강화

CKS에서 클러스터 설정과 강화는 Kubernetes 제어 평면과 접근 권한을 안전하게 운영하는 능력을 다룹니다. 시험에서는 긴 설명보다 현재 설정을 확인하고 필요한 최소 권한을 적용하는 속도가 중요합니다.

## 핵심 개념

- RBAC는 `Role`, `ClusterRole`, `RoleBinding`, `ClusterRoleBinding`으로 권한을 부여한다.
- ServiceAccount는 Pod가 Kubernetes API에 접근할 때 사용하는 ID다.
- API server, controller manager, scheduler, kubelet 설정은 보안의 기준점이다.
- etcd에는 Secret 등 민감한 데이터가 저장되므로 백업과 암호화 구성이 중요하다.

## 자주 쓰는 명령

```powershell
kubectl auth can-i get pods --as system:serviceaccount:default:app
kubectl get role,rolebinding -n default
kubectl describe clusterrole view
kubectl get pod -n kube-system
```

## 시험 포인트

- 권한은 필요한 namespace와 verb/resource로 좁힌다.
- `cluster-admin` 사용은 거의 항상 과하다.
- `kubectl auth can-i`로 적용 결과를 바로 검증한다.
- control plane 정적 Pod manifest는 보통 `/etc/kubernetes/manifests` 아래에 있다.

## 시험에서 나오는 작업

- 특정 ServiceAccount가 Secret을 볼 수 없게 RBAC를 수정한다.
- `ClusterRoleBinding`으로 과도하게 부여된 권한을 namespace 범위 `RoleBinding`으로 줄인다.
- API server manifest에서 admission plugin 또는 audit 설정 인자를 확인한다.
- etcd 백업/복구 명령의 endpoint, cert, key 경로를 정확히 사용한다.

## 실수 포인트

- `RoleBinding`의 `roleRef`와 `subjects` namespace를 혼동한다.
- core API group을 `apiGroups: [""]`로 적어야 하는 것을 놓친다.
- `kubectl auth can-i` 검증 시 `--as` 주체를 실제 ServiceAccount 형식으로 쓰지 않는다.

## 연결 실습

- [RBAC와 ServiceAccount](../../labs/02-rbac-serviceaccount/README.md)

## 공식 문서와 추가 학습

- [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
- [Admission Controllers](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/)
- [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
- [Encrypting Secret Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)
