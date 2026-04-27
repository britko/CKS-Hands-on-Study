# 01. Cluster Setup

비중: 15%

Cluster Setup은 클러스터를 처음 구성하거나 운영 기준을 세울 때의 보안 설정을 다룹니다. CKS v1.34에서는 NetworkPolicy, CIS benchmark, Ingress TLS, node metadata/endpoints 보호, platform binary 검증이 핵심입니다.

## 시험에서 나오는 작업

- NetworkPolicy로 cluster-level 접근을 제한한다.
- CIS benchmark 결과를 보고 위험 설정을 식별한다.
- Ingress에 TLS Secret을 연결한다.
- cloud metadata endpoint 또는 민감 endpoint 접근을 제한한다.
- Kubernetes binary checksum/signature를 확인한다.

## 필수 명령

```bash
kubectl get networkpolicy -A
kubectl describe networkpolicy -n <namespace> <name>
kubectl get ingress -A
kubectl get secret -n <namespace>
sha256sum <binary>
curl -I https://<host>
```

## 실수 포인트

- NetworkPolicy는 CNI가 강제하지 않으면 효과가 없다.
- Ingress TLS는 Secret type과 host 이름이 맞아야 한다.
- CIS benchmark는 점수를 외우는 것이 아니라 어떤 component 설정이 위험한지 읽는 것이 중요하다.
- cloud metadata endpoint는 환경마다 다르므로 개념과 차단 패턴을 이해해야 한다.

## 연결 실습

- [Cluster Setup 랩](../../labs/01-cluster-setup/README.md)
