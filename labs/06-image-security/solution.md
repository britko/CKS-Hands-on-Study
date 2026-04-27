# Solution: 안전한 이미지 실행 구성

## 적용

```bash
kubectl apply -f labs/06-image-security/manifests/image-security.yaml
```

## 확인

```bash
kubectl get pods -n cks-image
kubectl exec -n cks-image secure-app -- id
kubectl get pod secure-app -n cks-image -o jsonpath="{.spec.securityContext.runAsNonRoot}"
kubectl get pod secure-app -n cks-image -o jsonpath="{.spec.containers[0].securityContext.capabilities.drop}"
```

선택 스캔:

```bash
trivy image --severity HIGH,CRITICAL nginx:latest
trivy image --severity HIGH,CRITICAL nginxinc/nginx-unprivileged:1.27-alpine
```

## 해설

`insecure-app`은 `latest` 태그와 privileged 실행을 보여주는 반례다. `secure-app`은 non-root 이미지, 권한 상승 금지, capability drop, RuntimeDefault seccomp를 적용한다. 이미지 스캔과 실행 보안은 서로 보완 관계다.

## 정리

```bash
kubectl delete -f labs/06-image-security/manifests/image-security.yaml
```
