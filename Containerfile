FROM registry.access.redhat.com/ubi9-minimal
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.8
RUN microdnf install -y git tar wget vi
RUN cd /opt && \
    git clone https://github.com/pioneeru/play-instana.git && \
    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-amd64-rhel8.tar.gz && \
    tar xzvf openshift-client-linux-amd64-rhel8.tar.gz -C /usr/bin/ && \
    wget https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/release-275/kubectl-instana-linux_amd64-release-275-3.tar.gz --user=_ --password=$DOWNLOAD_KEY && \
    chmod -R 777 /opt

ENTRYPOINT ["/bin/sh","-c","--","while true; do sleep 30; done"]