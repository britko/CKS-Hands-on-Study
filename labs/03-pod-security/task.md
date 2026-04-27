# Task: restricted Pod Security 적용

제한 시간: 15분

## 요구사항

`cks-psa` namespace에 Pod Security Admission `restricted` 정책을 적용하라.

- namespace에 `enforce`, `audit`, `warn`을 모두 `restricted`로 설정한다.
- privileged Pod는 생성이 거부되어야 한다.
- 안전한 nginx Pod는 non-root로 실행되어야 한다.
- 컨테이너는 권한 상승을 금지하고 모든 Linux capability를 drop해야 한다.
- seccomp profile은 `RuntimeDefault`를 사용한다.

## 완료 조건

```bash
kubectl apply -f labs/03-pod-security/manifests/privileged-pod.yaml
kubectl apply -f labs/03-pod-security/manifests/restricted-pod.yaml
kubectl get pod restricted-nginx -n cks-psa
```

privileged Pod 생성은 실패하고, `restricted-nginx`는 Running 상태가 되어야 한다.
