FROM registry.access.redhat.com/ubi9-minimal
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.9
RUN microdnf install -y git tar wget vi
RUN cd /opt && \
    git clone https://github.com/pioneeru/play-instana.git && \
    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-amd64-rhel8.tar.gz && \
    tar xzvf openshift-client-linux-amd64-rhel8.tar.gz -C /usr/bin/ && \
    cp -R scripts /opt/ && \
    chmod -R 777 /opt

ENTRYPOINT ["./scripts/start.sh"]