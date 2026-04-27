# RBAC와 ServiceAccount

기존 [RBAC와 ServiceAccount 랩](../../02-rbac-serviceaccount/README.md)을 Cluster Hardening 도메인의 핵심 랩으로 배치합니다.

## 바로 가기

- [README](../../02-rbac-serviceaccount/README.md)
- [Task](../../02-rbac-serviceaccount/task.md)
- [Hints](../../02-rbac-serviceaccount/hints.md)
- [Solution](../../02-rbac-serviceaccount/solution.md)
- [Manifest](../../02-rbac-serviceaccount/manifests/rbac.yaml)

## 추가 시험 포인트

- namespace 범위 권한은 `Role`/`RoleBinding`을 우선 사용한다.
- `ClusterRoleBinding`은 영향 범위가 크므로 문제 요구사항을 정확히 확인한다.
- ServiceAccount token이 필요 없는 Pod는 `automountServiceAccountToken: false`를 적용한다.
