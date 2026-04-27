# Cilium Policy

기존 [Cilium 네트워크 보안 랩](../../09-cilium-network-security/README.md)을 Microservice Vulnerabilities 도메인의 isolation 항목으로 배치합니다.

## 바로 가기

- [README](../../09-cilium-network-security/README.md)
- [App Manifest](../../09-cilium-network-security/manifests/app.yaml)
- [CiliumNetworkPolicy](../../09-cilium-network-security/manifests/cilium-network-policy.yaml)

## 시험 포인트

- 표준 NetworkPolicy와 CiliumNetworkPolicy의 책임 범위를 구분한다.
- Cilium은 policy뿐 아니라 Pod-to-Pod encryption에도 연결된다.
