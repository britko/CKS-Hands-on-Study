# Falco Detection

Falco는 실행 중인 컨테이너에서 발생하는 system call 기반 행위를 탐지합니다. 이 랩은 runtime security 도메인에서 Falco를 설치하고, 의심 행위를 발생시킨 뒤 이벤트를 해석하는 흐름을 연습합니다.

## 준비

Falco는 이 랩에 들어와서 설치합니다.

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
kubectl apply -f labs/06-monitoring-logging-runtime/falco-detection/manifests/falco-target.yaml
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

PowerShell:

```powershell
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=5m | Select-String "cks-falco|falco-target|shell|sensitive|shadow|wget"
```

## 검증

- Falco 로그에 `falco-target` 또는 `cks-falco` 관련 이벤트가 보여야 한다.
- 이벤트에서 rule, priority, namespace, pod, container, command를 찾을 수 있어야 한다.
- 이벤트를 본 뒤 SecurityContext, ServiceAccount, RBAC, NetworkPolicy 중 어떤 설정으로 위험을 줄일지 설명한다.

## 정리

```bash
kubectl delete -f labs/06-monitoring-logging-runtime/falco-detection/manifests/falco-target.yaml
```

## 시험 포인트

- Falco 로그에서 rule, priority, namespace, pod, command를 빠르게 찾는다.
- 탐지 이벤트를 Pod Security, RBAC, NetworkPolicy 개선으로 연결한다.
- Falco는 기본적으로 차단 도구가 아니라 탐지 도구라는 점을 구분한다.
