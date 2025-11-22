
1. Install resources:
```
kubectl apply -f resources.yaml
```

2. Test connectivity:
```
export INGRESS_HOST=$(kubectl get gateways.gateway.networking.k8s.io gateway -n istio-ingress -ojsonpath='{.status.addresses[0].value}')
```

```
curl -s -I "http://$INGRESS_HOST/http-echo"
```