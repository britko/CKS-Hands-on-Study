# kubeadm Control Plane 시험 대비

kind는 control plane을 Docker 또는 Podman container로 실행하므로 실제 CKS 시험의 kubeadm 기반 파일 경로와 완전히 같지 않습니다. 다음 항목은 killer.sh 또는 kubeadm VM에서 최종 확인합니다.

## 자주 보는 경로

```bash
/etc/kubernetes/manifests/kube-apiserver.yaml
/etc/kubernetes/manifests/kube-controller-manager.yaml
/etc/kubernetes/manifests/kube-scheduler.yaml
/etc/kubernetes/pki/
/var/lib/etcd/
/var/lib/kubelet/config.yaml
```

## audit 설정 흐름

1. audit policy 파일을 control plane 노드에 배치한다.
2. `kube-apiserver.yaml`에 `--audit-policy-file`, `--audit-log-path`를 추가한다.
3. policy/log 파일 경로를 volume/volumeMount에 추가한다.
4. API server가 재시작되어 정상 Ready가 되는지 확인한다.

## kubelet 점검 흐름

```bash
ps aux | grep kubelet
sudo systemctl status kubelet
sudo journalctl -u kubelet --no-pager
sudo grep -E "anonymous|authorization|readOnly" /var/lib/kubelet/config.yaml
```

## etcd 점검 흐름

```bash
sudo ETCDCTL_API=3 etcdctl endpoint health \
  --cacert=<ca.crt> \
  --cert=<server.crt> \
  --key=<server.key>
```

## 시험 주의사항

- static Pod manifest를 잘못 수정하면 API server가 내려갈 수 있으므로 원본을 백업한다.
- flag만 추가하지 말고 필요한 volume/volumeMount도 같이 추가한다.
- 변경 후 `kubectl get nodes`와 container runtime 로그를 확인한다.
