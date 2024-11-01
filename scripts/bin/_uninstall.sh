#!/usr/bin/bash

function checkUnit {
    case "$2" in
        instana)
            kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: uninstall-instana
  namespace: toolbox
spec:
  parallelism: 1    
  completions: 1    
  activeDeadlineSeconds: 3600 
  backoffLimit: 6   
  template:         
    metadata:
      name: uninstall-instana
    spec:
      restartPolicy: OnFailure 
      containers:
      - name: uninstall
        image: "quay.io/swat/toolbox4instana:latest"
        command: ["/opt/toolbox/play-instana/ocp/0-uninstall.sh"]
        resources:
          limits:
            memory: 500Mi
          requests:
            cpu: 200m
            memory: 200Mi
        imagePullPolicy: IfNotPresent
        volumeMounts: 
        - name: credentials
          mountPath: /etc/play-instana/
          readOnly: true
    volumes:
      - name: credentials
        secret:
          secretName: toolbox
          items:
          - key: "credentials.env"
            path: credentials.env
            mode: 511
EOF
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

