# 08. Runtime Security

## 목표

- 실행 중인 Pod의 의심 행위를 관찰한다.
- Falco 설치 전에도 `kubectl`로 조사할 수 있는 기본 증거를 수집한다.
- 런타임 탐지와 사전 차단 정책의 차이를 이해한다.
- CKS에서 자주 나오는 조사 명령을 연습한다.

## 배경 개념

Runtime security는 이미 실행 중인 컨테이너에서 발생하는 행위를 탐지합니다. 예를 들어 shell 실행, 민감 파일 접근, 패키지 설치, 예상하지 못한 네트워크 도구 실행 등이 신호가 될 수 있습니다. 이 랩은 기본 조사 흐름을 다루고, 실제 Falco 이벤트 탐지는 [Falco Detection](../06-monitoring-logging-runtime/falco-detection/README.md)에서 진행합니다.

## 실습

```bash
kubectl apply -f labs/08-runtime-security/manifests/runtime.yaml
```

Pod 상태 확인:

```bash
kubectl get pods -n cks-runtime -o wide
kubectl describe pod -n cks-runtime suspicious
```

의심 행위 예시 실행:

```bash
kubectl exec -n cks-runtime suspicious -- sh -c "id && cat /etc/passwd | head"
kubectl exec -n cks-runtime suspicious -- sh -c "wget -qO- https://kubernetes.io | head"
```

보안 설정 비교:

```bash
kubectl get pod suspicious -n cks-runtime -o jsonpath="{.spec.containers[0].securityContext}"
kubectl get pod hardened -n cks-runtime -o jsonpath="{.spec.containers[0].securityContext}"
```

조사 메모:

```bash
kubectl get events -n cks-runtime --sort-by=.lastTimestamp
kubectl logs -n cks-runtime suspicious
kubectl auth can-i create pods/exec -n cks-runtime
```

## 검증

- `suspicious`는 root와 추가 capability를 가진 위험 예시입니다.
- `hardened`는 non-root, 권한 상승 차단, capability drop을 적용한 예시입니다.
- Falco를 설치했다면 위 `exec` 행위가 탐지 이벤트로 남는지 [Falco Detection](../06-monitoring-logging-runtime/falco-detection/README.md)에서 확인합니다.

## 시험 전 확인할 문서

- [Seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
- [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)
- [Debug Running Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)
- [Falco Documentation](https://falco.org/docs/)

## 정리

```bash
kubectl delete -f labs/08-runtime-security/manifests/runtime.yaml
```

## 시험 팁

- Runtime 보안 문제는 "무엇이 발생했는지"와 "어떤 리소스가 원인인지"를 빠르게 연결해야 합니다.
- `kubectl logs`, `kubectl describe`, `kubectl get events`, `kubectl exec`를 조합해 조사합니다.
- 탐지는 사후 관찰이고 Pod Security/SecurityContext는 사전 차단입니다.
