
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
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```
Verify installation:
```
minikube version
```


2. Install kubectl:
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl
```
Verify installation:
```
kubectl version
```

### Install Kubernetes Gateway API using Istio:

