# Hints: default deny와 허용 정책 작성

## Hint 1

default deny ingress는 `podSelector: {}`와 `policyTypes: [Ingress]`로 namespace의 모든 Pod를 선택한다.

## Hint 2

허용 정책은 destination Pod를 `podSelector.matchLabels.app=web`으로 선택한다.

## Hint 3

source는 `from.podSelector.matchLabels.app=allowed-client`로 제한한다.

## Hint 4

Service port는 80이지만 NetworkPolicy의 `ports.port`는 대상 Pod의 container port인 8080을 사용한다.
