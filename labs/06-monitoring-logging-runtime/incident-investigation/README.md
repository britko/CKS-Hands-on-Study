# Incident Investigation

## 목표

- Falco, audit log, Kubernetes event, Pod spec를 연결해 의심 행위를 조사한다.
- 탐지 결과를 보안 설정 개선으로 이어간다.

## 조사 순서

1. Falco 이벤트에서 namespace, pod, container, command를 찾는다.
2. Pod spec에서 image, ServiceAccount, SecurityContext를 확인한다.
3. event와 audit log에서 생성/수정 주체를 확인한다.
4. RBAC, NetworkPolicy, Pod Security, image policy 개선 방향을 작성한다.

## 명령 템플릿

```bash
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=10m
kubectl describe pod -n <ns> <pod>
kubectl get pod -n <ns> <pod> -o yaml
kubectl get events -n <ns> --sort-by=.lastTimestamp
kubectl auth can-i --list --as system:serviceaccount:<ns>:<sa> -n <ns>
```

## 시험형 보고 양식

```text
탐지 이벤트:
namespace/pod/container:
실행 command:
관련 ServiceAccount:
위험한 SecurityContext:
권장 수정:
검증 명령:
```

## 시험 포인트

- 단일 로그만 보지 말고 Pod spec과 권한을 함께 본다.
- 발견한 뒤 삭제만 하지 말고 재발 방지 설정을 제시한다.
