# 04. Minimize Microservice Vulnerabilities

비중: 20%

이 도메인은 애플리케이션 Pod의 실행 권한, Secret, 네트워크 격리, sandboxing, Pod-to-Pod encryption을 다룹니다.

## 시험에서 나오는 작업

- Pod Security Standards를 적용한다.
- Secret 접근 권한을 제한하고 안전한 사용 방식을 선택한다.
- namespace/NetworkPolicy/RuntimeClass로 격리를 강화한다.
- Cilium 기반 Pod-to-Pod encryption 흐름을 이해한다.

## 필수 명령

```bash
kubectl label ns <ns> pod-security.kubernetes.io/enforce=restricted
kubectl get pod <pod> -o yaml
kubectl get secret -n <ns>
kubectl auth can-i get secrets --as system:serviceaccount:<ns>:<sa> -n <ns>
kubectl get runtimeclass
kubectl get ciliumnetworkpolicy -A
```

## 실수 포인트

- SecurityContext 필드를 Pod level과 container level에 잘못 둔다.
- Secret이 base64일 뿐 암호화가 아니라는 점을 놓친다.
- NetworkPolicy egress default deny 후 DNS 허용을 잊는다.
- sandboxed runtime은 RuntimeClass와 runtime handler가 모두 필요하다는 점을 놓친다.

## 연결 실습

- [Microservice Vulnerabilities 랩](../../labs/04-microservice-vulnerabilities/README.md)
- [Cilium 네트워크 보안](cilium-network-security.md)
