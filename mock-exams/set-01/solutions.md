# Mock Exam Set 01 Solutions

## Question 1

```bash
kubectl create ns exam-rbac --dry-run=client -o yaml | kubectl apply -f -
kubectl create sa viewer -n exam-rbac
kubectl create role pod-viewer --verb=get,list,watch --resource=pods -n exam-rbac
kubectl create rolebinding viewer-pod-viewer --role=pod-viewer --serviceaccount=exam-rbac:viewer -n exam-rbac
kubectl auth can-i list pods --as system:serviceaccount:exam-rbac:viewer -n exam-rbac
kubectl auth can-i get secrets --as system:serviceaccount:exam-rbac:viewer -n exam-rbac
```

## Question 2

```bash
kubectl label ns exam-psa pod-security.kubernetes.io/enforce=restricted --overwrite
kubectl label ns exam-psa pod-security.kubernetes.io/audit=restricted --overwrite
kubectl label ns exam-psa pod-security.kubernetes.io/warn=restricted --overwrite
kubectl run good-pod -n exam-psa --image=nginxinc/nginx-unprivileged:1.27-alpine --port=8080 --dry-run=client -o yaml > /tmp/good-pod.yaml
```

`/tmp/good-pod.yaml`에 `runAsNonRoot`, `seccompProfile`, `allowPrivilegeEscalation: false`, `capabilities.drop: ["ALL"]`를 추가한 뒤 적용한다.

## Question 3

```bash
kubectl apply -f mock-exams/set-01/manifests/network-policy.yaml
kubectl exec -n exam-netpol deploy/client-allowed -- wget -qO- --timeout=3 http://web
kubectl exec -n exam-netpol deploy/client-blocked -- wget -qO- --timeout=3 http://web
```

시험에서는 namespace와 label이 다를 수 있으므로 `kubectl get pod --show-labels`로 먼저 확인한다.

## Question 4

```bash
kubectl create sa secret-reader -n exam-secret
kubectl create role read-db-password --verb=get --resource=secrets --resource-name=db-password -n exam-secret
kubectl create rolebinding secret-reader-read-db-password --role=read-db-password --serviceaccount=exam-secret:secret-reader -n exam-secret
kubectl auth can-i get secret/db-password --as system:serviceaccount:exam-secret:secret-reader -n exam-secret
kubectl auth can-i delete secret/db-password --as system:serviceaccount:exam-secret:secret-reader -n exam-secret
```
