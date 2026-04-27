# Mock Exam Set 02 Solutions

## Question 1

```bash
kubectl -n kube-system rollout status ds/cilium
kubectl -n kube-system rollout status deployment/hubble-relay
cilium hubble port-forward
hubble observe --namespace exam-cilium --last 10
```

Hubble output에서 source, destination, verdict를 확인한다.

## Question 2

```bash
kubectl apply -f mock-exams/set-02/manifests/cilium-network-policy.yaml
kubectl exec -n exam-cilium deploy/client -- wget -qO- --timeout=3 http://api/public
kubectl exec -n exam-cilium deploy/client -- wget -qO- --timeout=3 http://api/admin
```

시험에서는 namespace가 다르면 YAML의 namespace를 맞춰야 한다. CiliumNetworkPolicy는 Cilium CRD이므로 `kubectl get crd | grep cilium`으로 확인한다.

## Question 3

```bash
kubectl get pod risky -n exam-image -o yaml
kubectl get pod secure -n exam-image -o yaml
kubectl exec -n exam-image secure -- id
```

`secure` Pod에는 다음 필드가 필요하다.

```yaml
securityContext:
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
containers:
  - securityContext:
      allowPrivilegeEscalation: false
      capabilities:
        drop: ["ALL"]
```

## Question 4

```bash
kubectl exec -n exam-falco falco-target -- sh -c "id"
kubectl exec -n exam-falco falco-target -- sh -c "cat /etc/shadow || true"
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=10m | grep -E "exam-falco|falco-target"
```

이벤트에서 rule, priority, namespace, pod, container, command를 확인한다.

## Question 5

Secret 요청을 `RequestResponse`로 기록하면 요청/응답 본문에 민감 데이터가 남을 수 있다. 따라서 Secret은 보통 `Metadata` 수준으로 누가 어떤 Secret에 접근했는지만 기록한다.
