#!/bin/bash

# example: ./docker-push-time.sh zoe-test test.csv
namespace=${1}
log_name=${2}
pods_name=`kubectl get pod -n ${namespace} --output name`

for pod in ${pods_name}; do
  debug_container_name=$(kubectl get ${pod} -n ${namespace} -o json | jq -r '.status.containerStatuses[0].name')
  echo "container name: ${debug_container_name}"
  start_time=$(kubectl get ${pod} -n ${namespace} -o json | jq -r '.status.containerStatuses[0].state.terminated.finishedAt')
  echo "start time: ${start_time}"
  push_container_name=$(kubectl get ${pod} -n ${namespace} -o json | jq -r '.status.containerStatuses[-1].name')
  echo "container name: ${push_container_name}"
  end_time=$(kubectl get ${pod} -n ${namespace} -o json | jq -r '.status.containerStatuses[-1].state.terminated.finishedAt')
  echo "end time: ${end_time}"
  timeDiff=$(($(date +%s -d $end_time) - $(date +%s -d $start_time)))
  echo "execution time: $timeDiff"
  echo "${pod},${timeDiff}" >> "${log_name}"
done
