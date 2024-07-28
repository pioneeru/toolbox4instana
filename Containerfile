FROM registry.access.redhat.com/ubi9-minimal
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.12
COPY .bashrc /root
COPY scripts/bin/swat /usr/local/bin/
COPY scripts /opt/toolbox
RUN microdnf install -y git tar wget vi
RUN cd /opt/toolbox && \
    git clone https://github.com/pioneeru/play-instana.git && \
    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-amd64-rhel8.tar.gz && \
    tar xzvf openshift-client-linux-amd64-rhel8.tar.gz -C /usr/local/bin/ && \
    chmod -R 777 /opt/toolbox/bin

ENTRYPOINT ["/opt/toolbox/bin/start.sh"]