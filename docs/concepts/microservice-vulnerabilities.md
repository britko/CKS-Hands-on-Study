# 마이크로서비스 취약점 최소화

마이크로서비스 취약점 최소화는 애플리케이션 Pod 사이의 통신, Secret 사용, ServiceAccount 권한, 컨테이너 실행 권한을 안전하게 제한하는 영역입니다.

## 핵심 개념

- NetworkPolicy는 Pod 간 ingress/egress 트래픽을 label 기준으로 제어한다.
- Secret은 base64 인코딩일 뿐 암호화가 아니며, 접근 권한과 마운트 방식이 중요하다.
- ServiceAccount token 자동 마운트는 필요할 때만 허용한다.
- 컨테이너는 non-root, read-only filesystem, 최소 capability로 실행한다.

## 자주 쓰는 명령

```powershell
kubectl get networkpolicy -A
kubectl auth can-i get secrets --as system:serviceaccount:cks-secrets:app-reader -n cks-secrets
kubectl describe pod -n cks-image secure-app
kubectl exec -n cks-netpol deploy/client -- wget -qO- http://web
```

## 시험 포인트

- NetworkPolicy는 선택된 Pod에만 적용된다.
- default deny 정책을 만든 뒤 필요한 통신만 허용하는 방식이 안전하다.
- Secret을 볼 수 있는 RBAC 권한은 매우 민감하다.
- ServiceAccount token이 필요 없는 Pod는 `automountServiceAccountToken: false`를 고려한다.

## 시험에서 나오는 작업

- ingress default deny를 만들고 특정 label의 client만 허용한다.
- egress를 DNS와 특정 Service로만 제한한다.
- Secret을 환경 변수 대신 volume으로 마운트하고 read-only로 사용한다.
- Pod가 Kubernetes API를 쓰지 않으면 ServiceAccount token 자동 마운트를 끈다.

## 실수 포인트

- NetworkPolicy의 `podSelector`가 destination을 선택한다는 점을 헷갈린다.
- Service port와 targetPort/containerPort를 혼동한다.
- Secret은 base64 인코딩일 뿐 암호화가 아니라는 점을 놓친다.
- NetworkPolicy가 없는 CNI에서는 정책이 강제되지 않는다는 점을 확인하지 않는다.

## 연결 실습

- [Cilium Policy](../../labs/04-microservice-vulnerabilities/cilium-policy/README.md)
- [Secrets](../../labs/04-microservice-vulnerabilities/secrets/README.md)
- [Image Security](../../labs/05-supply-chain-security/image-security/README.md)

## 공식 문서와 추가 학습

- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Good Practices for Kubernetes Secrets](https://kubernetes.io/docs/concepts/security/secrets-good-practices/)
- [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
- [Multi-tenancy](https://kubernetes.io/docs/concepts/security/multi-tenancy/)
- [Cilium Network Policy](https://docs.cilium.io/en/stable/security/policy/)
