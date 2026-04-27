# Cosign Sign and Verify

## 목표

- image signing과 verification의 목적을 이해한다.
- Cosign 명령의 기본 흐름을 익힌다.

## 실습 흐름

실제 registry push 권한이 있는 이미지가 필요합니다.

```bash
cosign generate-key-pair
cosign sign --key cosign.key <registry>/<image>:<tag>
cosign verify --key cosign.pub <registry>/<image>:<tag>
```

## 시험형 질문

- digest pinning과 signing의 차이는 무엇인가?
- 서명 검증에 실패하면 배포를 계속해야 하는가?
- admission policy에서 image verification을 강제하려면 어떤 도구가 필요한가?

## 시험 포인트

- CKS는 특정 registry credential이 없는 환경일 수 있으므로 개념과 검증 흐름을 알아야 한다.
- 서명은 artifact의 출처와 무결성을 확인하는 supply chain control이다.

## 참고

- [Cosign](https://docs.sigstore.dev/cosign/)
