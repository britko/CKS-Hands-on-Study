# 03. System Hardening

공식 CKS v1.34 System Hardening 도메인은 host OS 공격 표면 축소, least privilege, 외부 네트워크 접근 최소화, AppArmor/seccomp 같은 kernel hardening을 다룹니다.

## 학습 순서

1. [Kubelet Hardening](kubelet-hardening/README.md)
2. [Linux Surface Reduction](linux-surface-reduction/README.md)
3. [AppArmor and Seccomp](apparmor-seccomp/README.md)

## 도메인 완료 기준

- kubelet read-only port, anonymous auth, authorization mode를 점검할 수 있다.
- `systemctl`, `journalctl`, `ss`, `ps`, 파일 권한을 빠르게 확인할 수 있다.
- seccomp/AppArmor가 Pod 실행을 어떻게 제한하는지 설명할 수 있다.
