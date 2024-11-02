#!/usr/bin/bash

. /opt/toolbox/play-instana/artefacts.env
. /opt/toolbox/play-instana/credentials.env

# wget https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/${KUBECTL_INSTANA_PLUGIN} -P /tmp --user=_ --password=${DOWNLOAD_KEY}
# tar xzvf /tmp/${KUBECTL_INSTANA_PLUGIN} -C /usr/local/bin/

cd /opt/toolbox/play-instana/ocp
./2-cert-manager.sh
./3-kubectl-instana.sh
./4-generate_manifests.sh
./5-pull_datastore_charts.sh
./6-install.sh