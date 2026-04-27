# 01. Cluster Setup

공식 CKS v1.34 Cluster Setup 도메인은 네트워크 접근 제한, CIS benchmark, Ingress TLS, node metadata/endpoints 보호, platform binary 검증을 다룹니다.

## 학습 순서

1. [NetworkPolicy](network-policy/README.md)
2. [CIS Benchmark](cis-benchmark/README.md)
3. [Ingress TLS](ingress-tls/README.md)
4. [Metadata Endpoints](metadata-endpoints/README.md)
5. [Platform Binary Verification](platform-binary-verification/README.md)

## 도메인 완료 기준

- default deny NetworkPolicy와 필요한 allow policy를 만들 수 있다.
- kube-bench 또는 CIS benchmark 결과를 읽고 위험 항목을 분류할 수 있다.
- TLS Secret을 연결한 Ingress 흐름을 설명할 수 있다.
- cloud metadata endpoint 접근 제한 패턴을 설명할 수 있다.
- Kubernetes binary checksum/signature 검증 절차를 설명할 수 있다.
