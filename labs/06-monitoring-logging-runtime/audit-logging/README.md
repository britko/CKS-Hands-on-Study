# Audit Logging

## 목표

- Kubernetes audit policy 구조를 이해한다.
- API 요청 기록과 event 확인 흐름을 연습한다.
- kind에서 가능한 범위와 실제 시험 클러스터의 차이를 구분한다.

## 배경 개념

Audit log는 Kubernetes API server에 들어온 요청을 기록합니다. kind에서 API server audit 설정을 완전히 재구성하려면 control plane 설정을 추가로 바꿔야 하므로, 이 랩은 정책 파일 구조와 API 행위 추적 흐름을 중심으로 진행합니다.

## 실습

audit policy 예시 확인:

```powershell
Get-Content labs/06-monitoring-logging-runtime/audit-logging/manifests/audit-policy.yaml
```

API 요청을 만들 리소스 적용:

```powershell
kubectl apply -f labs/06-monitoring-logging-runtime/audit-logging/manifests/audit-target.yaml
kubectl get configmap -n cks-audit audit-target
kubectl patch configmap audit-target -n cks-audit --type merge -p '{\"data\":{\"changed\":\"true\"}}'
```

event와 리소스 변경 확인:

```powershell
kubectl get events -n cks-audit --sort-by=.lastTimestamp
kubectl get configmap audit-target -n cks-audit -o yaml
```

## 검증

- `audit-target` ConfigMap이 생성되고 patch 결과가 반영되어야 합니다.
- audit policy 예시에서 Secret 조회를 `Metadata` 수준으로 낮추는 이유를 설명할 수 있어야 합니다.

## 시험 전 확인할 문서

- [Kubernetes Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
- [API Server Reference](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/)
- [Encrypting Secret Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)

## kind와 시험 환경 차이

kind에서 API server audit 설정을 완전히 바꾸는 것은 시험 환경과 다릅니다. 실제 시험에서는 control plane 노드의 static Pod manifest와 audit policy 파일 경로를 직접 수정하는 문제가 나올 수 있으므로 killer.sh에서 반드시 확인합니다.

## 정리

```powershell
kubectl delete -f labs/06-monitoring-logging-runtime/audit-logging/manifests/audit-target.yaml
```

## 시험 팁

- audit 설정은 API server 인자 `--audit-policy-file`, `--audit-log-path`와 연결됩니다.
- 모든 요청을 `RequestResponse`로 남기면 Secret 같은 민감 데이터가 로그에 남을 수 있습니다.
- 시험에서는 정책 파일 경로와 API server manifest를 정확히 수정하는 능력이 중요합니다.
