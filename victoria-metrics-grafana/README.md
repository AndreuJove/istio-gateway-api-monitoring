
We are using victoria-metrics-k8s-stack:

- https://docs.victoriametrics.com/helm/victoria-metrics-k8s-stack/
- https://github.com/VictoriaMetrics/helm-charts/blob/master/charts/victoria-metrics-k8s-stack/values.yaml


1. helm repo add vm https://victoriametrics.github.io/helm-charts/

2. Get the values of the helm chart:

```
helm show values vm/victoria-metrics-k8s-stack > values.yaml
```

3. Modify the values.yaml with the ip of your LoadBalancer Service

```
kubectl get svc -A | grep LoadBalancer
```

4. helm upgrade --install vmks -f values.yaml vm/victoria-metrics-k8s-stack 

```
helm upgrade --install vmks -f values.yaml vm/victoria-metrics-k8s-stack --create-namespace vmks --namespace vmks 
```

5. Get the password and login:

```
username: admin
password: kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

```

6. Go to:

http://10.110.107.127/grafana


7. Apply the http_route to visit:

```
kubectl apply -f http_route.yaml
```


---
 
To delete the helm installation:

helm uninstall vmks --debug