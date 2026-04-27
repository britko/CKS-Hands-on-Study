# Mock Exam Set 04

제한 시간: 120분

범위: CKS v1.34 전체 도메인

## 진행 규칙

- `questions.md`만 보고 푼다.
- 막힌 문제는 표시하고 넘어간다.
- 마지막 15분은 검증 명령에 사용한다.

## Questions

1. Cluster Setup: namespace에 default deny ingress/egress 정책을 적용하고 DNS만 허용하는 정책 설계를 작성하라.
2. Cluster Setup: Ingress TLS Secret 생성과 Ingress 연결 절차를 작성하라.
3. Cluster Hardening: ServiceAccount `viewer`에 Pod read-only 권한만 부여하라.
4. Cluster Hardening: `system:anonymous`가 API resource를 볼 수 있는지 검증하라.
5. System Hardening: kubelet read-only port, anonymous auth, authorization mode 확인 명령을 작성하라.
6. System Hardening: 노드에서 열린 포트와 실행 서비스를 점검하라.
7. Microservice: namespace에 PSA `restricted`를 적용하고 안전한 Pod SecurityContext를 작성하라.
8. Microservice: Secret 조회 권한을 특정 ServiceAccount로 제한하라.
9. Microservice: RuntimeClass를 사용하는 sandboxed Pod 예시를 작성하라.
10. Supply Chain: 이미지 취약점 스캔, SBOM 생성, signing 검증 흐름을 작성하라.
11. Supply Chain: manifest static analysis에서 찾을 위험 설정 5개를 쓰라.
12. Monitoring/Runtime: audit policy에서 Secret은 Metadata, ConfigMap patch는 RequestResponse로 기록하는 이유를 설명하라.
13. Monitoring/Runtime: Falco 이벤트를 보고 Pod와 command를 조사하는 명령을 작성하라.
14. Monitoring/Runtime: runtime immutability를 위한 SecurityContext를 작성하라.
15. Final: 실패한 문제를 도메인별로 태그하고 재학습 랩 경로를 적어라.
