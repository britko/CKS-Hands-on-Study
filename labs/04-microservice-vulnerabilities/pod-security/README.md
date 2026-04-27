# Pod Security

기존 [Pod Security와 SecurityContext 랩](../../03-pod-security/README.md)을 Microservice Vulnerabilities 도메인의 Pod Security Standards 항목으로 배치합니다.

## 바로 가기

- [README](../../03-pod-security/README.md)
- [Task](../../03-pod-security/task.md)
- [Hints](../../03-pod-security/hints.md)
- [Solution](../../03-pod-security/solution.md)

## 시험 포인트

- namespace label로 PSA를 적용한다.
- `runAsNonRoot`, `allowPrivilegeEscalation`, `capabilities.drop`, `seccompProfile` 위치를 구분한다.
