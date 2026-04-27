# Audit Logging

기존 [Audit Logging 랩](../../07-audit-logging/README.md)을 Monitoring, Logging and Runtime Security 도메인에 배치합니다.

## 바로 가기

- [README](../../07-audit-logging/README.md)
- [Audit Policy](../../07-audit-logging/manifests/audit-policy.yaml)
- [Target Manifest](../../07-audit-logging/manifests/audit-target.yaml)

## 시험 포인트

- Secret 요청은 보통 `Metadata` 수준으로 기록해 민감 데이터 노출을 피한다.
- 실제 시험에서는 API server static Pod manifest와 volume/volumeMount 수정까지 요구될 수 있다.
