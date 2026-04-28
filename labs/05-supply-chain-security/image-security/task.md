# Task: 안전한 이미지 실행 구성

제한 시간: 15분

## 요구사항

`cks-image` namespace에서 위험한 Pod와 안전한 Pod 설정을 비교하고, 안전한 실행 기준을 만족하는 Pod를 구성하라.

- `latest` 태그 사용을 피하고 명시적 버전을 사용한다.
- root가 아닌 사용자로 실행한다.
- 권한 상승을 금지한다.
- 모든 Linux capability를 drop한다.
- seccomp profile은 `RuntimeDefault`를 사용한다.
- 가능하면 Trivy로 이미지 취약점을 스캔한다.

## 완료 조건

```bash
kubectl apply -f labs/05-supply-chain-security/image-security/manifests/image-security.yaml
kubectl exec -n cks-image secure-app -- id
kubectl get pod secure-app -n cks-image -o jsonpath="{.spec.containers[0].securityContext.allowPrivilegeEscalation}"
```

`secure-app`은 non-root 사용자로 실행되고 권한 상승이 `false`여야 한다.
