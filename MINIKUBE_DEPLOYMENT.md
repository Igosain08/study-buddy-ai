# 🐳 Study Buddy AI - Minikube Deployment Guide

## 🎯 Overview

This guide will help you deploy Study Buddy AI on a local Kubernetes cluster using Minikube. Perfect for:
- **Portfolio demonstrations**
- **Interview showcases**
- **Learning Kubernetes**
- **Local development and testing**

## 📋 Prerequisites

### Required Software
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Git](https://git-scm.com/)

### Verify Installation
```bash
# Check Docker
docker --version

# Check Minikube
minikube version

# Check kubectl
kubectl version --client

# Check Git
git --version
```

## 🚀 Step-by-Step Deployment

### 1. Start Minikube Cluster
```bash
# Start Minikube with Docker driver
minikube start --driver=docker

# Verify cluster is running
kubectl cluster-info

# Enable Minikube addons (optional but recommended)
minikube addons enable dashboard
minikube addons enable ingress
```

### 2. Configure Docker Environment
```bash
# Point your shell to minikube's docker-daemon
eval $(minikube docker-env)

# Verify you're using Minikube's Docker
docker ps
```

### 3. Build Docker Image
```bash
# Navigate to your project directory
cd /path/to/study-buddy-ai

# Build the Docker image
docker build -t study-buddy-ai:latest .

# Verify image was built
docker images | grep study-buddy-ai
```

### 4. Create Kubernetes Secret
```bash
# Create secret for Groq API key
kubectl create secret generic groq-api-secret \
  --from-literal=GROQ_API_KEY="your_actual_groq_api_key_here"
```

### 5. Deploy Application
```bash
# Apply Kubernetes manifests
kubectl apply -f manifests/

# Check deployment status
kubectl get pods
kubectl get services
kubectl get deployments
```

### 6. Access the Application
```bash
# Get the service URL
minikube service llmops-service

# Or use kubectl port-forward
kubectl port-forward service/llmops-service 8080:80
```

## 📊 Monitoring & Management

### Check Application Status
```bash
# View all resources
kubectl get all

# Check pod logs
kubectl logs -l app=llmops-app

# Describe deployment
kubectl describe deployment llmops-app

# Check service
kubectl describe service llmops-service
```

### Access Kubernetes Dashboard
```bash
# Open dashboard
minikube dashboard
```

### Scale Application
```bash
# Scale to 3 replicas
kubectl scale deployment llmops-app --replicas=3

# Check scaling
kubectl get pods
```

## 🔧 Troubleshooting

### Common Issues

#### 1. Image Pull Errors
```bash
# If you get image pull errors, ensure you're using Minikube's Docker
eval $(minikube docker-env)
docker build -t study-buddy-ai:latest .
```

#### 2. Port Access Issues
```bash
# Check if service is running
kubectl get services

# Use port-forward if NodePort doesn't work
kubectl port-forward service/llmops-service 8080:80
```

#### 3. API Key Issues
```bash
# Verify secret exists
kubectl get secrets

# Check secret content (base64 encoded)
kubectl get secret groq-api-secret -o yaml
```

#### 4. Pod Crash Issues
```bash
# Check pod status
kubectl get pods

# View detailed pod information
kubectl describe pod <pod-name>

# Check logs
kubectl logs <pod-name>
```

## 🧹 Cleanup

### Stop Minikube
```bash
# Stop the cluster
minikube stop

# Delete the cluster (optional)
minikube delete
```

### Remove Resources
```bash
# Delete all resources
kubectl delete -f manifests/

# Delete secret
kubectl delete secret groq-api-secret
```

## 📸 Portfolio Screenshots

### Recommended Screenshots for Portfolio:

1. **Kubernetes Dashboard** - Show running pods and services
2. **Application UI** - Study Buddy AI interface running
3. **Terminal Output** - kubectl commands and responses
4. **Docker Images** - Built images in Minikube
5. **Service Access** - Application accessible via browser

### Commands for Screenshots:
```bash
# Show cluster info
kubectl cluster-info

# Show all resources
kubectl get all

# Show pod details
kubectl describe pod <pod-name>

# Show service details
kubectl describe service llmops-service

# Show deployment
kubectl describe deployment llmops-app
```

## 🎯 Interview Talking Points

### Technical Skills Demonstrated:
- **Container Orchestration**: Kubernetes deployment and management
- **DevOps Practices**: CI/CD pipeline understanding
- **Microservices**: Containerized application architecture
- **Configuration Management**: Kubernetes secrets and configs
- **Monitoring**: Logs, metrics, and debugging
- **Linux/Unix**: Command line operations and scripting

### Key Concepts to Highlight:
1. **Containerization**: Docker images and containers
2. **Orchestration**: Kubernetes pods, services, deployments
3. **Configuration**: Environment variables and secrets
4. **Networking**: Service discovery and load balancing
5. **Scaling**: Horizontal pod autoscaling
6. **Monitoring**: Logs, metrics, and health checks

## 🔒 Security Notes

- API keys are stored in Kubernetes secrets
- No hardcoded credentials in code
- Proper resource isolation with namespaces
- Secure communication between services

## 📚 Additional Resources

- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Study Buddy AI Repository](https://github.com/YOUR_USERNAME/study-buddy-ai)

---

**Happy Deploying! 🚀✨**
