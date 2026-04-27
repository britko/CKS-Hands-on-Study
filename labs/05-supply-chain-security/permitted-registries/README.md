# Permitted Registries

## 목표

- 허용된 registry만 배포하도록 제한하는 supply chain control을 이해한다.
- admission policy가 registry allowlist를 강제하는 위치를 파악한다.

## 예시 정책 아이디어

ValidatingAdmissionPolicy 또는 Kyverno/Gatekeeper 같은 도구로 다음 조건을 강제할 수 있습니다.

```text
container image must start with registry.example.com/
image tag must not be latest
image digest should be pinned
```

## 수동 점검 명령

```bash
kubectl get pods -A -o jsonpath="{range .items[*]}{.metadata.namespace}{' '}{.metadata.name}{' '}{.spec.containers[*].image}{'\n'}{end}"
```

## 시험 포인트

- permitted registry는 image vulnerability scan과 별개의 제어다.
- admission policy는 API server 요청 시점에 배포를 차단한다.
- 현재 클러스터에 어떤 policy engine이 설치되어 있는지 먼저 확인한다.

## 참고

- [Validating Admission Policy](https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/)
- [Kubernetes Policies](https://kubernetes.io/docs/concepts/policy/)
