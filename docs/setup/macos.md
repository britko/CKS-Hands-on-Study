# macOS 셋업

macOS에서는 Docker Desktop을 권장합니다. Colima도 가능하지만 Cilium/Falco의 eBPF 관련 동작은 VM 설정에 따라 달라질 수 있습니다.

## 설치

Homebrew 사용 예시:

```bash
brew install kubectl kind helm
brew install trivy
```

Docker Desktop을 설치하고 실행합니다.

```bash
docker version
```

## 공식 설치 링크

- [Docker Desktop for Mac](https://docs.docker.com/desktop/setup/install/mac-install/)
- [kubectl 설치](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/)
- [kind 설치](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [Helm 설치](https://helm.sh/docs/intro/install/)
- [Cilium CLI](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli)
- [Falco on Kubernetes](https://falco.org/docs/setup/kubernetes/)
- [Trivy 설치](https://aquasecurity.github.io/trivy/latest/getting-started/installation/)
- [Cosign 설치](https://docs.sigstore.dev/cosign/installation/)

## 사전 확인

```bash
./scripts/verify-tools.sh
docker info
```

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

## Falco 설치

```bash
./scripts/install-falco.sh
kubectl get pods -n falco
```

## macOS 주의사항

- 실제 커널은 Docker Desktop Linux VM이므로 Falco 이벤트와 eBPF 제약은 macOS 커널이 아니라 VM 설정을 따릅니다.
- Colima를 쓰는 경우 VM runtime과 privilege 설정에 따라 Falco가 정상 동작하지 않을 수 있습니다.
- 실제 시험은 원격 Linux desktop이므로 [killer.sh](https://killer.sh/cks)에서 터미널 조작과 문서 검색 흐름을 따로 연습합니다.
- Hubble UI를 사용할 때는 port-forward로 접근합니다.

```bash
kubectl -n kube-system port-forward svc/hubble-ui 12000:80
```
