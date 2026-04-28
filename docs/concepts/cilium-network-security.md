# Cilium 네트워크 보안

Cilium은 eBPF 기반 Kubernetes CNI입니다. CKS 시험 자체는 표준 Kubernetes 보안을 중심으로 하지만, Cilium은 NetworkPolicy 디버깅, L7 정책, 관측성까지 연결해 보안 운영 역량을 높이는 데 유용합니다.

## 시험과 실무에서 보는 작업

- CNI가 NetworkPolicy를 실제로 강제하는지 확인한다.
- default deny 이후 필요한 ingress/egress만 허용한다.
- DNS egress, HTTP path 같은 L7 조건이 필요한 경우 CiliumNetworkPolicy를 사용한다.
- Hubble로 flow가 forwarded인지 dropped인지 확인한다.

## 필수 명령

```bash
kubectl -n kube-system rollout status ds/cilium
kubectl get crd | grep cilium
kubectl get networkpolicy -A
kubectl get ciliumnetworkpolicy -A
kubectl -n kube-system port-forward svc/hubble-ui 12000:80
```

`cilium`과 `hubble` CLI는 선택 도구입니다. 설치되어 있다면 `cilium hubble port-forward`와 `hubble observe --last 20`로 터미널에서 flow를 볼 수 있고, 없으면 Hubble UI로 대체합니다.

## NetworkPolicy와 CiliumNetworkPolicy

- `NetworkPolicy`: Kubernetes 표준 리소스, Pod/namespace selector 기반 L3/L4 제어
- `CiliumNetworkPolicy`: Cilium CRD, DNS, HTTP method/path, FQDN 등 고급 조건 지원
- `Hubble`: 정책 적용 결과와 flow를 관찰하는 도구

로컬 kind 기본 설치는 안정성을 위해 Cilium L7 proxy를 끕니다. HTTP path 기반 정책은 L7 proxy를 켠 심화 환경에서 검증하고, CKS 핵심 범위는 표준 NetworkPolicy 문법과 허용/차단 검증에 집중합니다.

## 실수 포인트

- CNI가 준비되지 않은 상태에서 정책을 테스트한다.
- Service port와 container port를 혼동한다.
- DNS egress를 막아놓고 FQDN 기반 테스트가 실패하는 이유를 놓친다.
- Hubble 로그를 보지 않고 YAML만 보고 정책을 판단한다.

## kind와 실제 클러스터 차이

kind는 Docker 또는 Podman container 위에서 노드가 실행되므로 eBPF, NodePort, host networking 동작이 실제 Linux 노드와 다를 수 있습니다. 이 저장소는 Podman/kind 환경의 service routing 안정성을 위해 Cilium kube-proxy replacement를 사용합니다.

## 연결 실습

- [NetworkPolicy](../../labs/01-cluster-setup/network-policy/README.md)
- [Cilium Policy](../../labs/04-microservice-vulnerabilities/cilium-policy/README.md)

## 공식 문서와 추가 학습

- [Cilium Installation Using Kind](https://docs.cilium.io/en/stable/installation/kind/)
- [Cilium Network Policy](https://docs.cilium.io/en/stable/security/policy/)
- [CiliumNetworkPolicy Reference](https://docs.cilium.io/en/stable/network/kubernetes/policy/)
- [Hubble Observability](https://docs.cilium.io/en/stable/observability/hubble/)
- [Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
