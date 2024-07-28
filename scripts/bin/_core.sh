#!/usr/bin/bash

function checkCore {
    case "$2" in
        describe)
            kubectl describe core -n instana-core
            ;;
        status)
            kubectl get core -n instana-core
            ;;
        *|help)
            echo "Usage: swat core [OPTION]"
            echo "core options:"
            echo "   core help                           - show this help"
            echo "   core describe                       - check Instana core CRD description"
            echo "   core status                         - check core status"
            exit 1
            ;;
    esac 
}

