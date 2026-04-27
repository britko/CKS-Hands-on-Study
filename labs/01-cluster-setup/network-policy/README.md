# NetworkPolicy

기존 [NetworkPolicy 랩](../../04-network-policy/README.md)을 Cluster Setup 도메인의 네트워크 접근 제한 항목으로 배치합니다.

## 실습

```bash
kubectl apply -f labs/04-network-policy/manifests/app.yaml
kubectl apply -f labs/04-network-policy/manifests/network-policy.yaml
```

## 시험형 문제

- namespace 전체 ingress를 default deny로 만든다.
- 허용된 client만 web service에 접근하도록 한다.
- 차단 결과는 timeout 또는 연결 실패로 검증한다.

자세한 task/hints/solution은 기존 랩을 사용합니다.

- [Task](../../04-network-policy/task.md)
- [Hints](../../04-network-policy/hints.md)
- [Solution](../../04-network-policy/solution.md)
