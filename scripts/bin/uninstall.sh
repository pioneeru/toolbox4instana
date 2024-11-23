#!/usr/bin/bash

git -C /opt/toolbox/play-instana pull
git -C /opt/toolbox/play-instana checkout $INSTANA_VERSION

. /opt/toolbox/play-instana/artefacts.env
. /opt/toolbox/play-instana/credentials.env

wget ${KUBECTL_INSTANA_PLUGIN_URL}/${KUBECTL_INSTANA_PLUGIN} -P /tmp --user=_ --password=${DOWNLOAD_KEY} -nv
tar xzvf /tmp/${KUBECTL_INSTANA_PLUGIN} -C /usr/local/bin/
kubectl instana --version

cd /opt/toolbox/play-instana/ocp
./0-uninstall.sh