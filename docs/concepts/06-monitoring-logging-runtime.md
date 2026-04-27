# 06. Monitoring, Logging and Runtime Security

비중: 20%

이 도메인은 audit log, runtime detection, incident investigation, runtime immutability를 다룹니다. CKS에서는 로그를 읽고 의심 workload를 찾아 개선 방향을 제시하는 능력이 중요합니다.

## 시험에서 나오는 작업

- audit policy를 작성하고 API server에 연결하는 흐름을 이해한다.
- Falco 이벤트에서 의심 Pod와 command를 찾는다.
- runtime immutability를 위해 read-only root filesystem과 최소 권한을 적용한다.
- audit/event/log를 조합해 공격 흐름을 추적한다.

## 필수 명령

```bash
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=10m
kubectl get events -A --sort-by=.lastTimestamp
kubectl describe pod -n <ns> <pod>
kubectl get pod -n <ns> <pod> -o yaml
journalctl -u kubelet --no-pager
```

## 실수 포인트

- audit log level을 `RequestResponse`로 과하게 설정해 Secret 값이 남는다.
- Falco 이벤트의 priority만 보고 namespace/pod/container/command를 확인하지 않는다.
- 탐지와 차단을 혼동한다.
- read-only root filesystem을 켜고 필요한 writable path를 준비하지 않는다.

## 연결 실습

- [Monitoring, Logging and Runtime 랩](../../labs/06-monitoring-logging-runtime/README.md)
- [Falco 런타임 보안](falco-runtime-security.md)
