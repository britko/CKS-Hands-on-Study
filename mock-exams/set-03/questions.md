# Mock Exam Set 03

제한 시간: 60분

범위: Supply Chain Security + Monitoring/Runtime

## Question 1: SBOM

`nginxinc/nginx-unprivileged:1.27-alpine` 이미지의 SBOM을 생성하고, SBOM과 취약점 스캔 결과의 차이를 설명하라.

## Question 2: Static Analysis

`labs/06-image-security/manifests/image-security.yaml`에서 정적 분석 도구가 지적할 수 있는 위험 설정을 3개 이상 찾고 수정 방향을 적어라.

## Question 3: Audit Policy

Secret 요청을 `Metadata` 수준으로 기록하고, ConfigMap patch 요청은 `RequestResponse`로 기록하는 audit policy를 설명하라.

## Question 4: Runtime Immutability

container가 실행 중 root filesystem을 변경하지 못하도록 SecurityContext 필드를 작성하라.

## Question 5: Incident Investigation

Falco 이벤트에 `namespace=cks-falco`, `pod=falco-target`, `command=cat /etc/shadow`가 보인다. 조사 순서와 재발 방지 설정을 작성하라.
