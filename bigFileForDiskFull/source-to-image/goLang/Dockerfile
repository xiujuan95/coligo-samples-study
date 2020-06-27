#FROM golang:1.11-alpine AS build
#
## Install tools required for project
## Run `docker build --no-cache .` to update dependencies
#RUN apk add --no-cache git
#RUN go get github.com/golang/dep/cmd/dep

FROM ubuntu
ENTRYPOINT ["/bin/bash", "-c", "mkdir -p /tmp/demo"]
RUN dd if=/dev/zero of=bigFile-br-0.txt bs=1M count=200
ENTRYPOINT ["/bin/bash", "-c", "sleep 20s"]
RUN dd if=/dev/zero of=bigFile-br-1.txt bs=1M count=200
ENTRYPOINT ["/bin/bash", "-c", "sleep 20s"]
RUN dd if=/dev/zero of=bigFile-br-2.txt bs=1M count=200
ENTRYPOINT ["/bin/bash", "-c", "sleep 20s"]
RUN dd if=/dev/zero of=bigFile-br-3.txt bs=1M count=200
ENTRYPOINT ["/bin/bash", "-c", "sleep 20s"]
RUN dd if=/dev/zero of=bigFile-br-4.txt bs=1M count=200
ENTRYPOINT ["/bin/bash", "-c", "sleep 20s"]
RUN dd if=/dev/zero of=bigFile-br-5.txt bs=1M count=200
ENTRYPOINT ["/bin/bash", "-c", "echo end"]