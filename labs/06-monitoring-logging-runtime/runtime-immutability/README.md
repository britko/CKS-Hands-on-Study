# Runtime Immutability

## 목표

- 실행 중인 container가 변경되지 않도록 제한하는 설정을 익힌다.
- read-only root filesystem과 package manager 실행 차단의 의미를 이해한다.

## Pod 설정 예시

```yaml
securityContext:
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
containers:
  - name: app
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop: ["ALL"]
```

## 검증 명령

```bash
kubectl exec -n <ns> <pod> -- sh -c "touch /tmp/test"
kubectl exec -n <ns> <pod> -- sh -c "touch /etc/test"
kubectl exec -n <ns> <pod> -- sh -c "apk add curl || true"
```

## 시험 포인트

- `readOnlyRootFilesystem`은 container level securityContext에 둔다.
- writable path가 필요하면 `emptyDir` 등 별도 volume을 연결한다.
- immutability는 탐지(Falco)와 예방(SecurityContext)을 함께 봐야 한다.
