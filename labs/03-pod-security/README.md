# 03. Pod Security와 SecurityContext

## 목표

- namespace에 Pod Security Admission `restricted` 정책을 적용한다.
- 위험한 Pod가 거부되고 안전한 Pod가 허용되는 차이를 확인한다.

## 시험형 연습

- [Task](task.md)
- [Hints](hints.md)
- [Solution](solution.md)

## 배경 개념

Pod Security Admission은 namespace label을 기반으로 Pod 생성 요청을 검사합니다. SecurityContext는 Pod 또는 container가 어떤 사용자와 권한으로 실행될지 선언합니다.

## 실습

namespace와 PSA label 적용:

```powershell
kubectl apply -f labs/03-pod-security/manifests/namespace.yaml
```

위험한 Pod 생성 시도:

```powershell
kubectl apply -f labs/03-pod-security/manifests/privileged-pod.yaml
```

이 명령은 `restricted` 정책 때문에 실패해야 합니다.

안전한 Pod 생성:

```powershell
kubectl apply -f labs/03-pod-security/manifests/restricted-pod.yaml
```

## 검증

```powershell
kubectl get pods -n cks-psa
kubectl describe pod -n cks-psa restricted-nginx
kubectl get events -n cks-psa --sort-by=.lastTimestamp
```

`restricted-nginx`는 `Running`이 되어야 하고, privileged Pod는 생성되지 않아야 합니다.

## 시험 전 확인할 문서

- [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)
- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Configure a Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

## 정리

```powershell
kubectl delete -f labs/03-pod-security/manifests/restricted-pod.yaml
kubectl delete -f labs/03-pod-security/manifests/namespace.yaml
```

## 시험 팁

- PSA는 namespace label로 제어합니다.
- `allowPrivilegeEscalation: false`, `runAsNonRoot: true`, `seccompProfile`은 자주 같이 등장합니다.
- 거부 메시지는 문제 해결의 힌트이므로 event와 error output을 읽습니다.
