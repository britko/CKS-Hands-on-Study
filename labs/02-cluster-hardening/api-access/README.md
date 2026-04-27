# API Access Restriction

## 목표

- Kubernetes API 접근 제한을 인증/인가 관점에서 점검한다.
- anonymous access와 authorization mode 확인 포인트를 익힌다.

## 확인 명령

```bash
kubectl auth can-i get pods
kubectl auth can-i '*' '*' --as system:anonymous
kubectl get --raw /readyz
kubectl get --raw /livez
```

control plane 노드에서는 API server 인자를 확인합니다.

```bash
sudo grep -E "anonymous-auth|authorization-mode|enable-admission-plugins" /etc/kubernetes/manifests/kube-apiserver.yaml
```

## 시험형 문제

1. `system:anonymous`가 API resource를 조회할 수 있는지 확인한다.
2. API server manifest에서 authorization mode를 확인한다.
3. 위험한 설정이 있으면 어떤 flag를 수정해야 하는지 설명한다.

## kind 한계

kind에서는 control plane manifest 경로가 실제 시험과 다릅니다. 실제 수정은 [kubeadm control plane 대비 문서](../../../docs/exam-env/kubeadm-control-plane.md)와 killer.sh에서 연습합니다.
