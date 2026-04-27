# 셋업 가이드

이 저장소는 로컬 `kind` 클러스터에 Cilium을 기본 CNI로 설치하고, Falco를 추가해 런타임 보안 이벤트를 확인하는 흐름을 기준으로 합니다.

## 공통 도구

- Docker 또는 Docker Desktop
- `kubectl`
- `kind`
- `helm`
- 선택 도구: `cilium`, `hubble`, `trivy`, `cosign`

## 공식 설치 링크

- [Docker Engine](https://docs.docker.com/engine/install/) / [Docker Desktop](https://docs.docker.com/desktop/)
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
```

## OS별 문서

- [Windows](windows.md)
- [Linux](linux.md)
- [macOS](macos.md)
- [Troubleshooting](troubleshooting.md)

## 실습 클러스터 구성

- Kubernetes: kind
- CNI: Cilium
- Observability: Hubble
- Runtime detection: Falco
- Worker nodes: 2

## 권장 순서

1. OS별 문서에 따라 Docker와 CLI 도구를 설치한다.
2. `scripts/verify-tools.*`로 필수 명령을 확인한다.
3. `scripts/create-kind-cluster.*`로 kind 클러스터와 Cilium을 설치한다.
4. `scripts/install-falco.*`로 Falco를 설치한다.
5. `labs/01-kind-cluster`부터 순서대로 진행한다.

## 최종 검증

로컬 kind는 반복 연습에 적합하지만 실제 시험과 완전히 같지 않습니다. control plane manifest, kubelet, etcd, audit 설정은 [killer.sh CKS simulator](https://killer.sh/cks) 또는 kubeadm 기반 환경에서 마지막으로 검증합니다.
