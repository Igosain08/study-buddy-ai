#!/bin/bash

# Create Kubernetes secret for GROQ API Key
# Run this command in your Kubernetes cluster

# Create Kubernetes secret for GROQ API Key
# Replace YOUR_GROQ_API_KEY with your actual API key
kubectl create secret generic groq-api-secret \
  --from-literal=GROQ_API_KEY="YOUR_GROQ_API_KEY" \
  -n argocd

echo "✅ GROQ API Key secret created successfully!"
echo "🔍 Verify with: kubectl get secrets -n argocd"
