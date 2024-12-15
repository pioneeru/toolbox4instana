FROM registry.access.redhat.com/ubi9-minimal
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.37
COPY .bashrc /root
COPY scripts/bin/swat /usr/local/bin/
COPY scripts /opt/toolbox
RUN microdnf install -y git tar wget vi podman
RUN cd /opt && curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
RUN cd /opt  && \
    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-amd64-rhel8.tar.gz && \
    tar xzvf openshift-client-linux-amd64-rhel8.tar.gz -C /usr/local/bin/ && \
    rm openshift-client-linux-amd64-rhel8.tar.gz
RUN microdnf install -y gcc libaio zlib-devel && \
    cd /opt && \
    wget https://mirror.stream.centos.org/9-stream/AppStream/x86_64/os/Packages/libaio-devel-0.3.111-13.el9.x86_64.rpm && \
    rpm -Uhv libaio-devel-0.3.111-13.el9.x86_64.rpm && \
    git clone https://github.com/axboe/fio.git && \
    cd /opt/fio && \
    ./configure && make && make install && \
    rm -rf /opt/fio /opt/libaio-devel-0.3.111-13.el9.x86_64.rpm
RUN cd /opt/toolbox && \
    git clone https://github.com/pioneeru/play-instana.git && \
    ln -s /etc/play-instana/credentials.env /opt/toolbox/play-instana/credentials.env && \
    chmod -R 777 /opt/toolbox/bin
    
ENTRYPOINT ["/opt/toolbox/bin/start.sh"]