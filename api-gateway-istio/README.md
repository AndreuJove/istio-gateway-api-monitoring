
Docs: https://istio.io/

1. To expose Services type LoadBalancer use:
```
sudo minikube tunnel
```

2. Install CRDs:

```
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.4.0" | kubectl apply -f -; }

```

3. Install istiod controller:
```
istioctl install --set profile=minimal -y
```
Is required to use the Service type LoadBalancer 


4. Install gateway and http route:
```
kubectl apply -f gateway.yaml
```



To clean up Istio:

https://istio.io/latest/docs/ambient/getting-started/cleanup/