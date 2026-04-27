# 모니터링, 로깅, 런타임 보안

모니터링과 런타임 보안은 클러스터에서 이미 실행 중인 동작을 관찰하고 이상 행위를 탐지하는 영역입니다. audit log는 Kubernetes API 요청을 남기고, runtime security는 컨테이너 내부 행위를 감시합니다.

## 핵심 개념

- Kubernetes audit log는 누가 어떤 API 요청을 했는지 기록한다.
- audit policy는 어떤 요청을 어느 수준으로 기록할지 결정한다.
- Runtime security 도구는 shell 실행, 민감 파일 접근, 패키지 설치 같은 행위를 탐지한다.
- 로그는 탐지뿐 아니라 사후 분석과 증거 보존에도 중요하다.

## 자주 쓰는 명령

```powershell
kubectl logs -n kube-system -l component=kube-apiserver
kubectl get events -A --sort-by=.lastTimestamp
kubectl describe pod -n cks-runtime suspicious
kubectl exec -n cks-runtime suspicious -- id
```

## 시험 포인트

- audit policy의 `RequestResponse`는 정보가 많지만 민감 데이터와 용량 부담이 크다.
- kind는 관리형/시험 클러스터와 audit 구성 방식이 다를 수 있으므로 개념과 정책 파일 구조를 익힌다.
- Runtime 탐지는 정책 위반을 찾는 것이고, Pod Security는 사전에 차단하는 것이다.
- 이상 행위를 찾은 뒤에는 어떤 리소스와 ServiceAccount가 관련됐는지 추적한다.

## 시험에서 나오는 작업

- audit policy 파일에서 특정 resource/verb의 log level을 조정한다.
- API server manifest에 audit 관련 인자를 추가하거나 확인한다.
- Falco 이벤트에서 의심 Pod와 실행 command를 찾는다.
- 탐지된 Pod의 SecurityContext, ServiceAccount, NetworkPolicy를 점검한다.

## 실수 포인트

- Secret 요청을 `RequestResponse`로 기록해 민감 데이터가 로그에 남는 위험을 놓친다.
- Falco 이벤트의 priority만 보고 실제 namespace/pod/container를 확인하지 않는다.
- 탐지와 차단을 혼동한다. Falco는 기본적으로 알려주는 도구이고, 차단은 별도 정책/대응이 필요하다.

## 연결 실습

- [Audit Logging](../../labs/07-audit-logging/README.md)
- [Runtime Security](../../labs/08-runtime-security/README.md)
- [Falco 런타임 탐지](../../labs/10-falco-detection/README.md)

## 공식 문서와 추가 학습

- [Kubernetes Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
- [Falco Documentation](https://falco.org/docs/)
- [Falco Rules](https://falco.org/docs/rules/)
- [Debug Running Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)
- [Kubernetes Events](https://kubernetes.io/docs/reference/kubernetes-api/cluster-resources/event-v1/)
