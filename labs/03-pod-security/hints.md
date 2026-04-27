# Hints: restricted Pod Security 적용

## Hint 1

Pod Security Admission은 Pod가 아니라 namespace label로 적용한다.

## Hint 2

`restricted`에서 자주 필요한 필드는 `runAsNonRoot`, `allowPrivilegeEscalation`, `capabilities.drop`, `seccompProfile`이다.

## Hint 3

거부 이유는 `kubectl apply`의 에러 메시지와 namespace event에서 확인한다.

```bash
kubectl get events -n cks-psa --sort-by=.lastTimestamp
```

## Hint 4

일반 `nginx` 이미지는 root 또는 80 포트 때문에 restricted 정책과 맞지 않을 수 있다. non-root 이미지와 8080 포트를 고려한다.
