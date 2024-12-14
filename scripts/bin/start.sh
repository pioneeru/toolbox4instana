#!/usr/bin/bash

git -C /opt/toolbox/play-instana pull --rebase
git -C /opt/toolbox/play-instana checkout $INSTANA_VERSION

. /opt/toolbox/instana.env
. /opt/toolbox/play-instana/credentials.env
. /opt/toolbox/play-instana/artefacts.env

wget ${KUBECTL_INSTANA_PLUGIN_URL}/${KUBECTL_INSTANA_PLUGIN} -P /tmp --user=_ --password=${DOWNLOAD_KEY} -nv
tar xzvf /tmp/${KUBECTL_INSTANA_PLUGIN} -C /usr/local/bin/
kubectl instana --version

touch /tmp/healthy
while true; do sleep 30; done