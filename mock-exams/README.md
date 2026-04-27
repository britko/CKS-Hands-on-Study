# Mock Exams

실전 감각을 만들기 위한 시간 제한 문제 세트입니다. 먼저 `questions.md`만 보고 풀고, 시간이 끝난 뒤 `solutions.md`로 복기합니다.

## killer.sh 활용

- [killer.sh CKS simulator](https://killer.sh/cks)는 시험과 유사한 120분 실습 환경입니다.
- [killer.sh FAQ](https://killer.sh/faq)에 따르면 Linux Foundation 시험 구매 시 simulator 세션이 포함될 수 있으므로 본인 시험 포털에서 확인합니다.
- 이 저장소의 mock exam은 주제별 반복과 약점 보강용이고, killer.sh는 실제 시험 압박과 환경 적응용입니다.
- killer.sh 점수보다 중요한 것은 틀린 문제를 “어떤 명령을 몰랐는지, 어떤 공식 문서를 못 찾았는지, 어떤 검증을 빠뜨렸는지”로 분해하는 것입니다.

## 진행 방법

1. kind 클러스터와 Cilium/Falco를 준비한다.
2. 각 세트의 `manifests/`를 적용해 문제 환경을 만든다.
3. 타이머를 켜고 `questions.md`만 본다.
4. 완료 후 검증 명령을 실행한다.
5. `solutions.md`를 읽고 더 짧은 명령으로 다시 푼다.

## 4단계 복기 루틴

1. 제한 시간 안에 풀이하고, 못 푼 문제는 그대로 남긴다.
2. 실패 문제에 태그를 붙인다: RBAC, PSA, NetworkPolicy, Secret, Image, Audit, Runtime, Node.
3. 관련 랩으로 돌아가 `task.md`만 보고 다시 푼다.
4. killer.sh 해설, 이 저장소의 `solution.md`, Kubernetes 공식 문서를 함께 보며 원인을 한 줄로 기록한다.

## 시험 전 일정

- 시험 2주 전: killer.sh 1차를 풀고 약점 태그를 만든다.
- 시험 1주 전: 이 저장소의 mock exam을 반복하고 실패한 랩만 재실습한다.
- 시험 2~3일 전: killer.sh 2차를 실제 시험처럼 진행한다.
- 시험 전날: 새 문제를 늘리지 말고, 실패 태그와 공식 문서 검색 키워드만 복습한다.

## 세트

- [Set 01: RBAC, PSA, NetworkPolicy, Secret](set-01/questions.md)
- [Set 02: Cilium, Falco, Image Security, Audit](set-02/questions.md)
