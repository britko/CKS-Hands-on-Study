# Cilium Encryption

## 목표

- Cilium 기반 Pod-to-Pod encryption의 목적을 이해한다.
- WireGuard encryption 설정과 검증 흐름을 익힌다.

## 배경

CKS v1.34 커리큘럼은 Pod-to-Pod encryption using Cilium을 명시합니다. 로컬 kind에서는 host kernel과 Cilium 설정에 따라 동작이 달라질 수 있으므로, 이 랩은 설정/검증 흐름 중심으로 진행합니다.

## 설정 예시

Cilium Helm values에서 WireGuard를 활성화하는 형태입니다.

```bash
helm upgrade cilium cilium/cilium \
  --namespace kube-system \
  --reuse-values \
  --set encryption.enabled=true \
  --set encryption.type=wireguard
```

## 검증 명령

```bash
kubectl -n kube-system get cm cilium-config -o yaml | grep -i encryption
kubectl -n kube-system exec ds/cilium -- cilium-dbg status | grep -i encryption
kubectl -n kube-system rollout status ds/cilium
```

## 시험 포인트

- encryption은 NetworkPolicy와 다른 기능이다.
- Cilium policy는 "누가 통신 가능한가"를 제어하고, encryption은 "통신이 암호화되는가"를 다룬다.
- 실제 활성화 여부는 Cilium status와 config를 함께 확인한다.

## 참고

- [Cilium Encryption](https://docs.cilium.io/en/stable/security/network/encryption/)
