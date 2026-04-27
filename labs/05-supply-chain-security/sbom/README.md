# SBOM

## 목표

- SBOM이 이미지 구성 요소 목록임을 이해한다.
- Trivy로 SBOM을 생성하고 취약점 스캔과 구분한다.

## 실습

```bash
trivy image --format cyclonedx --output nginx-sbom.json nginxinc/nginx-unprivileged:1.27-alpine
trivy sbom nginx-sbom.json
```

## 확인 포인트

- package 이름과 version
- license
- image layer와 package 출처
- 취약점 스캔 결과와 SBOM의 차이

## 시험 포인트

- SBOM은 "무엇이 들어 있는가"를 보여준다.
- vulnerability scan은 "알려진 취약점이 있는가"를 보여준다.
- CI/CD와 artifact repository 보안 흐름에서 SBOM을 연결해 설명할 수 있어야 한다.
