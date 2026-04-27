# Platform Binary Verification

## 목표

- Kubernetes binary를 배포하기 전에 checksum/signature를 확인하는 절차를 익힌다.
- 시험에서 검증 흐름을 설명하거나 명령을 작성할 수 있게 한다.

## 실습 흐름

다운로드한 binary와 checksum 파일이 있다고 가정합니다.

```bash
sha256sum kubectl
sha256sum -c kubectl.sha256
```

서명 검증 도구가 제공되는 경우 해당 프로젝트의 release 문서를 따릅니다.

```bash
cosign verify-blob \
  --signature <signature-file> \
  --certificate <certificate-file> \
  <binary-file>
```

## 시험형 문제

다음 질문에 답할 수 있어야 합니다.

- checksum 파일과 실제 binary hash가 다르면 어떻게 해야 하는가?
- binary 검증은 배포 전 supply chain의 어느 단계에 해당하는가?
- cluster node에 이미 있는 binary는 어떤 명령으로 위치와 version을 확인하는가?

## 확인 명령

```bash
which kubelet
kubelet --version
which kubectl
kubectl version --client
```

## 참고

- [Kubernetes Releases](https://kubernetes.io/releases/)
- [Kubernetes Release Notes](https://github.com/kubernetes/kubernetes/releases)
- [Cosign](https://docs.sigstore.dev/cosign/)
