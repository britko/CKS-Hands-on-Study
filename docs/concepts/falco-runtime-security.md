# Falco 런타임 보안

Falco는 컨테이너와 호스트에서 발생하는 system call 기반 행위를 탐지하는 런타임 보안 도구입니다. CKS에서는 Falco 이벤트를 읽고 어떤 워크로드가 의심 행위를 했는지 추적하는 능력이 중요합니다.

## 시험에서 나오는 작업

- Falco 로그에서 의심 이벤트를 찾는다.
- rule 이름, priority, command, file path, namespace, pod를 해석한다.
- 탐지된 Pod의 SecurityContext, ServiceAccount, RBAC를 점검한다.
- 탐지와 차단의 차이를 설명한다.

## 필수 명령

```bash
kubectl get pods -n falco
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=10m
kubectl get pod <pod> -n <namespace> -o yaml
kubectl describe pod <pod> -n <namespace>
kubectl get events -n <namespace> --sort-by=.lastTimestamp
```

## 자주 보는 이벤트 유형

- 컨테이너 내부 shell 실행
- 민감 파일 읽기(`/etc/shadow`, Kubernetes token 등)
- 예상하지 못한 네트워크 도구 실행
- 패키지 매니저 실행
- privileged 또는 host namespace 사용

## 실수 포인트

- Falco 이벤트를 보고도 namespace/pod/container를 정확히 식별하지 못한다.
- 탐지 이벤트를 Pod Security, RBAC, NetworkPolicy 개선으로 연결하지 못한다.
- Docker Desktop, Colima, Linux bare metal의 driver 차이를 고려하지 않는다.
- Falco가 탐지 도구이지 admission controller가 아니라는 점을 혼동한다.

## kind와 실제 클러스터 차이

kind의 노드는 Docker container입니다. Falco는 host kernel과 driver에 영향을 받으므로 Windows/macOS Docker Desktop에서는 Linux bare metal과 이벤트가 다르게 보일 수 있습니다. 실습에서는 이벤트 해석과 조사 흐름을 익히는 데 집중합니다.

## 연결 실습

- [Runtime Security](../../labs/08-runtime-security/README.md)
- [Falco 런타임 탐지](../../labs/10-falco-detection/README.md)

## 공식 문서와 추가 학습

- [Falco Documentation](https://falco.org/docs/)
- [Falco Installation on Kubernetes](https://falco.org/docs/setup/kubernetes/)
- [Falco Rules](https://falco.org/docs/rules/)
- [Falco Output Fields](https://falco.org/docs/reference/rules/supported-fields/)
- [Falco Helm Chart](https://github.com/falcosecurity/charts/tree/master/charts/falco)
