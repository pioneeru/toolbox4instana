#!/usr/bin/bash

git -C /opt/toolbox/play-instana pull --rebase
git -C /opt/toolbox/play-instana checkout ${INSTANA_VERSION}

. /opt/toolbox/play-instana/credentials.env
. /opt/toolbox/play-instana/artefacts.env

wget ${KUBECTL_INSTANA_PLUGIN_URL}/${KUBECTL_INSTANA_PLUGIN} -P /tmp --user=_ --password=${DOWNLOAD_KEY} -nv
tar xzvf /tmp/${KUBECTL_INSTANA_PLUGIN} -C /usr/local/bin/
kubectl instana --version

cd /opt/toolbox/play-instana/ocp
./2-cert-manager.sh
#./3-kubectl-instana.sh
./4-generate_manifests.sh
./5-pull_datastore_charts.sh
./6-install.sh