#!/bin/bash

set -euo


############################ Install Istio:
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.4.0" | kubectl apply -f -; }
istioctl install --set profile=minimal -y
kubectl apply -f api-gateway-istio/manifests/gateway.yaml

kubectl wait -n istio-ingress --for=condition=programmed gateways.gateway.networking.k8s.io gateway

export INGRESS_HOST=$(kubectl get gateways.gateway.networking.k8s.io gateway -n istio-ingress -ojsonpath='{.status.addresses[0].value}')
echo INGRESS_HOST: ${INGRESS_HOST}


############################ Install http-echo:
kubectl apply -f http-echo/manifests/resources.yaml 
kubectl wait --for=jsonpath='{.status.phase}'=Running pod -l app=http-echo --timeout=180s

sleep 2
echo Testing:
curl -s -I "http://${INGRESS_HOST}/http-echo"
echo -e "\n\n"


############################# Install PostgreSQL:
helm repo add cnpg https://cloudnative-pg.github.io/charts

helm upgrade --install cnpg \
  --namespace cnpg-system \
  --create-namespace \
  cnpg/cloudnative-pg


# TO DO: password as input variable of the script
helm upgrade --install database \
  --namespace database \
  --create-namespace \
  --version 0.3.1 \
  --values postresql/values.yaml \
  --set postgresql.password="mysecurepassword123" \
  cnpg/cluster


############################ Install victoria metrics + grafana:
helm repo add vm https://victoriametrics.github.io/helm-charts/

helm upgrade --install vmks \
 --namespace vmks \
 --create-namespace \
 --version 0.63.6 \
 --values victoria-metrics-grafana/values.yaml \
 --set grafana.env.GF_SERVER_ROOT_URL=http://${INGRESS_HOST}/grafana \
 --set grafana.env.GF_SERVER_DOMAIN=${INGRESS_HOST} \
 vm/victoria-metrics-k8s-stack

export PASSWORD_GRAFANA=$(kubectl get secret --namespace vmks vmks-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)
kubectl apply -f victoria-metrics-grafana/manifests/http_route.yaml
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/instance=vmks -l app.kubernetes.io/name=grafana -n vmks --timeout=250s

echo "Go to http://${INGRESS_HOST}/grafana"
echo "Password Grafana: ${PASSWORD_GRAFANA}"


