# Mock Exam Set 02

제한 시간: 60분

범위: Cilium, Falco, 이미지 보안, audit

## 준비

```bash
kubectl apply -f mock-exams/set-02/manifests/setup.yaml
```

## Question 1: Cilium 상태와 Hubble

Cilium과 Hubble이 정상 동작하는지 확인하고, `exam-cilium` namespace의 최근 flow를 확인하라.

검증:

```bash
kubectl -n kube-system rollout status ds/cilium
kubectl -n kube-system port-forward svc/hubble-ui 12000:80
```

`cilium`/`hubble` CLI가 설치되어 있다면 `cilium hubble port-forward`와 `hubble observe --namespace exam-cilium --last 10`를 사용해도 된다.

## Question 2: Cilium L7 정책

`exam-cilium` namespace에서 `client`가 `api` Service의 `/public` path만 호출할 수 있게 CiliumNetworkPolicy를 작성하라. `/admin`은 차단되어야 한다.

주의: 이 문제는 Cilium L7 proxy가 켜진 환경에서 실제 차단까지 검증한다.

## Question 3: 이미지 보안

`exam-image` namespace의 `risky` Pod와 비교해 `secure` Pod가 다음 조건을 만족하도록 구성하라.

- non-root 실행
- 권한 상승 금지
- 모든 capability drop
- RuntimeDefault seccomp

## Question 4: Falco 이벤트 분석

`exam-falco` namespace의 `falco-target` Pod에서 shell 실행과 민감 파일 접근을 발생시키고 Falco 로그에서 관련 이벤트를 찾아라.

검증:

```bash
kubectl logs -n falco -l app.kubernetes.io/name=falco --since=10m | grep -E "exam-falco|falco-target"
```

## Question 5: Audit policy 해석

[labs/06-monitoring-logging-runtime/audit-logging/manifests/audit-policy.yaml](../../labs/06-monitoring-logging-runtime/audit-logging/manifests/audit-policy.yaml)을 보고 Secret 요청을 `Metadata` 수준으로 기록하는 이유를 설명하라.
