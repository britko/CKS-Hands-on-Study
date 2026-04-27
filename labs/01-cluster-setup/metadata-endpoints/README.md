# Metadata Endpoints

## 목표

- cloud metadata endpoint가 왜 위험한지 이해한다.
- Pod egress 제한으로 metadata endpoint 접근을 차단하는 패턴을 익힌다.

## 배경

클라우드 환경의 metadata endpoint는 instance credential이나 node 정보를 노출할 수 있습니다. 대표적으로 `169.254.169.254`가 사용됩니다. kind에는 실제 cloud metadata endpoint가 없으므로 차단 정책 패턴을 연습합니다.

## 정책 패턴

egress default deny를 적용한 뒤 필요한 대상만 허용합니다.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-egress
spec:
  podSelector: {}
  policyTypes:
    - Egress
```

DNS가 필요하면 kube-dns/CoreDNS egress를 별도로 허용해야 합니다.

## 시험형 문제

1. namespace의 모든 Pod egress를 기본 차단한다.
2. DNS egress만 허용한다.
3. `169.254.169.254`로의 접근이 실패하는지 확인한다.

## 검증

```bash
kubectl exec -n <ns> <pod> -- wget -qO- --timeout=3 http://169.254.169.254
kubectl get networkpolicy -n <ns>
```

## 참고

- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Kubernetes Security](https://kubernetes.io/docs/concepts/security/)
