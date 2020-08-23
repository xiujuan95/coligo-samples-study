#!/bin/bash

# example: ./br-create-to-tr-create.sh zoe-test test.csv
namespace=${1}
log_name=${2}
brs_name=$(kubectl get br -n ${namespace} --output name)

for br in ${brs_name}; do
  br_name=$(kubectl get ${br} -n ${namespace} -o json | jq -r '.metadata.name')

  br_create_time=$(kubectl get ${br} -n ${namespace} -o json | jq -r '.metadata.creationTimestamp')
  echo "BuildRun creation time: $br_create_time"
  tr_name=$(kubectl get ${br} -n ${namespace} -o json | jq -r '.status.latestTaskRunRef')
  echo "$tr_name"
  tr_create_time=$(kubectl get tr ${tr_name} -n ${namespace} -o json | jq -r '.metadata.creationTimestamp')
  echo "TaskRun creation time: ${tr_create_time}"
  from_br_to_tr=$(($(date +%s -d $tr_create_time) - $(date +%s -d $br_create_time)))
  echo "From BuildRun create to TaskRun create time: ${from_br_to_tr}"
  echo "${br},${from_br_to_tr}" >> "${log_name}"
done