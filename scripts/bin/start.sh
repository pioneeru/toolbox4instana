#!/usr/bin/bash

git -C /opt/toolbox/play-instana checkout $INSTANA_VERSION

. /opt/toolbox/play-instana/artefacts.env
. /opt/toolbox/play-instana/credentials.env

wget https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/${KUBECTL_INSTANA_PLUGIN} -P /tmp --user=_ --password=${DOWNLOAD_KEY}
tar xzvf /tmp/${KUBECTL_INSTANA_PLUGIN} -C /usr/local/bin/

while true; do sleep 30; done