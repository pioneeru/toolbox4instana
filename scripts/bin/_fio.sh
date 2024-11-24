#!/usr/bin/bash

function checkFIO {
    STORAGECLASS=$RWO_STORAGECLASS
    if [[ ! -z "$3" ]]; then
       STORAGECLASS=$3
    fi
    case "$2" in
        iops)
            kubectl delete job fio-iops-random &> /dev/null
            eval "cat <<EOF
$(</opt/toolbox/jobs/fio-iops-random.yaml)
EOF
            " | kubectl apply -f -
            ;;
        iops-seq)
            kubectl delete job fio-iops-sequential &> /dev/null
            eval "cat <<EOF
$(</opt/toolbox/jobs/fio-iops-sequential.yaml)
EOF
            " | kubectl apply -f -
            ;;
        latency)
            kubectl delete job fio-latency-random &> /dev/null
            eval "cat <<EOF
$(</opt/toolbox/jobs/fio-latency-random.yaml)
EOF
            " | kubectl apply -f -
            ;;
        perf)
            kubectl delete job fio-perf-random &> /dev/null
            eval "cat <<EOF
$(</opt/toolbox/jobs/fio-perf-random.yaml)
EOF
            " | kubectl apply -f -
            ;;
        perf-seq)
            kubectl delete job fio-perf-sequential &> /dev/null
            eval "cat <<EOF
$(</opt/toolbox/jobs/fio-perf-sequential.yaml)
EOF
            " | kubectl apply -f -
            ;;
        test)
            kubectl delete job fio-perf-sequential &> /dev/null
            RWO_STORAGECLASS=$STORAGECLASS eval "cat <<EOF
$(</opt/toolbox/jobs/fio-perf-sequential.yaml)
EOF
            " | kubectl apply -f -
            echo "used: $RWO_STORAGECLASS"
            ;;
        *|help)
            echo "Usage: swat install [OPTION]"
            echo "unit options:"
            echo "   fio help             - show this help"
            echo "   fio iops             - start job to test IOPS with random read/write on storageClass: $RWO_STORAGECLASS"
            echo "   fio iops-seq         - start job to test IOPS with sequential read on storageClass: $RWO_STORAGECLASS"
            echo "   fio latency          - start job to test Latency with random read/write on storageClass: $RWO_STORAGECLASS"
            echo "   fio perf             - start job to test Performance with random read/write on storageClass: $RWO_STORAGECLASS"
            echo "   fio perf-seq         - start job to test Performance with sequential read on storageClass: $RWO_STORAGECLASS"
            exit 1
            ;;
    esac 
}

