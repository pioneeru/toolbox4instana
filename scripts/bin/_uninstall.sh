#!/usr/bin/bash

function checkUninstall {
    case "$2" in
        instana)
            kubectl delete job uninstall-instana &> /dev/null
            kubectl apply -f /opt/toolbox/jobs/uninstall.yaml
            #kubectl wait --for=jsonpath='{.status.succeeded}'=1 job uninstall-instana --timeout=600s
            ;;
        *|help)
            echo "Usage: swat uninstall [OPTION]"
            echo "unit options:"
            echo "   uninstall help                           - show this help"
            echo "   uninstall instana                        - start job to uninstall instana"
            exit 1
            ;;
    esac 
}

