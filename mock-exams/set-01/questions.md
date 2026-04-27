# Mock Exam Set 01

제한 시간: 60분

범위: RBAC, Pod Security Admission, NetworkPolicy, Secret

## 준비

```bash
kubectl apply -f mock-exams/set-01/manifests/setup.yaml
```

## Question 1: RBAC 최소 권한

`exam-rbac` namespace의 ServiceAccount `viewer`가 Pod는 조회할 수 있지만 Secret은 조회하지 못하도록 구성하라.

검증:

```bash
kubectl auth can-i list pods --as system:serviceaccount:exam-rbac:viewer -n exam-rbac
kubectl auth can-i get secrets --as system:serviceaccount:exam-rbac:viewer -n exam-rbac
```

## Question 2: Pod Security

`exam-psa` namespace에 `restricted` enforce/audit/warn label을 적용하고, `bad-pod`가 거부되도록 하라. `good-pod`는 restricted 기준을 만족하도록 수정하거나 새로 생성하라.

검증:

```bash
kubectl get ns exam-psa --show-labels
kubectl get pod good-pod -n exam-psa
```

## Question 3: NetworkPolicy

`exam-netpol` namespace에서 모든 ingress를 기본 차단하고, `client-allowed`만 `web` Service에 접근할 수 있게 하라.

검증:

```bash
kubectl exec -n exam-netpol deploy/client-allowed -- wget -qO- --timeout=3 http://web
kubectl exec -n exam-netpol deploy/client-blocked -- wget -qO- --timeout=3 http://web
```

## Question 4: Secret 접근 제한

`exam-secret` namespace의 Secret `db-password`를 `secret-reader` ServiceAccount만 `get` 할 수 있게 구성하라. 삭제 권한은 없어야 한다.

검증:

```bash
kubectl auth can-i get secret/db-password --as system:serviceaccount:exam-secret:secret-reader -n exam-secret
kubectl auth can-i delete secret/db-password --as system:serviceaccount:exam-secret:secret-reader -n exam-secret
```
