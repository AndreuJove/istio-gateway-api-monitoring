


1. Modify the values.yaml with the ip of your LoadBalancer Service

```
kubectl get svc -A | grep LoadBalancer
```


2. Install via Helm chart check the version it can be upgraded.

```
helm repo add grafana https://grafana.github.io/helm-charts

helm search repo grafana/grafana --versions

helm upgrade --install grafana \
  --namespace grafana \
  --create-namespace \
  --version 10.2.0 \
  --values values.yaml \
  grafana/grafana
```


3. Get the password and login:

```

username: admin
password: kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

```

4. Apply the http_route to visit:

```
kubectl apply -f http_route.yaml
```