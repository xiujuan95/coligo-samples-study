#!/bin/bash

# example: ./test-docker-push.sh 5 per-f-tr zoe-test (run 5 taskruns in paraller and the pre-fix is per-f-tr)
func_create_taskrun() {

taskrun_name=${1}
namespace=${2}
cat <<EOF >"${taskrun_name}".yaml
---
apiVersion: tekton.dev/v1beta1
kind: TaskRun
metadata:
  name: ${taskrun_name}
  namespace: ${namespace}
spec:
  taskSpec:
    steps:
      - name: prepare
        image: us.icr.io/zoe_namespace/cranepush
        securityContext:
          runAsUser: 0
          capabilities:
            add: ["CHOWN"]
        env:
          - name: DOCKERCONFIG
            value: '{"auths":{"us.icr.io":{"username":"iamapikey","password":"k2A0Z7Nk0wTOrCrgW4bDM5C_ceka0b9jZsxANdI-B2ng","email":"me@here.com","auth":"aWFtYXBpa2V5OmsyQTBaN05rMHdUT3JDcmdXNGJETTVDX2Nla2EwYjlqWnN4QU5kSS1CMm5n"}}}'
        command: ["/bin/sh"]
        args:
          - -c
          - >
            chown -R "1100:1100" "/tekton/home"
      - name: pull-image
        image: us.icr.io/zoe_namespace/cranepush
        securityContext:
          runAsUser: 1100
        command: ["/bin/sh"]
        args: ["-c", "/home/nonroot/go/bin/crane pull us.icr.io/zoe_namespace/docker /workspace/dockerpush.tar"]
      - name: debug
        image: busybox
        command: ['sh', '-c', 'echo "Hello, Kubernetes!" && sleep 1']
      - name: push-image
        image: us.icr.io/zoe_namespace/cranepush
        securityContext:
          runAsUser: 1100
        command: ["/bin/sh"]
        args: ["-c", "time /home/nonroot/go/bin/crane push /workspace/dockerpush.tar us.icr.io/source_to_image_test/dockerpush"]
EOF

kubectl create -f "${taskrun_name}".yaml
rm -rf "${taskrun_name}".yaml
}

num=${1}
taskrun_prefix=${2}
namespace=${3}
for ((i = 1; i <= ${num}; i++)); do
    taskrun_name="${taskrun_prefix}-${i}"
    func_create_taskrun "${taskrun_name}" ${namespace}
done