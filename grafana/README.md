


Using CloudNativePG Kubernetes Operator to deploy PostgreSQL


https://cloudnative-pg.io/documentation/current/


1. Install via Helm chart

```
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm upgrade --install cnpg \
  --namespace cnpg-system \
  --create-namespace \
  cnpg/cloudnative-pg
```

2. Check the versions:
```
helm search repo grafana/grafana --versions
```

3. Deploy a Grafana helm chart

```
helm upgrade --install grafana \
  --namespace grafana \
  --create-namespace \
  --version 10.2.0 \
  --values values.yaml \
  grafana/grafana
```

4. Get the password:

```
Release "grafana" does not exist. Installing it now.
NAME: grafana
LAST DEPLOYED: Sun Nov 23 17:28:55 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:

   kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo


2. The Grafana server can be accessed via port 80 on the following DNS name from within your cluster:

   grafana.default.svc.cluster.local

   Get the Grafana URL to visit by running these commands in the same shell:
     export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
     kubectl --namespace default port-forward $POD_NAME 3000

3. Login with the password from step 1 and the username: admin
#################################################################################
######   WARNING: Persistence is disabled!!! You will lose your data when   #####
######            the Grafana pod is terminated.                            #####
#################################################################################
```