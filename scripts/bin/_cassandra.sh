#!/usr/bin/bash

shopt -s expand_aliases
. /opt/toolbox/instana.env

checkCass {
    case "$2" in
        status)
            cass nodetool status
            ;;
        tpstats)
            cass nodetool tpstats
            ;;
        keyspaces|ks)
            casssql "select * from system_schema.keyspaces;"
            ;;
        *|help)
            echo "Usage: swat cassandra [OPTION]"
            echo "cassandra (short: cs) options:"
            echo "   cs help                           - show this help"
            echo "   cs keyspaces (short: ks)          - check cassandra cluster keyspaces"
            echo "   cs status                         - check cassandra cluster status"
            echo "   cs tpstats                        - print cassandra usage statistics of thread pools"
            exit 1
            ;;
    esac 
}

