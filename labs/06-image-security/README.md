# 06. 이미지 보안

## 목표

- 위험한 컨테이너 실행 설정과 안전한 실행 설정을 비교한다.
- 이미지 태그, root 실행, capability, read-only filesystem을 점검한다.

## 시험형 연습

- [Task](task.md)
- [Hints](hints.md)
- [Solution](solution.md)

## 배경 개념

이미지 보안은 스캔 도구만의 문제가 아닙니다. Kubernetes에서 이미지를 어떻게 실행하는지도 중요합니다. CKS에서는 취약 이미지 탐지와 함께 non-root 실행, 권한 상승 차단, capability 제거 같은 설정을 자주 다룹니다.

## 실습

```powershell
kubectl apply -f labs/06-image-security/manifests/image-security.yaml
```

설정 비교:

```powershell
kubectl get pods -n cks-image
kubectl get pod insecure-app -n cks-image -o yaml
kubectl get pod secure-app -n cks-image -o yaml
```

실행 사용자 확인:

```powershell
kubectl exec -n cks-image secure-app -- id
```

선택 사항: Trivy가 설치되어 있다면 이미지 스캔을 실행합니다.

```powershell
trivy image nginx:latest
trivy image nginxinc/nginx-unprivileged:1.27-alpine
```

## 검증

- `secure-app`은 non-root 사용자로 실행되어야 합니다.
- `secure-app`은 capability를 모두 drop하고 권한 상승을 차단해야 합니다.
- `insecure-app`은 `latest` 태그와 root/privileged 실행의 위험 예시입니다.

## 시험 전 확인할 문서

- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [Cosign Documentation](https://docs.sigstore.dev/cosign/)
- [Kubernetes Images](https://kubernetes.io/docs/concepts/containers/images/)
- [Configure a Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

## 정리

```powershell
kubectl delete -f labs/06-image-security/manifests/image-security.yaml
```

## 시험 팁

- `latest`보다 명시적 버전 또는 digest가 안전합니다.
- `runAsNonRoot: true`만으로 충분하지 않을 수 있으므로 이미지의 기본 사용자도 확인합니다.
- `allowPrivilegeEscalation: false`, `capabilities.drop: ["ALL"]`, `readOnlyRootFilesystem`을 함께 봅니다.
