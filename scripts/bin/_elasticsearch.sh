#!/usr/bin/bash

shopt -s expand_aliases
. /opt/toolbox/instana.env

function checkES {
    case "$2" in
        cpu)
            es -s -X GET "localhost:9200/_cat/nodes?v=true&s=cpu:desc&pretty"
            ;;        
        mem|memory|heap)
            es -s -X GET "localhost:9200/_cat/nodes?v=true&h=name,node*,heap*&pretty"
            ;;        
        indices|ind)
            es -s -X GET "localhost:9200/_cat/indices?v=true&pretty"
            ;;
        shards)
            es -s -X GET "localhost:9200/_cat/shards?v=true&pretty"
            ;;
        status)
            es -s -X GET "localhost:9200/_cluster/health?filter_path=status,*_shards&pretty"
            es -s -X GET "localhost:9200/_cat/nodes?v=true&pretty"
            ;;
        *|help)
            echo "Usage: swat elastisearch [OPTION]"
            echo "elastisearch (short: es) options:"
            echo "   es help                           - show this help"
            echo "   es cpu                            - check elasticsearch cpu utilization per node"
            echo "   es indices (short: ind)           - check elasticsearch indices"
            echo "   es memory (short: heap, mem)      - check elasticsearch heap and memory utilisation per node"
            echo "   es shards                         - check elasticsearch shards distribution"
            echo "   es status                         - check elasticsearch cluster status"
            exit 1
            ;;
    esac 
}

