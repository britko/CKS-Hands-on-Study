# CKS 개념 목차

이 문서는 CKS 시험 범위를 빠르게 복습하기 위한 출발점입니다. 각 개념 문서는 실습 랩과 연결되며, 시험에서 확인해야 하는 핵심 명령과 판단 기준을 포함합니다.

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

- [클러스터 설정과 강화](concepts/cluster-setup-hardening.md)
- [클러스터 하드닝](concepts/cluster-hardening.md)
- [시스템 하드닝](concepts/system-hardening.md)
- [마이크로서비스 취약점 최소화](concepts/microservice-vulnerabilities.md)
- [공급망 보안](concepts/supply-chain-security.md)
- [모니터링, 로깅, 런타임 보안](concepts/monitoring-runtime-security.md)
- [Cilium 네트워크 보안](concepts/cilium-network-security.md)
- [Falco 런타임 보안](concepts/falco-runtime-security.md)

## 실습과 연결되는 주제

- RBAC: [labs/02-rbac-serviceaccount](../labs/02-rbac-serviceaccount/README.md)
- Pod Security: [labs/03-pod-security](../labs/03-pod-security/README.md)
- NetworkPolicy: [labs/04-network-policy](../labs/04-network-policy/README.md)
- Secret: [labs/05-secrets](../labs/05-secrets/README.md)
- 이미지 보안: [labs/06-image-security](../labs/06-image-security/README.md)
- Audit와 Runtime Security: [labs/07-audit-logging](../labs/07-audit-logging/README.md), [labs/08-runtime-security](../labs/08-runtime-security/README.md)
- Cilium: [labs/09-cilium-network-security](../labs/09-cilium-network-security/README.md)
- Falco: [labs/10-falco-detection](../labs/10-falco-detection/README.md)

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
