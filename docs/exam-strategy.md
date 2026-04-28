# CKS 실전 학습 로드맵

이 문서는 이 저장소의 랩, Kubernetes 공식 문서, killer.sh를 함께 사용해 시험 준비 완성도를 높이는 로드맵입니다. 어떤 자료도 합격을 보장하지는 않지만, 제한 시간 안에 손으로 해결하는 훈련을 반복하면 합격 가능성을 크게 높일 수 있습니다.

## 4주 학습 루틴

### 4주 전: 기본기와 환경

- [셋업 가이드](setup/README.md)로 로컬 `kind`와 Cilium 환경을 만든다.
- [Cluster Setup](../labs/01-cluster-setup/README.md)부터 [Microservice Vulnerabilities](../labs/04-microservice-vulnerabilities/README.md)까지 따라 한다.
- [Kubernetes Security](https://kubernetes.io/docs/concepts/security/)를 훑고 시험 도메인 이름과 연결한다.

### 3주 전: 시험형 문제 전환

- `task.md`만 보고 RBAC, Pod Security, NetworkPolicy, 이미지 보안 문제를 푼다.
- 막힌 문제는 `hints.md`까지만 보고 다시 시도한다.
- `solution.md`를 본 뒤 같은 문제를 5분 안에 다시 푼다.

### 2주 전: killer.sh 1차

- [killer.sh CKS simulator](https://killer.sh/cks)를 120분 제한으로 1차 진행한다.
- 틀린 문제를 도메인별로 태그한다: RBAC, PSA, NetworkPolicy, Supply Chain, Audit, Runtime.
- 틀린 문제와 연결되는 이 저장소 랩으로 돌아가 다시 실습한다.
- killer.sh 해설을 그대로 외우지 말고 [Kubernetes 공식 문서](https://kubernetes.io/docs/home/)에서 관련 문서를 찾아본다.

### 1주 전: mock exam과 약점 보강

- [Mock Exam Set 01](../mock-exams/set-01/questions.md), [Set 02](../mock-exams/set-02/questions.md)를 각각 60분 제한으로 푼다.
- 실패한 명령은 별도 메모에 “원인, 빠른 명령, 공식 문서 링크”로 정리한다.
- Cilium/Falco 실습은 이해 보강용으로 활용한다. Falco는 [Falco Detection](../labs/06-monitoring-logging-runtime/falco-detection/README.md) 랩 직전에 설치하고, 실제 CKS 기본 범위는 Kubernetes 표준 리소스 중심으로 다시 확인한다.

### 2~3일 전: killer.sh 2차

- killer.sh 2차를 시험처럼 진행한다.
- 새 주제를 늘리지 말고 실패한 문제만 다시 푼다.
- control plane, kubelet, etcd, audit처럼 kind에서 한계가 있는 주제를 우선 복기한다.

### 전날

- 새 도구를 설치하거나 긴 실습을 시작하지 않는다.
- `kubectl` 기본 명령, 공식 문서 검색 키워드, 자주 틀린 YAML 필드만 확인한다.
- 시험 환경에서 사용할 alias나 편집기 설정은 시험 정책에 맞는 범위에서만 준비한다.

## 시험 중 시간 배분

- 첫 10분: 전체 문제를 훑고 쉬운 문제를 표시한다.
- 60~80분: 쉬운 문제와 중간 난이도 문제를 먼저 해결한다.
- 남은 시간: 막힌 문제로 돌아가고, 이미 푼 문제의 검증 명령을 실행한다.
- 한 문제에 8~10분 이상 막히면 표시하고 넘어간다.

## 공식 문서 검색 키워드

- RBAC: `kubernetes rbac role rolebinding serviceaccount`
- Pod Security: `pod security admission restricted securitycontext`
- NetworkPolicy: `networkpolicy default deny egress dns`
- Secret: `kubernetes secrets good practices encryption at rest`
- Audit: `kubernetes audit policy apiserver`
- Admission: `kubernetes admission controllers validating admission policy`
- Runtime: `falco rules kubernetes`

## 랩과 CKS 도메인 매핑

- Cluster Setup: [labs/01-cluster-setup](../labs/01-cluster-setup/README.md)
- Cluster Hardening: [labs/02-cluster-hardening](../labs/02-cluster-hardening/README.md)
- System Hardening: [labs/03-system-hardening](../labs/03-system-hardening/README.md)
- Minimize Microservice Vulnerabilities: [labs/04-microservice-vulnerabilities](../labs/04-microservice-vulnerabilities/README.md)
- Supply Chain Security: [labs/05-supply-chain-security](../labs/05-supply-chain-security/README.md)
- Monitoring, Logging and Runtime Security: [labs/06-monitoring-logging-runtime](../labs/06-monitoring-logging-runtime/README.md)
