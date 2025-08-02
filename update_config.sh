#!/bin/bash

echo "🔧 Study Buddy AI - Configuration Update Script"
echo "================================================"

echo ""
echo "Please provide your information for the CI/CD pipeline:"
echo ""

# Get GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter your GitHub email: " GITHUB_EMAIL

# Get DockerHub username
read -p "Enter your DockerHub username: " DOCKERHUB_USERNAME

echo ""
echo "Updating configuration files..."

# Update Jenkinsfile
sed -i.bak "s/YOUR_USERNAME/$GITHUB_USERNAME/g" Jenkinsfile
sed -i.bak "s/YOUR_GITHUB_USERNAME/$GITHUB_USERNAME/g" Jenkinsfile
sed -i.bak "s/your-email@example.com/$GITHUB_EMAIL/g" Jenkinsfile
sed -i.bak "s/your-dockerhub-username/$DOCKERHUB_USERNAME/g" Jenkinsfile

# Update deployment.yaml
sed -i.bak "s/your-dockerhub-username/$DOCKERHUB_USERNAME/g" manifests/deployment.yaml

echo "✅ Configuration files updated!"
echo ""
echo "📋 Updated files:"
echo "- Jenkinsfile"
echo "- manifests/deployment.yaml"
echo ""
echo "🎯 Next steps:"
echo "1. Create GitHub repository: study-buddy-ai"
echo "2. Create DockerHub repository: study-buddy-ai"
echo "3. Follow ORIGINAL_DEPLOYMENT_SETUP.md"
echo ""
echo "📖 See ORIGINAL_DEPLOYMENT_SETUP.md for full setup instructions!" 