#!/usr/bin/bash

function checkUninstall {
    case "$2" in
        instana)
            kubectl apply -f /opt/toolbox/jobs/uninstall.yaml
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

