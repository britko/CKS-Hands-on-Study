# CKS 개념 목차

이 문서는 CKS 시험 범위를 학습하기 위한 개념 출발점입니다. 각 도메인 문서를 먼저 읽고 연결된 실습 랩을 수행하면, 단순 문제 풀이가 아니라 보안 설정의 이유와 검증 흐름을 함께 익힐 수 있습니다.

## 공식 문서 인덱스

- [CNCF CKS 공식 페이지](https://www.cncf.io/certification/cks)
- [Linux Foundation CKS 페이지](https://training.linuxfoundation.org/certification/certified-kubernetes-security-specialist/)
- [CNCF curriculum](https://github.com/cncf/curriculum)
- [Kubernetes Security](https://kubernetes.io/docs/concepts/security/)
- [Kubernetes Policies](https://kubernetes.io/docs/concepts/policy/)
- [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)
- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Kubernetes Audit](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)

## 시험 도메인별 개념

- [01. Cluster Setup](concepts/01-cluster-setup.md): 15%
- [02. Cluster Hardening](concepts/02-cluster-hardening.md): 15%
- [03. System Hardening](concepts/03-system-hardening.md): 10%
- [04. Minimize Microservice Vulnerabilities](concepts/04-microservice-vulnerabilities.md): 20%
- [05. Supply Chain Security](concepts/05-supply-chain-security.md): 20%
- [06. Monitoring, Logging and Runtime Security](concepts/06-monitoring-logging-runtime.md): 20%

권장 흐름:

1. 도메인 개념 문서에서 공격면, 동작 원리, 자주 틀리는 필드를 읽는다.
2. 연결 실습 랩에서 같은 내용을 직접 적용하고 검증한다.
3. Mock exam에서 제한 시간 안에 같은 유형을 다시 푼다.
4. 실패한 문제는 해당 도메인 개념 문서의 실수 포인트로 돌아가 복기한다.

## 실습과 연결되는 주제

- Cluster Setup: [labs/01-cluster-setup](../labs/01-cluster-setup/README.md)
- Cluster Hardening: [labs/02-cluster-hardening](../labs/02-cluster-hardening/README.md)
- System Hardening: [labs/03-system-hardening](../labs/03-system-hardening/README.md)
- Microservice Vulnerabilities: [labs/04-microservice-vulnerabilities](../labs/04-microservice-vulnerabilities/README.md)
- Supply Chain Security: [labs/05-supply-chain-security](../labs/05-supply-chain-security/README.md)
- Monitoring/Runtime: [labs/06-monitoring-logging-runtime](../labs/06-monitoring-logging-runtime/README.md)

## 반복 학습 체크리스트

- [ ] namespace, service account, role, role binding을 빠르게 만들 수 있다.
- [ ] privileged/root 컨테이너를 금지하는 설정을 설명할 수 있다.
- [ ] default deny NetworkPolicy를 작성하고 허용 정책을 추가할 수 있다.
- [ ] Secret을 환경 변수와 volume으로 사용할 때의 차이를 설명할 수 있다.
- [ ] 이미지 태그, 실행 사용자, capabilities, read-only filesystem을 점검할 수 있다.
- [ ] audit log와 runtime 탐지의 역할 차이를 설명할 수 있다.
- [ ] CiliumNetworkPolicy와 Hubble로 네트워크 차단 원인을 확인할 수 있다.
- [ ] Falco 이벤트에서 rule, priority, namespace, pod, command를 해석할 수 있다.

## 시험 직전 체크리스트

- [ ] [시험 전략](exam-strategy.md)의 2주 전/2~3일 전 killer.sh 루틴을 완료했다.
- [ ] `kubectl explain`, `kubectl auth can-i`, `kubectl run --dry-run=client -o yaml`, `kubectl patch`, `kubectl get -o jsonpath`를 손으로 입력할 수 있다.
- [ ] 공식 문서에서 RBAC, Pod Security, NetworkPolicy, Audit, Secret 문서를 빠르게 찾을 수 있다.
- [ ] 실패한 mock exam 문제를 관련 랩으로 되돌아가 다시 풀었다.
- [ ] kind에서 어려운 control plane, kubelet, etcd 주제는 killer.sh 또는 시험 유사 환경에서 확인했다.
