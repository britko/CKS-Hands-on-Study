# Task: RBAC 최소 권한 구성

제한 시간: 12분

## 요구사항

`cks-rbac` namespace에서 다음 조건을 만족하도록 RBAC를 구성하라.

- ServiceAccount `pod-reader`를 생성한다.
- `pod-reader`는 `cks-rbac` namespace의 Pod를 `get`, `list`, `watch`만 할 수 있어야 한다.
- `pod-reader`는 Secret을 조회할 수 없어야 한다.
- `pod-reader`는 Pod를 삭제할 수 없어야 한다.
- ServiceAccount token 자동 마운트는 기본적으로 비활성화한다.

## 완료 조건

다음 명령이 기대 결과와 일치해야 한다.

```bash
kubectl auth can-i get pods --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
kubectl auth can-i delete pods --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
kubectl auth can-i get secrets --as system:serviceaccount:cks-rbac:pod-reader -n cks-rbac
```

기대 결과:

```text
yes
no
no
```
