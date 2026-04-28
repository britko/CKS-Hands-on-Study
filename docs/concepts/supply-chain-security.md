# 공급망 보안

공급망 보안은 컨테이너 이미지가 빌드되고 배포되기 전까지의 신뢰를 다룹니다. CKS에서는 취약 이미지 사용을 줄이고, 안전한 이미지 실행 정책을 Kubernetes 리소스에 반영하는 능력이 중요합니다.

## 핵심 개념

- 이미지 태그 `latest`는 재현성을 떨어뜨린다.
- 취약점 스캔 도구로 알려진 CVE를 확인한다.
- 이미지 서명과 검증은 배포 전 신뢰 체인을 강화한다.
- Admission 정책은 허용된 registry, 서명된 이미지, root 실행 금지 같은 규칙을 강제할 수 있다.

## 실무 도구 예시

- Trivy: 이미지와 파일시스템 취약점 스캔
- Cosign: 이미지 서명과 검증
- Kyverno, OPA Gatekeeper: admission policy

## 시험 포인트

- CKS 시험 환경에서 특정 도구가 제공되면 사용법을 빠르게 확인한다.
- 이미지 이름, 태그, digest를 정확히 구분한다.
- Kubernetes YAML에서 실행 보안을 보완해야 한다.
- 취약점 스캔 결과는 심각도와 fix 가능 여부를 함께 본다.

## 시험에서 나오는 작업

- Trivy로 이미지의 HIGH/CRITICAL 취약점을 확인한다.
- `latest` 태그를 명시적 버전 또는 digest로 바꾼다.
- root/privileged 실행을 non-root와 최소 권한 실행으로 바꾼다.
- 이미지 registry, tag, digest 정보를 빠르게 찾는다.

## 실수 포인트

- 이미지 스캔만 하고 Kubernetes 실행 권한을 그대로 둔다.
- digest 고정을 하지 않아 재현 가능한 배포가 되지 않는다.
- `runAsNonRoot`와 실제 이미지 USER의 관계를 확인하지 않는다.
- admission 정책은 클러스터에 설치된 도구에 따라 리소스 종류가 달라진다는 점을 놓친다.

## 연결 실습

- [Image Security](../../labs/05-supply-chain-security/image-security/README.md)

## 공식 문서와 추가 학습

- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [Cosign Documentation](https://docs.sigstore.dev/cosign/)
- [Kubernetes Image Names](https://kubernetes.io/docs/concepts/containers/images/)
- [Validating Admission Policy](https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/)
- [Kubernetes Policies](https://kubernetes.io/docs/concepts/policy/)
