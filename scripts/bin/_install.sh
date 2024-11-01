#!/usr/bin/bash

function checkInstall {
    case "$2" in
        instana)
            kubectl delete job install-instana &> /dev/null
            kubectl apply -f /opt/toolbox/jobs/install.yaml
            #kubectl wait --for=jsonpath='{.status.succeeded}'=1 job uninstall-instana --timeout=600s
            ;;
        *|help)
            echo "Usage: swat install [OPTION]"
            echo "unit options:"
            echo "   install help                           - show this help"
            echo "   install instana                        - start job to install instana"
            exit 1
            ;;
    esac 
}

