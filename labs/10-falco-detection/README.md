# 10. Falco 런타임 탐지

## 목표

- Falco를 kind 클러스터에 설치한다.
- 컨테이너 내부 shell 실행, 민감 파일 접근, 네트워크 도구 실행을 발생시킨다.
- Falco 로그에서 이벤트를 찾고 rule 이름과 우선순위를 해석한다.

## 배경 개념

Falco는 런타임에서 발생하는 system call 기반 행위를 탐지합니다. Pod Security나 admission policy가 배포 전에 막는 장치라면, Falco는 실행 중인 워크로드에서 의심 행위가 발생했는지 알려주는 탐지 도구입니다.

## 준비

Falco 설치:

```powershell
.\scripts\install-falco.ps1
```

```bash
./scripts/install-falco.sh
```

상태 확인:

```bash
kubectl get pods -n falco
kubectl logs -n falco -l app.kubernetes.io/name=falco --tail=20
```

## 실습

테스트 Pod 생성:

```bash
kubectl apply -f labs/10-falco-detection/manifests/falco-target.yaml
kubectl wait --for=condition=Ready pod/falco-target -n cks-falco --timeout=90s
```

의심 행위 발생:

```bash
kubectl exec -n cks-falco falco-target -- sh -c "id"
kubectl exec -n cks-falco falco-target -- sh -c "cat /etc/shadow || true"
kubectl exec -n cks-falco falco-target -- sh -c "wget -qO- https://kubernetes.io | head"
```

Falco 이벤트 확인:

```bash
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=5m | grep -E "cks-falco|falco-target|shell|sensitive|shadow|wget"
```

PowerShell에서는 다음처럼 확인합니다.

```powershell
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=5m | Select-String "cks-falco|falco-target|shell|sensitive|shadow|wget"
```

## 검증

- Falco 로그에 `falco-target` 또는 `cks-falco` 관련 이벤트가 보여야 합니다.
- 이벤트에서 rule 이름, priority, container name, namespace를 찾을 수 있어야 합니다.
- 이벤트가 없다면 [Troubleshooting](../../docs/setup/troubleshooting.md)의 Falco 섹션을 확인합니다.

## 시험 전 확인할 문서

- [Falco Documentation](https://falco.org/docs/)
- [Falco Installation on Kubernetes](https://falco.org/docs/setup/kubernetes/)
- [Falco Rules](https://falco.org/docs/rules/)
- [Falco Output Fields](https://falco.org/docs/reference/rules/supported-fields/)

## 정리

```bash
kubectl delete -f labs/10-falco-detection/manifests/falco-target.yaml
```

## 시험 팁

- CKS에서는 Falco rule을 해석하거나 어떤 Pod가 의심 행위를 했는지 찾는 문제가 나올 수 있습니다.
- 이벤트를 볼 때는 namespace, pod, container, command, user, file path를 우선 확인합니다.
- 탐지 이벤트를 본 뒤에는 SecurityContext, ServiceAccount, RBAC, NetworkPolicy로 어떻게 줄일지 연결해서 생각합니다.
