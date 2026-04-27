# CKS Hands-on Labs

각 랩은 로컬 `kind` 클러스터에서 실행하는 것을 기준으로 합니다. 시험 환경과 완전히 같지는 않지만, CKS에서 반복적으로 요구되는 보안 리소스 작성과 검증 흐름을 연습할 수 있도록 구성했습니다.

## 진행 순서

0. [Environment](00-environment/README.md)
1. [Cluster Setup](01-cluster-setup/README.md)
2. [Cluster Hardening](02-cluster-hardening/README.md)
3. [System Hardening](03-system-hardening/README.md)
4. [Minimize Microservice Vulnerabilities](04-microservice-vulnerabilities/README.md)
5. [Supply Chain Security](05-supply-chain-security/README.md)
6. [Monitoring, Logging and Runtime Security](06-monitoring-logging-runtime/README.md)

## 기존 랩 경로

기존 `01-kind-cluster`부터 `10-falco-detection`까지의 폴더는 참고용 legacy 경로로 남겨둡니다. 새 학습 흐름에서는 위 도메인별 경로를 먼저 사용합니다.

## 시험 환경과 kind 환경 차이

- kind는 로컬 Docker container 기반이라 control plane manifest, kubelet, etcd, host OS 하드닝이 실제 시험 환경과 다를 수 있습니다.
- Cilium/Falco 랩은 네트워크/런타임 보안 이해를 강화하기 위한 실습이며, 최종 검증은 [killer.sh CKS simulator](https://killer.sh/cks)나 시험 유사 환경에서 진행하는 것을 권장합니다.
- Kubernetes 표준 리소스 문제는 공식 문서와 `kubectl explain`으로 빠르게 확인하는 연습을 병행합니다.

## 공통 명령

현재 컨텍스트 확인:

```powershell
kubectl config current-context
kubectl get nodes
```

전체 실습 네임스페이스 정리:

```powershell
kubectl delete ns cks-rbac cks-psa cks-netpol cks-secrets cks-image cks-audit cks-runtime cks-cilium cks-falco --ignore-not-found
```
