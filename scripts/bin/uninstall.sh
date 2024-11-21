#!/usr/bin/bash

git -C /opt/toolbox/play-instana checkout $INSTANA_VERSION

. /opt/toolbox/play-instana/artefacts.env
. /opt/toolbox/play-instana/credentials.env

wget ${KUBECTL_INSTANA_PLUGIN_URL}/${KUBECTL_INSTANA_PLUGIN} -P /tmp --user=_ --password=${DOWNLOAD_KEY}
tar xzvf /tmp/${KUBECTL_INSTANA_PLUGIN} -C /usr/local/bin/

cd /opt/toolbox/play-instana/ocp
./0-uninstall.sh