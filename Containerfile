FROM registry.access.redhat.com/ubi9-minimal
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.7
RUN microdnf install -y git tar
RUN cd /opt && \
    git clone https://github.com/pioneeru/play-instana.git && \
    curl -O https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-amd64-rhel9.tar.gz && \
    tar xzvf openshift-client-linux-amd64-rhel9.tar.gz -C /usr/bin/ && \
    chmod -R 777 /opt

ENTRYPOINT ["/bin/sh","-c","--","while true; do sleep 30; done"]