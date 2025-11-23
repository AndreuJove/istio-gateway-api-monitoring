https://github.com/VictoriaMetrics/helm-charts/blob/master/charts/victoria-metrics-k8s-stack/values.yaml
https://docs.victoriametrics.com/helm/victoria-metrics-k8s-stack/


helm repo add vm https://victoriametrics.github.io/helm-charts/


helm show values vm/victoria-metrics-k8s-stack > values.yaml

helm upgrade --install vmks -f values.yaml vm/victoria-metrics-k8s-stack 