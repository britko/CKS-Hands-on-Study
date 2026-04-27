# Secrets

기존 [Secret 관리 랩](../../05-secrets/README.md)을 Microservice Vulnerabilities 도메인의 Secret 관리 항목으로 배치합니다.

## 바로 가기

- [README](../../05-secrets/README.md)
- [Manifest](../../05-secrets/manifests/secrets.yaml)

## 시험 포인트

- Secret은 base64 인코딩일 뿐 암호화가 아니다.
- Secret 조회 권한은 최소화한다.
- etcd encryption at rest는 클러스터 설정으로 별도 확인한다.
