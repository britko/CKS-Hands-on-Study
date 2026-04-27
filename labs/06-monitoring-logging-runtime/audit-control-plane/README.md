# Audit Control Plane

## 목표

- API server static Pod manifest에 audit policy를 연결하는 실제 시험 흐름을 이해한다.
- kind와 kubeadm 시험 환경의 차이를 구분한다.

## 시험 환경 절차

1. audit policy 파일 생성
2. control plane 노드에 policy 파일 배치
3. `kube-apiserver.yaml`에 flag 추가
4. policy/log path를 volume과 volumeMount로 추가
5. API server 재시작 후 정상 상태 확인

## 핵심 flag

```yaml
- --audit-policy-file=/etc/kubernetes/audit-policy.yaml
- --audit-log-path=/var/log/kubernetes/audit.log
- --audit-log-maxage=30
- --audit-log-maxbackup=10
- --audit-log-maxsize=100
```

## 검증

```bash
sudo grep audit /etc/kubernetes/manifests/kube-apiserver.yaml
kubectl get nodes
sudo tail -f /var/log/kubernetes/audit.log
```

## 실수 포인트

- flag만 추가하고 volume/volumeMount를 빠뜨린다.
- Secret 요청을 `RequestResponse`로 기록해 민감 데이터가 로그에 남는다.
- API server가 재시작되지 않을 때 kubelet 로그를 확인하지 않는다.

자세한 경로는 [kubeadm control plane 대비 문서](../../../docs/exam-env/kubeadm-control-plane.md)를 참고합니다.
