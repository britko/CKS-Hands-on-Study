# 04. Minimize Microservice Vulnerabilities

이 도메인은 Pod Security Standards, Secret 관리, isolation, sandboxed containers, Pod-to-Pod encryption을 다룹니다.

## 학습 순서

1. [Pod Security](pod-security/README.md)
2. [Secrets](secrets/README.md)
3. [Cilium Policy](cilium-policy/README.md)
4. [RuntimeClass and Sandbox](runtimeclass-sandbox/README.md)
5. [Cilium Encryption](cilium-encryption/README.md)

## 도메인 완료 기준

- PSA `restricted` 정책을 적용하고 거부 원인을 해석할 수 있다.
- Secret 접근을 RBAC로 제한하고 etcd encryption 필요성을 설명할 수 있다.
- RuntimeClass/sandboxed runtime의 목적을 설명할 수 있다.
- Cilium 기반 Pod-to-Pod encryption 흐름을 설명할 수 있다.
