# Hints: 안전한 이미지 실행 구성

## Hint 1

이미지 보안은 스캔 결과뿐 아니라 Kubernetes 실행 설정도 함께 봐야 한다.

## Hint 2

`runAsNonRoot: true`는 이미지가 실제 non-root 사용자로 실행 가능해야 효과가 있다.

## Hint 3

`readOnlyRootFilesystem: true`는 좋은 기준이지만, nginx 같은 서버는 cache/temp 경로 때문에 추가 volume 설정이 필요할 수 있다.

## Hint 4

Trivy가 설치되어 있다면 다음처럼 스캔한다.

```bash
trivy image --severity HIGH,CRITICAL nginxinc/nginx-unprivileged:1.27-alpine
```
