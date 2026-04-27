# Hints: RBAC 최소 권한 구성

## Hint 1

namespace 범위의 권한이면 `ClusterRole`보다 `Role`을 먼저 고려한다.

## Hint 2

권한은 `rules` 아래 `apiGroups`, `resources`, `verbs`로 정의한다. core API group은 빈 문자열 `""`이다.

## Hint 3

권한 검증은 실제 Pod를 실행하지 않아도 `kubectl auth can-i --as system:serviceaccount:<namespace>:<name>`으로 할 수 있다.

## Hint 4

ServiceAccount token 자동 마운트는 ServiceAccount 또는 Pod에서 `automountServiceAccountToken: false`로 비활성화할 수 있다.
