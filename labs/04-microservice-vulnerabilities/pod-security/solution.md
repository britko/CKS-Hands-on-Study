# Solution: restricted Pod Security 적용

## 적용

```bash
kubectl apply -f labs/04-microservice-vulnerabilities/pod-security/manifests/namespace.yaml
kubectl apply -f labs/04-microservice-vulnerabilities/pod-security/manifests/privileged-pod.yaml
kubectl apply -f labs/04-microservice-vulnerabilities/pod-security/manifests/restricted-pod.yaml
```

두 번째 명령은 실패해야 정상이다.

## 확인

```bash
kubectl get ns cks-psa --show-labels
kubectl get pods -n cks-psa
kubectl describe pod restricted-nginx -n cks-psa
```

핵심 설정 확인:

```bash
kubectl get pod restricted-nginx -n cks-psa -o jsonpath="{.spec.securityContext.seccompProfile.type}"
kubectl get pod restricted-nginx -n cks-psa -o jsonpath="{.spec.containers[0].securityContext.allowPrivilegeEscalation}"
```

## 해설

`restricted` 정책은 root 실행, privileged, 권한 상승, 기본 seccomp 미설정 같은 위험한 실행 방식을 제한한다. 시험에서는 거부 메시지를 읽고 부족한 필드를 빠르게 보완하는 능력이 중요하다.

## 정리

```bash
kubectl delete -f labs/04-microservice-vulnerabilities/pod-security/manifests/restricted-pod.yaml
kubectl delete -f labs/04-microservice-vulnerabilities/pod-security/manifests/namespace.yaml
```
