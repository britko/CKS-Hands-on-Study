# 06. Monitoring, Logging and Runtime Security

공식 CKS v1.34 Monitoring, Logging and Runtime Security 도메인은 behavioral analytics, threat detection, incident investigation, runtime immutability, Kubernetes audit logs를 다룹니다.

## 학습 순서

1. [Audit Logging](audit-logging/README.md)
2. [Audit Control Plane](audit-control-plane/README.md)
3. [Runtime Investigation](runtime-investigation/README.md)
4. [Falco Detection](falco-detection/README.md)
5. [Runtime Immutability](runtime-immutability/README.md)
6. [Incident Investigation](incident-investigation/README.md)

Falco는 이 도메인에 들어와서 설치합니다. [Falco Detection](falco-detection/README.md) 랩 시작 전에 `scripts/install-falco.*`를 실행합니다.

## 도메인 완료 기준

- audit policy level과 Secret 로그 노출 위험을 설명할 수 있다.
- Falco 이벤트에서 namespace, pod, container, command, rule을 찾을 수 있다.
- read-only root filesystem과 runtime drift 탐지 관점을 설명할 수 있다.
- audit/event/log를 묶어 의심 행위를 조사할 수 있다.
