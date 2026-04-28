# Linux 셋업

Linux는 Cilium과 Falco를 가장 실제 클러스터에 가깝게 실습할 수 있는 환경입니다. Docker Engine 또는 Podman, kind, kubectl, Helm을 설치한 뒤 Bash 스크립트로 클러스터를 생성합니다.

## 설치 예시

Ubuntu/Debian 계열:

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
```

Docker Engine 또는 Podman은 배포판 공식 절차에 따라 설치합니다. Docker를 쓰는 경우 현재 사용자가 Docker socket을 사용할 수 있어야 합니다.

```bash
docker version
# 또는
podman version
```

둘 중 하나만 성공하면 됩니다. 스크립트는 Docker가 정상 동작하면 Docker를 쓰고, 그렇지 않으면 Podman을 사용합니다.

`kubectl`, `kind`, `helm`은 각 공식 문서의 최신 설치 절차를 따릅니다.

## 공식 설치 링크

- [Docker Engine 설치](https://docs.docker.com/engine/install/)
- [Podman 설치](https://podman.io/docs/installation)
- [kubectl 설치](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [kind 설치](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [Helm 설치](https://helm.sh/docs/intro/install/)
- [Cilium CLI](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli)
- [Falco on Kubernetes](https://falco.org/docs/setup/kubernetes/)
- [Trivy 설치](https://aquasecurity.github.io/trivy/latest/getting-started/installation/)
- [Cosign 설치](https://docs.sigstore.dev/cosign/installation/)

## 사전 확인

```bash
./scripts/verify-tools.sh
uname -r
docker info
# 또는
podman info
```

Falco의 modern eBPF driver는 커널 기능에 영향을 받습니다. Falco는 초기 클러스터 준비 단계가 아니라 [Falco Detection](../../labs/06-monitoring-logging-runtime/falco-detection/README.md) 랩에 진입할 때 설치합니다. 실패하면 `scripts/install-falco.sh`의 driver 값을 바꾸거나 [Troubleshooting](troubleshooting.md)을 참고합니다.

## 클러스터 생성

```bash
./scripts/create-kind-cluster.sh
```

검증:

```bash
kubectl get nodes
kubectl -n kube-system rollout status ds/cilium
kubectl -n kube-system get pods -l k8s-app=cilium
```

## Linux 주의사항

- rootless Docker 또는 rootless Podman은 kind 네트워크와 eBPF 실습에서 추가 제약이 있을 수 있습니다.
- Docker가 없으면 스크립트가 Podman을 감지하고 `KIND_EXPERIMENTAL_PROVIDER=podman`을 설정합니다.
- cgroup v2와 커널 버전에 따라 Cilium kube-proxy replacement나 Falco driver 동작이 달라질 수 있습니다.
- 이 저장소는 Podman/kind 환경의 service routing 안정성을 위해 Cilium kube-proxy replacement를 사용합니다.
- Linux가 가장 시험 환경에 가깝지만, 실제 CKS의 원격 desktop과 문제 구성은 [killer.sh](https://killer.sh/cks)에서 별도로 적응해야 합니다.
