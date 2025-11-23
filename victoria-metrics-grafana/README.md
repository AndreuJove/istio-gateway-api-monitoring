
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








To delete the helm installation:

helm uninstall vmks --debug