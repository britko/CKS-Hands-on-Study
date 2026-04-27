# Task: default deny와 허용 정책 작성

제한 시간: 15분

## 요구사항

`cks-netpol` namespace에서 다음 네트워크 요구사항을 만족하라.

- namespace의 모든 Pod에 ingress default deny를 적용한다.
- `allowed-client` Pod만 `web` Pod의 TCP 8080 포트로 접근할 수 있다.
- `blocked-client` Pod는 `web` Service에 접근할 수 없어야 한다.
- 정책은 표준 Kubernetes `NetworkPolicy`로 작성한다.

## 완료 조건

```bash
kubectl exec -n cks-netpol deploy/allowed-client -- wget -qO- --timeout=3 http://web
kubectl exec -n cks-netpol deploy/blocked-client -- wget -qO- --timeout=3 http://web
```

첫 번째 명령은 성공하고, 두 번째 명령은 timeout 또는 연결 실패가 발생해야 한다.
