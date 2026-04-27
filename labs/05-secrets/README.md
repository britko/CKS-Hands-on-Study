# 05. Secret 관리

## 목표

- Secret을 생성하고 Pod에 volume으로 마운트한다.
- Secret 조회 권한을 RBAC로 제한한다.
- Secret이 base64 인코딩일 뿐 암호화가 아님을 확인한다.

## 실습

```powershell
kubectl apply -f labs/05-secrets/manifests/secrets.yaml
```

Secret 값 확인:

```powershell
kubectl get secret app-secret -n cks-secrets -o jsonpath="{.data.password}"
```

PowerShell에서 base64 디코딩:

```powershell
[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String((kubectl get secret app-secret -n cks-secrets -o jsonpath="{.data.password}")))
```

Pod에서 마운트 확인:

```powershell
kubectl exec -n cks-secrets secure-app -- ls /etc/app-secret
```

권한 확인:

```powershell
kubectl auth can-i get secrets --as system:serviceaccount:cks-secrets:secret-reader -n cks-secrets
kubectl auth can-i delete secrets --as system:serviceaccount:cks-secrets:secret-reader -n cks-secrets
```

## 검증

- Secret 값은 base64로 쉽게 복원됩니다.
- `secret-reader`는 `get`만 가능하고 `delete`는 거부되어야 합니다.

## 시험 전 확인할 문서

- [Good Practices for Kubernetes Secrets](https://kubernetes.io/docs/concepts/security/secrets-good-practices/)
- [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- [Encrypting Secret Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)

## 정리

```powershell
kubectl delete -f labs/05-secrets/manifests/secrets.yaml
```

## 시험 팁

- Secret을 볼 수 있는 권한은 매우 민감합니다.
- 환경 변수로 주입된 Secret은 프로세스/디버깅 과정에서 노출될 수 있어 volume 마운트가 더 나은 경우가 많습니다.
- etcd encryption at rest는 별도 클러스터 설정입니다.
