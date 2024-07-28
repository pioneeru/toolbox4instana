# Tool container

## Installing tool container

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: toolbox
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
          values: 275
        - name: INSTANA_VERSION_RELEASE
          values: 0
        - name: DOWNLOAD_KEY
          values: MY_DOWNLOAD_KEY
        name: tool
        imagePullPolicy: Always
        image: quay.io/swat/toolbox4instana:latest
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