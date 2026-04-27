# Kubesec and KubeLinter

## 목표

- Kubernetes manifest 정적 분석 도구의 역할을 이해한다.
- privileged, root, missing resource limits 같은 위험 설정을 찾는다.

## Kubesec

```bash
kubesec scan labs/06-image-security/manifests/image-security.yaml
```

## KubeLinter

```bash
kube-linter lint labs/
```

## 자주 찾는 위험

- privileged container
- `runAsNonRoot` 누락
- `allowPrivilegeEscalation` 미설정
- `readOnlyRootFilesystem` 미설정
- resource requests/limits 누락
- latest tag 사용

## 시험 포인트

- 정적 분석 결과를 보고 YAML의 어느 필드를 수정해야 하는지 바로 연결한다.
- 도구가 없는 환경에서는 `kubectl get -o yaml`과 `grep`으로 같은 항목을 수동 점검한다.

## 참고

- [Kubesec](https://kubesec.io/)
- [KubeLinter](https://docs.kubelinter.io/)
