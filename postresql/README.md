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

2. Deploy a PostgreSQL cluster

```
helm upgrade --install database \
  --namespace database \
  --create-namespace \
  --version 0.3.1 \
  --values values.yaml \
  --set postgresql.password="mysecurepassword123" \
  cnpg/cluster
```
