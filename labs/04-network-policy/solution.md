# Solution: default deny와 허용 정책 작성

## 적용

```bash
kubectl apply -f labs/04-network-policy/manifests/app.yaml
kubectl apply -f labs/04-network-policy/manifests/network-policy.yaml
```

## 확인

Pod 준비:

```bash
kubectl rollout status deploy/web -n cks-netpol
kubectl rollout status deploy/allowed-client -n cks-netpol
kubectl rollout status deploy/blocked-client -n cks-netpol
```

접근 테스트:

```bash
kubectl exec -n cks-netpol deploy/allowed-client -- wget -qO- --timeout=3 http://web
kubectl exec -n cks-netpol deploy/blocked-client -- wget -qO- --timeout=3 http://web
```

Cilium/Hubble 확인:

```bash
kubectl -n kube-system exec ds/cilium -- cilium-dbg endpoint list
cilium hubble port-forward
hubble observe --namespace cks-netpol --last 20
```

## 해설

NetworkPolicy는 "허용 목록" 모델이다. 특정 Pod가 하나 이상의 ingress 정책에 선택되면, 명시적으로 허용된 traffic만 들어올 수 있다. 따라서 default deny를 먼저 만들고 필요한 source만 추가하는 방식이 안전하다.

## 정리

```bash
kubectl delete -f labs/04-network-policy/manifests/network-policy.yaml
kubectl delete -f labs/04-network-policy/manifests/app.yaml
```
