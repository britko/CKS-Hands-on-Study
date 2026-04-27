# Runtime Investigation

기존 [Runtime Security 랩](../../08-runtime-security/README.md)을 런타임 조사 흐름의 기초 랩으로 배치합니다.

## 바로 가기

- [README](../../08-runtime-security/README.md)
- [Manifest](../../08-runtime-security/manifests/runtime.yaml)

## 시험 포인트

- `kubectl describe`, `kubectl logs`, `kubectl get events`, `kubectl exec`를 조합한다.
- 탐지 후에는 SecurityContext, ServiceAccount, RBAC, NetworkPolicy로 개선 방향을 연결한다.
