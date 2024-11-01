#!/usr/bin/bash

. /opt/toolbox/play-instana/artefacts.env
. /opt/toolbox/play-instana/credentials.env

# wget https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/release-${INSTANA_VERSION}/kubectl-instana-linux_amd64-release-${INSTANA_VERSION}-${INSTANA_VERSION_RELEASE}.tar.gz -P /opt/toolbox/ --user=_ --password=${DOWNLOAD_KEY}
# tar xzvf /opt/toolbox/kubectl-instana-linux_amd64-release-${INSTANA_VERSION}-${INSTANA_VERSION_RELEASE}.tar.gz -C /usr/local/bin/

wget https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/${KUBECTL_INSTANA_PLUGIN} -P /tmp --user=_ --password=${DOWNLOAD_KEY}
tar xzvf /tmp/${KUBECTL_INSTANA_PLUGIN} -C /usr/local/bin/

while true; do sleep 30; done