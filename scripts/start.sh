#!/usr/bin/bash

wget https://artifact-public.instana.io/artifactory/rel-generic-instana-virtual/infrastructure/kubectl/release-275/kubectl-instana-linux_amd64-release-275-3.tar.gz --user=_ --password=$DOWNLOAD_KEY

while true; do sleep 30; done