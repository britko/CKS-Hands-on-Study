# CIS Benchmark

## 목표

- CIS benchmark가 Kubernetes component 설정을 어떻게 점검하는지 이해한다.
- kube-bench 결과에서 PASS/WARN/FAIL 항목을 읽고 우선순위를 정한다.

## 실습

kind에서는 host와 control plane 구조가 실제 시험과 다르므로, 이 랩은 결과 해석 중심입니다. kube-bench가 설치된 환경에서는 다음을 실행합니다.

```bash
kube-bench run --targets master,node
```

Pod/Job 형태로 실행하는 환경에서는 제공된 manifest나 공식 문서를 사용합니다.

```bash
kubectl get jobs -A
kubectl logs -n <namespace> job/<kube-bench-job>
```

## 확인할 항목

- API server anonymous auth
- etcd cert/key permission
- kubelet read-only port
- kubelet authorization mode
- admission plugin 설정

## 시험형 문제

FAIL 항목 3개를 골라 다음 형식으로 정리합니다.

```text
항목:
위험:
확인 명령:
수정 방향:
kind 한계 또는 실제 노드 필요 여부:
```

## 참고

- [kube-bench](https://github.com/aquasecurity/kube-bench)
- [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes)
