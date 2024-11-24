FROM registry.access.redhat.com/ubi9-minimal
ARG CONT_IMG_VER
ENV CONT_IMG_VER=v1.0.23
COPY .bashrc /root
COPY scripts/bin/swat /usr/local/bin/
COPY scripts /opt/toolbox
RUN microdnf install -y gcc git tar wget vi podman
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
RUN wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-amd64-rhel8.tar.gz && \
    tar xzvf openshift-client-linux-amd64-rhel8.tar.gz -C /usr/local/bin/
RUN cd /opt/toolbox && \
    git clone https://github.com/pioneeru/play-instana.git && \
    ln -s /etc/play-instana/credentials.env /opt/toolbox/play-instana/credentials.env && \
    chmod -R 777 /opt/toolbox/bin
RUN cd /opt/toolbox && git clone https://github.com/axboe/fio.git && cd /opt/toolbox/fio && ./configure && make && make install && rm -rf /opt/toolbox/fio
    
ENTRYPOINT ["/opt/toolbox/bin/start.sh"]