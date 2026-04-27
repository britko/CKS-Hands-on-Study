# Kubelet Hardening

## 목표

- kubelet의 대표적인 보안 설정을 확인한다.
- read-only port, anonymous auth, authorization mode를 점검한다.

## 확인 명령

```bash
ps aux | grep kubelet
sudo systemctl status kubelet
sudo journalctl -u kubelet --no-pager
sudo grep -E "anonymous|authorization|readOnly|serverTLSBootstrap" /var/lib/kubelet/config.yaml
```

## 안전한 방향

- anonymous auth는 비활성화한다.
- authorization mode는 `Webhook`을 사용한다.
- read-only port는 비활성화한다.
- kubelet client/server certificate 설정을 확인한다.

## 시험형 문제

다음 표를 채웁니다.

```text
설정:
현재 값:
위험 여부:
확인 명령:
수정 파일 또는 flag:
```

## kind 한계

kind node는 container이므로 실제 `/var/lib/kubelet/config.yaml`과 systemd 흐름은 시험 환경과 다릅니다. killer.sh 또는 kubeadm VM에서 최종 연습합니다.
