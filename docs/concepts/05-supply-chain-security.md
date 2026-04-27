# 05. Supply Chain Security

비중: 20%

Supply Chain Security는 이미지와 manifest가 클러스터에 배포되기 전 신뢰할 수 있는지 확인하는 영역입니다. base image 최소화, SBOM, image signing, permitted registry, static analysis가 핵심입니다.

## 시험에서 나오는 작업

- 이미지 취약점을 스캔하고 HIGH/CRITICAL 결과를 해석한다.
- `latest` 태그를 명시적 버전 또는 digest로 바꾼다.
- SBOM을 생성하거나 확인한다.
- Cosign으로 이미지 서명/검증 흐름을 설명한다.
- Kubesec/KubeLinter로 manifest 위험 설정을 찾는다.
- 허용된 registry만 사용하도록 admission 정책 개념을 설명한다.

## 필수 명령

```bash
trivy image <image>
trivy image --format cyclonedx --output sbom.json <image>
cosign verify <image>
kubesec scan <manifest.yaml>
kube-linter lint <path>
kubectl get pod <pod> -o jsonpath="{.spec.containers[*].image}"
```

## 실수 포인트

- 스캔 결과만 보고 Kubernetes 실행 설정을 그대로 둔다.
- digest 고정과 서명 검증의 차이를 혼동한다.
- SBOM은 취약점 스캔 결과가 아니라 구성 요소 목록이라는 점을 놓친다.
- admission policy는 클러스터에 설치된 도구에 따라 리소스가 달라진다.

## 연결 실습

- [Supply Chain Security 랩](../../labs/05-supply-chain-security/README.md)
