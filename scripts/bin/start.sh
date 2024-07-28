#!/usr/bin/bash

wget https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/release-${INSTANA_VERSION}/kubectl-instana-linux_amd64-release-${INSTANA_VERSION}-${INSTANA_VERSION_RELEASE}.tar.gz -P /opt/toolbox/ --user=_ --password=${DOWNLOAD_KEY}
tar xzvf /opt/kubectl-instana-linux_amd64-release-${INSTANA_VERSION}-${INSTANA_VERSION_RELEASE}.tar.gz -C /opt/toolbox/bin/

while true; do sleep 30; done