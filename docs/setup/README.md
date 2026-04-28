# 셋업 가이드

이 저장소는 로컬 `kind` 클러스터에 Cilium을 기본 CNI로 설치하고, 런타임 보안 랩에서 Falco를 추가해 보안 이벤트를 확인하는 흐름을 기준으로 합니다.

## 공통 도구

- Docker, Docker Desktop 또는 Podman
- `kubectl`
- `kind`
- `helm`
- 선택 도구: `cilium`, `hubble`, `trivy`, `cosign`

`cilium` CLI는 Cilium 상태 확인을 편하게 해주는 선택 도구입니다. 없어도 `kubectl`과 Helm으로 Cilium/Hubble rollout을 검증하므로 기본 랩 진행에는 문제가 없습니다. Hubble flow 관찰은 `hubble` CLI가 있으면 터미널에서 보고, 없으면 Hubble UI로 확인합니다.

## 공식 설치 링크

- [Docker Engine](https://docs.docker.com/engine/install/) / [Docker Desktop](https://docs.docker.com/desktop/)
- [Podman](https://podman.io/docs/installation)
- [kubectl 설치](https://kubernetes.io/docs/tasks/tools/)
- [kind 설치](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [Helm 설치](https://helm.sh/docs/intro/install/)
- [Cilium CLI 설치](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli)
- [Hubble CLI](https://docs.cilium.io/en/stable/observability/hubble/setup/)
- [Falco Kubernetes 설치](https://falco.org/docs/setup/kubernetes/)
- [Trivy 설치](https://aquasecurity.github.io/trivy/latest/getting-started/installation/)
- [Cosign 설치](https://docs.sigstore.dev/cosign/installation/)

도구 확인:

```bash
kubectl version --client
kind version
helm version
docker version
# 또는
podman version
```

Docker와 Podman 중 하나만 정상 동작하면 됩니다. 제공 스크립트는 Docker가 사용 가능하면 Docker를 사용하고, Docker가 없거나 응답하지 않으면 Podman으로 전환합니다. Podman을 사용할 때는 `kind`가 인식하도록 `KIND_EXPERIMENTAL_PROVIDER=podman`을 설정합니다.

기본 Cilium 설치는 로컬 kind 안정성을 위해 L7 proxy를 끕니다. Cilium HTTP path 정책까지 실습할 때만 호환 환경에서 `ENABLE_CILIUM_L7_PROXY=true` 또는 PowerShell의 `-EnableCiliumL7Proxy` 옵션으로 클러스터를 다시 만듭니다.

## OS별 문서

- [Windows](windows.md)
- [Linux](linux.md)
- [macOS](macos.md)
- [Troubleshooting](troubleshooting.md)

## 실습 클러스터 구성

- Kubernetes: kind
- CNI: Cilium
- Observability: Hubble
- Runtime detection: Falco, `06. Monitoring, Logging and Runtime Security`에서 설치
- Worker nodes: 2

## 권장 순서

1. OS별 문서에 따라 Docker 또는 Podman과 CLI 도구를 설치한다.
2. `scripts/verify-tools.*`로 필수 명령을 확인한다.
3. `scripts/create-kind-cluster.*`로 kind 클러스터와 Cilium을 설치한다.
4. 루트 [추천 학습 순서](../../README.md#추천-학습-순서)의 1번인 [Cluster Setup](../../labs/01-cluster-setup/README.md)부터 진행한다.
5. Falco는 [Falco Detection](../../labs/06-monitoring-logging-runtime/falco-detection/README.md) 랩에 진입할 때 설치한다.

## 최종 검증

로컬 kind는 반복 연습에 적합하지만 실제 시험과 완전히 같지 않습니다. control plane manifest, kubelet, etcd, audit 설정은 [killer.sh CKS simulator](https://killer.sh/cks) 또는 kubeadm 기반 환경에서 마지막으로 검증합니다.
