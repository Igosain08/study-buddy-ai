#!/bin/bash

# 🐳 Study Buddy AI - Minikube Quick Deploy Script
# This script automates the deployment process for local Kubernetes

set -e  # Exit on any error

echo "🚀 Starting Study Buddy AI Minikube Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
print_status "Checking prerequisites..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker Desktop first."
    exit 1
fi

# Check if Minikube is installed
if ! command -v minikube &> /dev/null; then
    print_error "Minikube is not installed. Please install Minikube first."
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    print_error "kubectl is not installed. Please install kubectl first."
    exit 1
fi

print_success "Prerequisites check passed!"

# Start Minikube
print_status "Starting Minikube cluster..."
if ! minikube status | grep -q "Running"; then
    minikube start --driver=docker
    print_success "Minikube cluster started!"
else
    print_status "Minikube cluster is already running."
fi

# Enable addons
print_status "Enabling Minikube addons..."
minikube addons enable dashboard
minikube addons enable ingress
print_success "Addons enabled!"

# Configure Docker environment
print_status "Configuring Docker environment..."
eval $(minikube docker-env)
print_success "Docker environment configured!"

# Build Docker image
print_status "Building Docker image..."
docker build -t study-buddy-ai:latest .
print_success "Docker image built successfully!"

# Check if API key is provided
if [ -z "$1" ]; then
    print_warning "No API key provided. Please provide your Groq API key:"
    print_status "Usage: ./deploy-minikube.sh YOUR_GROQ_API_KEY"
    print_status "Or set the GROQ_API_KEY environment variable"
    exit 1
fi

GROQ_API_KEY=$1

# Create Kubernetes secret
print_status "Creating Kubernetes secret..."
kubectl create secret generic groq-api-secret \
  --from-literal=GROQ_API_KEY="$GROQ_API_KEY" \
  --dry-run=client -o yaml | kubectl apply -f -
print_success "Kubernetes secret created!"

# Deploy application
print_status "Deploying application..."
kubectl apply -f manifests/
print_success "Application deployed!"

# Wait for pods to be ready
print_status "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=llmops-app --timeout=300s
print_success "Pods are ready!"

# Show deployment status
print_status "Deployment status:"
kubectl get all

# Get service URL
print_status "Getting service URL..."
SERVICE_URL=$(minikube service llmops-service --url)
print_success "Application is accessible at: $SERVICE_URL"

# Show useful commands
echo ""
print_status "Useful commands:"
echo "  View logs: kubectl logs -l app=llmops-app"
echo "  Scale up: kubectl scale deployment llmops-app --replicas=3"
echo "  Dashboard: minikube dashboard"
echo "  Port forward: kubectl port-forward service/llmops-service 8080:80"
echo "  Cleanup: kubectl delete -f manifests/ && kubectl delete secret groq-api-secret"

echo ""
print_success "🎉 Study Buddy AI is now running on Minikube!"
print_status "Open your browser and navigate to: $SERVICE_URL"
