#!/bin/bash

set -euox


# Install Istio:

kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.4.0" | kubectl apply -f -; }
istioctl install --set profile=minimal -y
kubectl apply -f api-gateway-istio/manifests/gateway.yaml

kubectl wait -n istio-ingress --for=condition=programmed gateways.gateway.networking.k8s.io gateway

export INGRESS_HOST=$(kubectl get gateways.gateway.networking.k8s.io gateway -n istio-ingress -ojsonpath='{.status.addresses[0].value}')
echo INGRESS_HOST: $INGRESS_HOST



# Install http-echo:

kubectl apply -f http-echo/manifests/resources.yaml 
kubectl wait --for=condition=Ready pod -l app=http-echo --timeout=180s


echo Testing:
curl -s -I "http://$INGRESS_HOST/http-echo"

echo -e "\n\n"


# Install PostgreSQL:


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



# Install victoria metrics 


sed -i "s/<INGRESS_DOMAIN>/${INGRESS_HOST}/g" victoria-metrics-grafana/values.yaml

helm upgrade --install vmks \
 -f victoria-metrics-grafana/values.yaml \ 
 --create-namespace vmks \
 --namespace vmks \
 vm/victoria-metrics-k8s-stack

export PASSWORD_GRAFANA=$(kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)

echo Password Grafana:
echo $PASSWORD_GRAFANA


echo Go to "http://${INGRESS_HOST}/grafana"
