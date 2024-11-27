#!/usr/bin/bash

function checkKafka {

    case "$2" in
        list)
            kt --list
            ;;
        describe)
            TOPIC=""
            if [[ ! -z $3 ]]; then
                TOPIC="--topic $3"
            fi
            kt --describe $TOPIC
            ;;
        *|help)
            echo "Usage: swat install [OPTION]"
            echo "unit options:"
            echo "   k help                 - show this help"
            echo "   k list                 - list topics"
            echo "   k describe [topic]     - describe topic (Default: describes all topics"
            exit 1
            ;;
    esac 
}

