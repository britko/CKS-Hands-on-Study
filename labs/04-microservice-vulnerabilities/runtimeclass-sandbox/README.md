# RuntimeClass and Sandboxed Containers

## 목표

- RuntimeClass가 Pod를 다른 runtime handler로 실행하게 하는 리소스임을 이해한다.
- gVisor/Kata 같은 sandboxed runtime의 목적과 시험 확인 포인트를 익힌다.

## 확인 명령

```bash
kubectl get runtimeclass
kubectl describe runtimeclass <name>
kubectl get pod <pod> -o jsonpath="{.spec.runtimeClassName}"
```

## Pod 예시

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sandboxed
spec:
  runtimeClassName: gvisor
  containers:
    - name: app
      image: busybox:1.36
      command: ["sh", "-c", "sleep 3600"]
```

## 시험 포인트

- RuntimeClass 리소스만 만들어도 runtime handler가 노드에 없으면 Pod는 실행되지 않는다.
- sandboxed runtime은 격리를 강화하지만 성능/호환성 비용이 있다.
- 시험에서는 기존 RuntimeClass를 확인하고 Pod에 지정하는 문제가 나올 수 있다.
