
# Components:
- Ingress or gateway api controller (Istio Gateway API)
- HTTP/HTTPS Echo Service (mendhak/http-https-echo)
- PostgreSQL database
- Grafana
- VictoriaMetrics

## Prerequisites:

Linux amd64 Ubuntu 22.04.5 LTS (Jammy Jellyfish)

1. Install minikube:
```
curl -LO https://github.com/kubernetes/minikube/releases/download/v1.36.0/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```
Verify installation:
```
minikube version
```


2. Install kubectl:
```
curl -LO "https://dl.k8s.io/release/v1.34.1/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl
```
Verify installation:
```
kubectl version
```

3. Install helm

```
curl -LO https://get.helm.sh/helm-v3.19.2-linux-amd64.tar.gz
tar -zxvf helm-v3.19.2-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm

```

4. Install istioctl
```
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.28.0 TARGET_ARCH=x86_64 sh -
sudo mv istio-1.28.0/bin/istioctl /usr/local/bin/istioctl

```

## Installation:


1. Start a minikube cluster:

```
minikube start -p test-istio --kubernetes-version=v1.33.0 --cpus=4 --memory=4096
```

2. Check the nodes:
```
kubectl get nodes
```

3. Activate profile of minikube:
```
minikube profile test-istio
```

4. To expose Services type LoadBalancer use:
```
minikube tunnel
```

5. Execute script:
```
./start_up.sh
```

6. Go to:

/grafana
/http-echo

7. Delete minikube:
```
minikube delete -p test-istio
```