# 클러스터 하드닝

클러스터 하드닝은 워크로드가 위험한 권한으로 실행되지 않도록 Kubernetes 정책을 적용하는 영역입니다. CKS에서는 Pod Security Admission, SecurityContext, admission control의 역할 차이를 이해해야 합니다.

## 핵심 개념

- Pod Security Admission(PSA)은 namespace label을 기준으로 Pod 보안 수준을 적용한다.
- `restricted` 프로파일은 privileged, host namespace, root 실행, 권한 상승 등을 제한한다.
- SecurityContext는 Pod 또는 container 수준에서 실행 사용자, capability, read-only root filesystem 등을 지정한다.
- Admission controller는 API server에 요청이 저장되기 전에 검증하거나 변경한다.

## 자주 쓰는 명령

```powershell
kubectl label ns cks-psa pod-security.kubernetes.io/enforce=restricted
kubectl explain pod.spec.securityContext
kubectl explain pod.spec.containers.securityContext
kubectl get events -n cks-psa --sort-by=.lastTimestamp
```

## 시험 포인트

- PSA label은 namespace에 적용한다.
- `runAsNonRoot`, `allowPrivilegeEscalation: false`, `seccompProfile`을 함께 확인한다.
- 거부된 Pod는 `kubectl describe` 또는 event로 원인을 찾는다.
- `baseline`과 `restricted`의 차이를 알고 있어야 한다.

## 시험에서 나오는 작업

- namespace에 `pod-security.kubernetes.io/enforce=restricted`를 적용한다.
- 거부된 Pod YAML을 수정해 restricted 정책을 통과시킨다.
- privileged, hostPID, hostNetwork, hostPath 사용을 찾아 제거한다.
- seccomp/AppArmor/capability 설정을 점검한다.

## 실수 포인트

- `restricted`를 적용한 뒤 기존 workload가 깨질 수 있음을 확인하지 않는다.
- `runAsNonRoot: true`를 넣었지만 이미지가 root로만 실행되어 실패하는 경우를 놓친다.
- `readOnlyRootFilesystem: true`를 적용하고 필요한 writable volume을 준비하지 않는다.

## 연결 실습

- [Pod Security와 SecurityContext](../../labs/03-pod-security/README.md)

## 공식 문서와 추가 학습

- [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)
- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Configure a Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [Enforcing Pod Security Standards](https://kubernetes.io/docs/setup/best-practices/enforcing-pod-security-standards/)
