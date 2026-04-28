# NetworkPolicy

## 목표

- namespace 전체에 default deny ingress 정책을 적용한다.
- 허용된 client Pod에서만 web Service에 접근하도록 제한한다.
- Cilium이 Kubernetes NetworkPolicy를 어떻게 강제하는지 확인한다.

## 시험형 연습

- [Task](task.md)
- [Hints](hints.md)
- [Solution](solution.md)

## 배경 개념

NetworkPolicy는 선택된 Pod에 적용됩니다. ingress default deny를 적용한 뒤 필요한 source만 허용하는 방식이 시험과 실무 모두에서 안전합니다. 이 저장소는 Cilium을 기본 CNI로 사용하므로 NetworkPolicy가 실제로 강제됩니다.

## 실습

```bash
kubectl apply -f labs/01-cluster-setup/network-policy/manifests/app.yaml
kubectl apply -f labs/01-cluster-setup/network-policy/manifests/network-policy.yaml
```

허용된 client에서 접근:

```bash
kubectl exec -n cks-netpol deploy/allowed-client -- wget -qO- --timeout=3 http://web
```

차단 대상 client에서 접근:

```bash
kubectl exec -n cks-netpol deploy/blocked-client -- wget -qO- --timeout=3 http://web
```

Cilium 관점에서 endpoint와 flow 확인:

```bash
kubectl -n kube-system exec ds/cilium -- cilium-dbg endpoint list
kubectl -n kube-system port-forward svc/hubble-ui 12000:80
```

브라우저에서 `http://localhost:12000`에 접속해 `cks-netpol` flow를 확인합니다. `cilium`/`hubble` CLI가 설치되어 있다면 `cilium hubble port-forward`와 `hubble observe --namespace cks-netpol --last 20`로도 확인할 수 있습니다.

## 검증

- `allowed-client`는 nginx 응답 HTML을 받아야 합니다.
- `blocked-client`는 timeout 또는 연결 실패가 발생해야 합니다.

정책 확인:

```bash
kubectl get networkpolicy -n cks-netpol
kubectl describe networkpolicy -n cks-netpol allow-web-from-allowed-client
```

## 시험 전 확인할 문서

- [Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Cilium Network Policy](https://docs.cilium.io/en/stable/security/policy/)
- [Hubble Observability](https://docs.cilium.io/en/stable/observability/hubble/)

## kind와 시험 환경 차이

NetworkPolicy는 CNI가 강제해야 동작합니다. 이 저장소는 Cilium을 사용하지만, 시험 환경의 CNI는 다를 수 있습니다. 표준 `NetworkPolicy` 문법과 허용/차단 검증 방식은 동일하게 연습합니다.

## 정리

```bash
kubectl delete -f labs/01-cluster-setup/network-policy/manifests/network-policy.yaml
kubectl delete -f labs/01-cluster-setup/network-policy/manifests/app.yaml
```

## 시험 팁

- default deny 정책은 빈 `podSelector: {}`로 namespace의 모든 Pod를 선택합니다.
- NetworkPolicy는 CNI가 지원해야 동작합니다. 이 저장소의 kind 설정은 Cilium을 설치합니다.
- 차단 검증은 실패가 정상입니다. timeout을 성공/실패 기준으로 해석할 수 있어야 합니다.
