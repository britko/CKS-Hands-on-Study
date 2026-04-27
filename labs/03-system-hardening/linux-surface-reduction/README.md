# Linux Surface Reduction

## 목표

- 노드 OS의 공격 표면을 줄이기 위한 기본 조사 명령을 익힌다.
- 불필요한 서비스, 열린 포트, 위험한 파일 권한을 찾는다.

## 조사 명령

```bash
systemctl --type=service --state=running
ss -tulpn
ps aux --sort=-%mem | head
journalctl -p warning --since "1 hour ago" --no-pager
ls -l /var/run/containerd/containerd.sock
ls -l /var/lib/kubelet/
```

## 시험형 문제

1. 실행 중인 서비스 중 Kubernetes 운영에 불필요해 보이는 서비스를 찾는다.
2. 외부에 열려 있는 포트를 정리한다.
3. container runtime socket 권한을 확인한다.
4. kubelet 로그에서 warning/error를 찾는다.

## 시험 팁

- CKS는 Kubernetes만이 아니라 Linux 기본 조사 능력도 요구한다.
- `grep`, `journalctl`, `ss`, `systemctl`을 빠르게 사용해야 한다.
- 변경 전에는 서비스 이름과 의존성을 확인한다.
