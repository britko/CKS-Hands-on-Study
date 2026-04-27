# 05. Supply Chain Security

공식 CKS v1.34 Supply Chain Security 도메인은 base image 최소화, SBOM/CI/CD/artifact repository 이해, signing/verification, static analysis를 다룹니다.

## 학습 순서

1. [Image Security](image-security/README.md)
2. [SBOM](sbom/README.md)
3. [Cosign Sign and Verify](cosign-sign-verify/README.md)
4. [Kubesec and KubeLinter](kubesec-kubelinter/README.md)
5. [Permitted Registries](permitted-registries/README.md)

## 도메인 완료 기준

- 이미지 태그, digest, base image 최소화 기준을 설명할 수 있다.
- Trivy로 취약점을 확인하고 결과를 해석할 수 있다.
- SBOM과 image signing의 목적을 설명할 수 있다.
- manifest static analysis 결과를 보고 수정 방향을 제시할 수 있다.
