# Mock Exam Set 03 Solutions

## Question 1

```bash
trivy image --format cyclonedx --output nginx-sbom.json nginxinc/nginx-unprivileged:1.27-alpine
trivy sbom nginx-sbom.json
```

SBOM은 구성 요소 목록이고, 취약점 스캔은 알려진 CVE와 심각도를 보여준다.

## Question 2

확인 항목:

- `nginx:latest` 사용
- privileged container
- `allowPrivilegeEscalation` 미설정 또는 true
- capability drop 누락
- root 실행 가능성

수정 방향은 명시적 태그/digest, non-root, `allowPrivilegeEscalation: false`, `capabilities.drop: ["ALL"]`, `seccompProfile: RuntimeDefault`이다.

## Question 3

[audit policy 예시](../../labs/07-audit-logging/manifests/audit-policy.yaml)를 참고한다. Secret은 민감 데이터 노출을 막기 위해 `Metadata`, ConfigMap 변경은 조사 목적으로 `RequestResponse`가 가능하다.

## Question 4

```yaml
securityContext:
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
containers:
  - securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop: ["ALL"]
```

## Question 5

조사 순서:

```bash
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=10m
kubectl get pod falco-target -n cks-falco -o yaml
kubectl describe pod falco-target -n cks-falco
kubectl auth can-i --list --as system:serviceaccount:cks-falco:default -n cks-falco
```

재발 방지: non-root, read-only root filesystem, capability drop, 권한 상승 금지, ServiceAccount 권한 축소, Falco rule 검토.
