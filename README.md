# CKS Hands-on Study

CKS(Certified Kubernetes Security Specialist) 합격을 목표로 Kubernetes 보안 개념, 시험형 문제, `kind` 기반 hands-on 실습을 한 번에 연습하는 저장소입니다. 기본 CNI는 Cilium이며, NetworkPolicy, CiliumNetworkPolicy, Hubble, Falco 런타임 탐지까지 포함합니다.

## 학습 목표

- CKS 도메인을 단순 암기가 아니라 실제 명령과 검증 흐름으로 익힌다.
- RBAC, Pod Security, NetworkPolicy, Secret, 이미지 보안, audit, runtime security 문제를 제한 시간 안에 해결한다.
- Cilium과 Falco를 로컬 실습 환경에서 직접 설치하고 보안 이벤트를 관찰한다.
- Windows, Linux, macOS 어디서든 같은 랩 순서로 학습한다.

## 빠른 시작

OS별 상세 설치는 [Windows](docs/setup/windows.md), [Linux](docs/setup/linux.md), [macOS](docs/setup/macos.md)를 참고합니다.
컨테이너 런타임은 Docker와 Podman 중 하나만 준비하면 됩니다. 제공 스크립트는 Docker가 정상 동작하면 Docker를 쓰고, Docker가 없거나 응답하지 않으면 Podman으로 전환합니다.

Windows PowerShell:

```powershell
.\scripts\verify-tools.ps1
.\scripts\create-kind-cluster.ps1
```

Linux/macOS Bash:

```bash
./scripts/verify-tools.sh
./scripts/create-kind-cluster.sh
```

클러스터 확인:

```bash
kubectl config current-context
kubectl get nodes
kubectl -n kube-system rollout status ds/cilium
kubectl -n kube-system get pods -l k8s-app=cilium
```

`cilium` CLI는 선택 도구입니다. 설치되어 있으면 추가 상태 확인에 사용하고, 없어도 `kubectl`/Helm rollout 검증이 통과하면 기본 랩 진행에는 문제가 없습니다. Hubble flow 관찰도 CLI가 없으면 Hubble UI로 대체합니다.

기본 Cilium 설치는 로컬 kind 안정성을 위해 L7 proxy를 끕니다. HTTP path 기반 CiliumNetworkPolicy 실습은 해당 랩에서 안내하는 선택 옵션으로 L7 proxy를 켠 환경에서 진행합니다.

클러스터 준비가 끝나면 아래 `추천 학습 순서`의 1번부터 진행합니다.

실습을 모두 마친 뒤에는 클러스터를 삭제합니다.

```powershell
.\scripts\delete-kind-cluster.ps1
```

```bash
./scripts/delete-kind-cluster.sh
```

## 추천 학습 순서

공식 CKS v1.34 도메인 순서로 진행합니다.

1. [01. Cluster Setup](labs/01-cluster-setup/README.md): NetworkPolicy, CIS benchmark, Ingress TLS, metadata endpoint, binary verification
2. [02. Cluster Hardening](labs/02-cluster-hardening/README.md): RBAC, ServiceAccount, API access, upgrade checklist
3. [03. System Hardening](labs/03-system-hardening/README.md): kubelet, Linux surface reduction, AppArmor, seccomp
4. [04. Minimize Microservice Vulnerabilities](labs/04-microservice-vulnerabilities/README.md): Pod Security, Secret, isolation, RuntimeClass, Cilium encryption
5. [05. Supply Chain Security](labs/05-supply-chain-security/README.md): image hardening, SBOM, Cosign, Kubesec, KubeLinter
6. [06. Monitoring, Logging and Runtime Security](labs/06-monitoring-logging-runtime/README.md): audit, Falco, runtime immutability, incident investigation
7. [Mock Exam](mock-exams/README.md)을 제한 시간 안에 풀고 해설로 복기한다.

## 공식 시험 정보와 시뮬레이터

이 저장소는 합격 가능성을 높이기 위한 hands-on 베이스입니다. 최종 준비는 공식 시험 범위, Kubernetes 공식 문서 검색 훈련, killer.sh 같은 시험 유사 환경으로 검증해야 합니다.

- [CNCF CKS 공식 페이지](https://www.cncf.io/certification/cks): 시험 개요, 도메인 비중, 공식 리소스 확인
- [Linux Foundation CKS 페이지](https://training.linuxfoundation.org/certification/certified-kubernetes-security-specialist/): 시험 세부 정보, Kubernetes 버전, simulator 포함 여부 확인
- [CNCF curriculum](https://github.com/cncf/curriculum): 공개 커리큘럼과 최신 변경 확인
- [killer.sh CKS simulator](https://killer.sh/cks): 시험과 유사한 120분 실습 환경
- [killer.sh FAQ](https://killer.sh/faq): simulator 세션, 환경, 포함 여부 확인

권장 활용 루틴:

1. 시험 2주 전: killer.sh 1차를 제한 시간 안에 풀고, 틀린 문제를 이 저장소의 관련 랩으로 되돌아가 재실습한다.
2. 시험 1주 전: [Mock Exam](mock-exams/README.md)을 2회 이상 풀고, 실패 원인을 공식 문서 링크와 함께 정리한다.
3. 시험 2~3일 전: killer.sh 2차를 풀고, 남은 약점만 짧게 반복한다.
4. 시험 전날: 새 내용을 늘리지 말고 `kubectl` 단축 명령, 공식 문서 검색 키워드, 자주 틀린 YAML 필드만 복습한다.

## CKS v1.34 도메인

- Cluster Setup: 15%
- Cluster Hardening: 15%
- System Hardening: 10%
- Minimize Microservice Vulnerabilities: 20%
- Supply Chain Security: 20%
- Monitoring, Logging and Runtime Security: 20%

## 시험 연습 원칙

- `kubectl explain`, `kubectl auth can-i`, `kubectl run --dry-run=client -o yaml`, `kubectl patch`, `kubectl get -o jsonpath`를 손에 익힌다.
- `task.md`를 먼저 풀고, 막히면 `hints.md`, 마지막에 `solution.md`를 본다.
- 리소스 생성 후 반드시 허용/차단/탐지 결과를 검증한다.
- kind에서 재현하기 어려운 control plane/노드 하드닝은 실제 시험 환경 차이를 문서에서 확인한다.
- 시험 중에는 쉬운 문제를 먼저 풀고, 막힌 문제는 표시한 뒤 마지막에 돌아온다.
- 공식 문서는 URL을 외우기보다 `rbac`, `pod security admission`, `networkpolicy`, `audit logging`, `secrets good practices` 같은 검색 키워드를 손에 익힌다.
