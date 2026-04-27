# 03. System Hardening

비중: 10%

System Hardening은 Kubernetes 리소스 밖의 노드와 운영체제 공격 표면을 줄이는 영역입니다. kubelet 설정, OS 서비스/포트 점검, least privilege, AppArmor/seccomp가 중요합니다.

## 시험에서 나오는 작업

- kubelet read-only port, anonymous auth, authorization mode를 확인한다.
- 불필요한 systemd service와 열린 포트를 찾는다.
- 파일/소켓 권한을 최소화한다.
- seccomp 또는 AppArmor profile을 Pod에 적용한다.

## 필수 명령

```bash
systemctl --type=service --state=running
journalctl -u kubelet --no-pager
ss -tulpn
ps aux
ls -l /var/lib/kubelet /etc/kubernetes
kubectl get pod <pod> -o yaml
```

## 실수 포인트

- kind에서 재현되는 것과 실제 노드에서 해야 하는 systemd 작업을 혼동한다.
- kubelet config와 kubelet command line flag를 모두 확인하지 않는다.
- AppArmor/seccomp 설정 위치를 Pod와 container securityContext에서 혼동한다.

## 연결 실습

- [System Hardening 랩](../../labs/03-system-hardening/README.md)
- [kubeadm control plane 대비 문서](../exam-env/kubeadm-control-plane.md)
