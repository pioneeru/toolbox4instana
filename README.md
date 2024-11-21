# Tool container

## Installing tool container

before applying update toolbox secret below with correct values:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: toolbox
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: toolbox4instana
  namespace: toolbox
data:
  instana-version: main
---
apiVersion: v1
kind: Secret
metadata:
  name: toolbox
  namespace: toolbox
stringData:
  "credentials.env": |
    KUBECTL=oc              ### Prefix for "kubectl" commands [oc/kubectl]

    ### Docker HUB credentials
    DOCKER_USERNAME=
    DOCKER_PASSWORD=



    ### Instana credentials
    SALES_KEY=
    DOWNLOAD_KEY=
    INSTANA_UNIT_NAME=unit0
    INSTANA_TENANT_NAME=tenant0
    INSTANA_BASE_DOMAIN=instana.apps.mycluster.com
    INSTANA_TENANT_DOMAIN=${INSTANA_UNIT_NAME}-${INSTANA_TENANT_NAME}.${INSTANA_BASE_DOMAIN}
    INSTANA_AGENT_ACCEPTOR=agent-acceptor.${INSTANA_BASE_DOMAIN}
    INSTANA_OTLP_GRPC_ACCEPTOR=otlp-grpc.${INSTANA_BASE_DOMAIN}
    INSTANA_OTLP_HTTP_ACCEPTOR=otlp-http.${INSTANA_BASE_DOMAIN}
    INSTANA_ADMIN_USER=admin@instana.local
    INSTANA_ADMIN_PASSWORD=mypass



    ### Storage class
    RWO_STORAGECLASS=nfs-client
    RWX_STORAGECLASS=nfs-client



    ### NFS config when needed (in use by 1-nfs.sh)
    NFS_SERVER_IP=
    NFS_SERVER_PATH=/data



    ### Datastore configs
    BEEINSTANA_ADMIN_PASS=alkDFjsddaffcaj1bjhg

    CLICKHOUSE_ADMIN="default"
    CLICKHOUSE_ADMIN_PASS="clickhouse-pass"
    CLICKHOUSE_USER="clickhouse-user"
    CLICKHOUSE_USER_PASS="clickhouse-pass"



    ### Certificates
    TLS_CERTIFICATE_FILE=tls.crt
    TLS_KEY_FILE=tls.key

    KEY_PEM_PASSWORD=mykeypass                              # Password for the key/cert file (SAML/OIDC)
    TOKEN_SECRET=mytokensecret              # Seed for creating crypto tokens. Pick a random 12 char string

    TLS_CERTIFICATE_GENERATE=YES   # Should we generate self-signed certificate or use exising tls.crt [YES/NO]
    TLS_CERTIFICATE_GENERATE_C="US"
    TLS_CERTIFICATE_GENERATE_ST="New York"
    TLS_CERTIFICATE_GENERATE_L="Rochester"
    TLS_CERTIFICATE_GENERATE_O="End Point"
    TLS_CERTIFICATE_GENERATE_OU="Testing Domain"
    TLS_CERTIFICATE_GENERATE_emailAddress="test@example.com"
    TLS_CERTIFICATE_GENERATE_CN="${INSTANA_BASE_DOMAIN}"
    TLS_CERTIFICATE_GENERATE_Alt1="${INSTANA_AGENT_ACCEPTOR}"
    TLS_CERTIFICATE_GENERATE_Alt2="${INSTANA_TENANT_DOMAIN}"


    ### File names for manifests
    MANIFEST_FILENAME_ZOOKEEPER=zookeeper.yaml
    MANIFEST_FILENAME_CLICKHOUSE=clickhouse.yaml
    MANIFEST_FILENAME_CLICKHOUSE_SCC=clickhouse_scc.yaml
    MANIFEST_FILENAME_KAFKA=kafka.yaml
    MANIFEST_FILENAME_ELASTICSEARCH=elasticsearch.yaml
    MANIFEST_FILENAME_POSTGRES=postgres.yaml
    MANIFEST_FILENAME_POSTGRES_SCC=postgres-scc.yaml        # OCP 
    MANIFEST_FILENAME_CASSANDRA=cassandra.yaml
    MANIFEST_FILENAME_CASSANDRA_SCC=cassandra-scc.yaml      # OCP 
    MANIFEST_FILENAME_BEEINSTANA=beeinstana.yaml
    MANIFEST_FILENAME_CORE=core.yaml
    MANIFEST_FILENAME_UNIT=unit.yaml
type: Opaque
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tool
  namespace: toolbox
  labels:
    deployment: tool
spec:
  replicas: 1
  selector:
    matchLabels:
      deployment: tool
  template:
    metadata:
      labels:
        deployment: tool
    spec:
      serviceAccountName: tool-role
      containers:
      - env:
        - name: INSTANA_VERSION
          valueFrom:
            configMapKeyRef:
              name: toolbox4instana
              key: instana-version
        - name: INSTANA_VERSION_RELEASE
          values: 0
        - name: DOWNLOAD_KEY
          values: MY_DOWNLOAD_KEY
        name: tool
        imagePullPolicy: Always
        image: quay.io/swat/toolbox4instana:latest
        readinessProbe:
          exec:
            command:
            - cat
            - /tmp/healthy
          initialDelaySeconds: 5
          periodSeconds: 5
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
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: tool-role
  namespace: toolbox
subjects:
- kind: ServiceAccount
  name: tool-role
  namespace: toolbox
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tool-role
  namespace: toolbox
```