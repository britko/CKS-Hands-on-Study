# 09. Cilium 네트워크 보안

## 목표

- Kubernetes NetworkPolicy와 CiliumNetworkPolicy의 차이를 이해한다.
- DNS egress와 HTTP L7 정책을 Cilium으로 제한한다.
- Hubble로 허용/차단 흐름을 관찰한다.

## 배경 개념

Cilium은 eBPF 기반 CNI입니다. 표준 NetworkPolicy를 강제할 수 있고, CiliumNetworkPolicy를 사용하면 DNS 이름, HTTP method/path 같은 L7 조건까지 정책에 넣을 수 있습니다.

이 저장소의 기본 bootstrap은 Windows/Podman/WSL2 호환성을 우선해 Cilium L7 proxy를 끈 상태로 설치합니다. 아래 HTTP path 정책까지 실제로 검증하려면 호환되는 Linux kernel 또는 Docker 기반 환경에서 L7 proxy를 명시적으로 켜고 클러스터를 준비합니다.

```powershell
.\scripts\delete-kind-cluster.ps1
.\scripts\create-kind-cluster.ps1 -EnableCiliumL7Proxy
```

```bash
ENABLE_CILIUM_L7_PROXY=true ./scripts/create-kind-cluster.sh
```

L7 proxy를 켜기 어려운 환경에서는 이 랩을 CiliumNetworkPolicy YAML 구조 학습으로 진행하고, 표준 NetworkPolicy 실습은 [NetworkPolicy](../04-network-policy/README.md)에서 완료합니다.

## 실습

애플리케이션과 Cilium 정책을 적용합니다.

```bash
kubectl apply -f labs/09-cilium-network-security/manifests/app.yaml
kubectl apply -f labs/09-cilium-network-security/manifests/cilium-network-policy.yaml
```

허용된 HTTP path:

```bash
kubectl exec -n cks-cilium deploy/client -- wget -qO- --timeout=3 http://api/public
```

차단되어야 하는 HTTP path:

```bash
kubectl exec -n cks-cilium deploy/client -- wget -qO- --timeout=3 http://api/admin
```

Hubble flow 확인:

```bash
kubectl -n kube-system port-forward svc/hubble-ui 12000:80
```

브라우저에서 `http://localhost:12000`에 접속해 `cks-cilium` flow를 확인합니다. `cilium`/`hubble` CLI가 설치되어 있다면 `cilium hubble port-forward`와 `hubble observe --namespace cks-cilium --last 30`로도 확인할 수 있습니다.

## 검증

- `/public` 요청은 성공해야 합니다.
- `/admin` 요청은 정책에 의해 거부되어야 합니다.
- Hubble에서 forwarded 또는 dropped flow를 확인합니다.

## 시험 전 확인할 문서

- [Cilium Network Policy](https://docs.cilium.io/en/stable/security/policy/)
- [Cilium Kubernetes Policy](https://docs.cilium.io/en/stable/network/kubernetes/policy/)
- [Hubble Observability](https://docs.cilium.io/en/stable/observability/hubble/)
- [Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

## 정리

```bash
kubectl delete -f labs/09-cilium-network-security/manifests/cilium-network-policy.yaml
kubectl delete -f labs/09-cilium-network-security/manifests/app.yaml
```

## 시험 팁

- CKS의 기본 범위는 표준 Kubernetes 보안이 중심이지만, Cilium 같은 CNI 보안 기능은 실무형 심화 주제로 중요합니다.
- 표준 NetworkPolicy로 해결 가능한 문제와 CiliumNetworkPolicy가 필요한 문제를 구분합니다.
- Hubble은 정책 디버깅에서 "정책이 맞는지"보다 "패킷이 실제 어디서 막혔는지"를 보여줍니다.
