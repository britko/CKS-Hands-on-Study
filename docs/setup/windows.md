# Windows 셋업

Windows에서는 PowerShell 7과 Docker Desktop WSL2 backend를 권장합니다. 실습 명령은 PowerShell과 Bash가 모두 가능하지만, 이 문서는 PowerShell 기준입니다.

## 설치

필수 도구:

```powershell
winget install Docker.DockerDesktop
winget install Kubernetes.kubectl
winget install Kubernetes.kind
winget install Helm.Helm
```

선택 도구:

```powershell
winget install AquaSecurity.Trivy
```

Cilium CLI와 Cosign은 GitHub release 또는 패키지 매니저로 설치합니다. 없어도 기본 랩은 `kubectl`과 `helm`으로 진행할 수 있습니다.

## 공식 설치 링크

- [Docker Desktop for Windows](https://docs.docker.com/desktop/setup/install/windows-install/)
- [kubectl 설치](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)
- [kind 설치](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [Helm 설치](https://helm.sh/docs/intro/install/)
- [Cilium CLI](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli)
- [Falco on Kubernetes](https://falco.org/docs/setup/kubernetes/)
- [Trivy 설치](https://aquasecurity.github.io/trivy/latest/getting-started/installation/)
- [Cosign 설치](https://docs.sigstore.dev/cosign/installation/)

## 사전 확인

Docker Desktop을 실행한 뒤 확인합니다.

```powershell
.\scripts\verify-tools.ps1
docker info
```

## 클러스터 생성

```powershell
.\scripts\create-kind-cluster.ps1
```

확인:

```powershell
kubectl get nodes
kubectl -n kube-system rollout status ds/cilium
kubectl -n kube-system get pods -l k8s-app=cilium
```

## Falco 설치

```powershell
.\scripts\install-falco.ps1
kubectl get pods -n falco
```

## Windows 주의사항

- Docker Desktop이 꺼져 있으면 `kind create cluster`가 실패합니다.
- VPN 또는 보안 제품이 Docker 네트워크를 차단하면 Cilium/Hubble Pod가 준비되지 않을 수 있습니다.
- Falco는 Docker Desktop의 Linux VM 커널 위에서 동작하므로 Linux bare metal과 이벤트가 다르게 보일 수 있습니다.
- 실제 CKS 시험 환경은 Windows가 아니라 원격 Linux desktop/terminal이므로 [killer.sh](https://killer.sh/cks)에서 키보드, 터미널, 문서 검색 흐름을 반드시 확인합니다.
- 스크립트 실행이 막히면 현재 세션에서만 다음을 사용합니다.

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
