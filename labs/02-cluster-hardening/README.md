# 02. Cluster Hardening

공식 CKS v1.34 Cluster Hardening 도메인은 RBAC, ServiceAccount, Kubernetes API 접근 제한, 취약점 회피를 위한 upgrade 관점을 다룹니다.

## 학습 순서

1. [RBAC와 ServiceAccount](rbac-serviceaccount/README.md)
2. [API Access Restriction](api-access/README.md)
3. [Upgrade Security Checklist](upgrade-security/README.md)

## 도메인 완료 기준

- `kubectl auth can-i --as ...`로 권한을 검증할 수 있다.
- default ServiceAccount와 token automount 위험을 설명할 수 있다.
- anonymous access, authorization mode, admission plugin 확인 포인트를 안다.
- 보안 취약점 회피 관점에서 Kubernetes upgrade 필요성을 설명할 수 있다.
