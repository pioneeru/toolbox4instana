#!/usr/bin/bash

function checkUnit {
    case "$2" in
        describe)
            kubectl describe unit -n instana-units
            ;;
        status)
            kubectl get unit -n instana-units
            ;;
        *|help)
            echo "Usage: swat unit [OPTION]"
            echo "unit options:"
            echo "   unit help                           - show this help"
            echo "   unit describe                       - check Instana unit CRD description"
            echo "   unit status                         - check unit status"
            exit 1
            ;;
    esac 
}

