FROM registry.access.redhat.com/ubi8/ubi-minimal

RUN \
  # Install updates
  microdnf -y update && \
  # Install git, shadow-utils is needed for groupadd/useradd
  microdnf -y install git go shadow-utils && \
  # Create a non-root user
  groupadd -g 1100 nonroot && \
  useradd -u 1100 -g nonroot nonroot && \
  # Create the workspace
  mkdir /home/nonroot/workspace && \
  echo "#!/bin/bash" > /home/nonroot/workspace/docker-entrypoint.sh && \
  chmod +x /home/nonroot/workspace/docker-entrypoint.sh && \
  echo "export PATH=$PATH:/home/nonroot/go/bin:/home/nonroot/workspace/bin" >> /home/nonroot/workspace/docker-entrypoint.sh && \
  echo "exec \"\$@\"" >> /home/nonroot/workspace/docker-entrypoint.sh && \
  # Correct owner of files inside home directory
  chown -R nonroot:nonroot /home/nonroot && \
  # Cleanup
  microdnf clean all

USER nonroot:nonroot

RUN \
  # Install crane (https://github.com/google/go-containerregistry/tree/master/cmd/crane)
  GO111MODULE=on go get -u github.com/google/go-containerregistry/cmd/crane

ADD --chown=nonroot:nonroot . /home/nonroot/workspace
WORKDIR /home/nonroot/workspace

ENTRYPOINT [ "/home/nonroot/workspace/docker-entrypoint.sh" ]