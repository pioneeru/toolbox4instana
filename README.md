# Tool container

## Installing tool container

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: k8s-101
  namespace: toolbox
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: k8s-101
    spec:
      serviceAccountName: k8s-101-role
      containers:
      - name: k8s-101
        imagePullPolicy: Always
        image: quay.io/swat/toolbox4instana:latest
        ports:
        - name: app
          containerPort: 3000
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: k8s-101-role
  namespace: toolbox
subjects:
- kind: ServiceAccount
  name: k8s-101-role
  namespace: default
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: k8s-101-role
  namespace: toolbox
```