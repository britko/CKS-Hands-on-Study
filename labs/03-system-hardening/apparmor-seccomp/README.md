# AppArmor and Seccomp

## 목표

- seccomp와 AppArmor가 container system call과 host resource 접근을 제한하는 방식을 이해한다.
- Pod spec에서 profile을 지정하는 위치를 익힌다.

## Seccomp 예시

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: seccomp-demo
spec:
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: app
      image: busybox:1.36
      command: ["sh", "-c", "sleep 3600"]
```

## AppArmor 예시

AppArmor는 노드에 profile이 로드되어 있어야 합니다.

```yaml
metadata:
  annotations:
    container.apparmor.security.beta.kubernetes.io/app: runtime/default
```

## 검증 명령

```bash
kubectl get pod seccomp-demo -o yaml
kubectl describe pod seccomp-demo
```

노드에서는 다음을 확인합니다.

```bash
sudo aa-status
```

## 시험 포인트

- seccomp `RuntimeDefault`는 CKS에서 자주 등장한다.
- AppArmor는 profile이 노드에 존재해야 적용된다.
- profile 지정 위치와 container 이름을 맞춰야 한다.
