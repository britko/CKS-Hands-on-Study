# 시스템 하드닝

시스템 하드닝은 Kubernetes 노드와 운영체제의 공격 표면을 줄이는 영역입니다. 실제 시험에서는 모든 OS 설정을 완성하기보다 위험 서비스를 찾고 최소 권한 원칙을 적용하는 흐름을 이해해야 합니다.

## 핵심 개념

- 노드에는 필요한 패키지와 서비스만 유지한다.
- kubelet 접근은 인증과 인가가 적용되어야 한다.
- 컨테이너 런타임과 노드 파일시스템 접근은 최소화한다.
- SSH, systemd service, file permission은 클러스터 보안과 직접 연결된다.

## 점검 예시

```bash
systemctl --type=service --state=running
ss -tulpn
ps aux | grep kubelet
ls -l /etc/kubernetes/
```

## 시험 포인트

- kubelet read-only port는 비활성화되어야 한다.
- 불필요한 서비스와 포트는 줄인다.
- 노드에서 컨테이너가 hostPath, privileged, hostPID 등을 사용하는지 확인한다.
- kind 환경은 실제 노드 OS 하드닝과 다르므로 개념 복습 위주로 다룬다.

## 시험에서 나오는 작업

- 실행 중인 서비스와 열린 포트를 확인한다.
- kubelet 설정에서 anonymous auth, authorization mode, read-only port를 점검한다.
- 민감한 hostPath를 사용하는 Pod를 찾아 제거하거나 제한한다.
- 노드에서 의심 프로세스와 로그를 확인한다.

## 실수 포인트

- kind에서 가능한 실습과 실제 시험 노드에서 해야 하는 systemd/journalctl 작업을 혼동한다.
- 노드 명령을 실행할 때 control plane과 worker node를 구분하지 않는다.
- 컨테이너 보안 설정만 보고 host-level 위험을 놓친다.

## 연결 실습

- [Pod Security와 SecurityContext](../../labs/03-pod-security/README.md)
- [Runtime Security](../../labs/08-runtime-security/README.md)

## 공식 문서와 추가 학습

- [Security For Linux Nodes](https://kubernetes.io/docs/concepts/security/linux-kernel-security-constraints/)
- [Seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
- [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)
- [Kubelet Configuration](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/)
- [Node Authorization](https://kubernetes.io/docs/reference/access-authn-authz/node/)
