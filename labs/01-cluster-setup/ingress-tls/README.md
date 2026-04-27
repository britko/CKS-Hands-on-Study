# Ingress TLS

## 목표

- TLS Secret을 만들고 Ingress에 연결하는 흐름을 익힌다.
- HTTP 노출과 HTTPS 노출의 차이를 검증한다.

## 준비

kind에서는 Ingress controller가 기본 설치되지 않습니다. 시험 환경에서는 이미 controller가 있거나 설치 지시가 있을 수 있습니다. 로컬에서는 ingress-nginx kind 가이드를 참고합니다.

## 실습 흐름

TLS Secret 생성:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key \
  -out tls.crt \
  -subj "/CN=cks.local/O=cks"

kubectl create ns cks-ingress
kubectl create secret tls cks-tls -n cks-ingress --cert=tls.crt --key=tls.key
```

Ingress에서 확인할 필드:

```yaml
spec:
  tls:
    - hosts:
        - cks.local
      secretName: cks-tls
```

## 검증

```bash
kubectl get ingress -n cks-ingress
kubectl describe ingress -n cks-ingress <name>
curl -k https://cks.local
```

## 시험 포인트

- Secret type은 `kubernetes.io/tls`여야 한다.
- `spec.tls.hosts`와 `spec.rules.host`를 맞춘다.
- 인증서 파일명보다 Secret 이름과 namespace가 중요하다.

## 참고

- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Ingress TLS](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)
- [ingress-nginx kind guide](https://kind.sigs.k8s.io/docs/user/ingress/)
