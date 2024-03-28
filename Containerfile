FROM registry.access.redhat.com/ubi9-minimal
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.7
RUN microdnf install -y git
RUN cd /opt && \
    git clone https://github.com/pioneeru/play-instana.git && \
    chmod -R 777 /opt

ENTRYPOINT ["/bin/sh","-c","--","while true; do sleep 30; done"]