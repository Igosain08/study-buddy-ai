# 🚀 Original Project Deployment Setup

## 📋 **Following the Original CI/CD Pipeline**

The original project used:
- **Google Cloud Platform (GCP)** for VM instance
- **Jenkins** for CI/CD pipeline
- **Docker** for containerization
- **Minikube** for local Kubernetes
- **ArgoCD** for GitOps deployment

## 🎯 **Step-by-Step Setup (Exactly Like Original)**

### **Step 1: Google Cloud Platform Setup**

1. **Create GCP Account:**
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create new project or use existing
   - Enable billing (free tier available)

2. **Create VM Instance:**
   - Go to **Compute Engine → VM Instances**
   - Click **"Create Instance"**
   - **Name**: `gitops`
   - **Machine Type**: E2 Standard (16 GB RAM)
   - **Boot Disk**: 256 GB Ubuntu 24.04 LTS
   - **Networking**: Enable HTTP and HTTPS traffic
   - **Create Instance**

3. **Connect to VM:**
   - Use SSH option in GCP console
   - Or use gcloud CLI: `gcloud compute ssh gitops`

### **Step 2: Install Dependencies on VM**

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kubectl
sudo snap install kubectl --classic

# Start Minikube
minikube start --driver=docker
```

### **Step 3: Set Up Jenkins**

```bash
# Run Jenkins in Docker
docker run -d --name jenkins \
-p 8080:8080 \
-p 50000:50000 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
-u root \
-e DOCKER_GID=$(getent group docker | cut -d: -f3) \
--network minikube \
jenkins/jenkins:lts

# Get Jenkins admin password
docker logs jenkins
```

### **Step 4: Configure Jenkins**

1. **Access Jenkins**: `http://YOUR_VM_IP:8080`
2. **Install Suggested Plugins**
3. **Create Admin User**
4. **Install Additional Plugins**:
   - Docker
   - Docker Pipeline
   - Kubernetes

### **Step 5: Set Up GitHub Integration**

1. **Generate GitHub Token:**
   - Go to GitHub → Settings → Developer Settings → Personal Access Tokens
   - Generate new token with permissions: `repo`, `admin:org`, `workflow`

2. **Add GitHub Credentials in Jenkins:**
   - Manage Jenkins → Credentials → Global → Add Credentials
   - **Username**: Your GitHub username
   - **Password**: Your GitHub token
   - **ID**: `github-token`

### **Step 6: Set Up DockerHub Integration**

1. **Create DockerHub Account**
2. **Generate DockerHub Access Token**
3. **Add DockerHub Credentials in Jenkins:**
   - **Username**: Your DockerHub username
   - **Password**: Your DockerHub token
   - **ID**: `dockerhub-token`

### **Step 7: Update Configuration Files**

#### **Update Jenkinsfile:**
```groovy
// Replace these placeholders:
DOCKER_HUB_REPO = "YOUR_DOCKERHUB_USERNAME/study-buddy-ai"
url: 'https://github.com/YOUR_USERNAME/study-buddy-ai.git'
git config user.name "YOUR_GITHUB_USERNAME"
git config user.email "your-email@example.com"
```

#### **Update manifests/deployment.yaml:**
```yaml
# Replace this line:
image: YOUR_DOCKERHUB_USERNAME/study-buddy-ai:v1
```

### **Step 8: Set Up ArgoCD**

```bash
# Create namespace
kubectl create ns argocd

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Change service type to NodePort
kubectl edit svc argocd-server -n argocd
# Change: type: ClusterIP to type: NodePort

# Get ArgoCD admin password
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

### **Step 9: Push Your Code to GitHub**

```bash
# On your local machine
git remote add origin https://github.com/YOUR_USERNAME/study-buddy-ai.git
git push -u origin main
```

### **Step 10: Create Jenkins Pipeline**

1. **In Jenkins Dashboard:**
   - New Item → Pipeline
   - Name: `study-buddy-ai`
   - Pipeline from SCM → Git
   - Repository URL: Your GitHub repo
   - Credentials: Select `github-token`
   - Branch: `main`

2. **Build the Pipeline:**
   - Click "Build Now"
   - Monitor the build process

### **Step 11: Set Up ArgoCD Application**

1. **Access ArgoCD UI**: `http://YOUR_VM_IP:31704`
2. **Login**: admin / (password from step 8)
3. **Create Application:**
   - Name: `study-buddy-ai`
   - Repository URL: Your GitHub repo
   - Path: `manifests`
   - Sync Policy: Automatic

### **Step 12: Create Kubernetes Secret**

```bash
# Create secret for Groq API key
kubectl create secret generic groq-api-secret \
  --from-literal=GROQ_API_KEY="your_groq_api_key" \
  -n argocd
```

## 🎯 **What You'll Have:**

✅ **Full CI/CD Pipeline**  
✅ **Docker Containerization**  
✅ **Kubernetes Deployment**  
✅ **GitOps with ArgoCD**  
✅ **Automated Testing & Deployment**  
✅ **Professional DevOps Setup**  

## 📝 **For Resume:**

**Project**: Study Buddy AI - Full CI/CD Pipeline  
**Technologies**: Python, Streamlit, Docker, Kubernetes, Jenkins, ArgoCD, GitOps  
**Infrastructure**: Google Cloud Platform, Minikube  
**Deployment**: Automated CI/CD with GitOps  

---

**This is the exact same setup as the original project! 🚀** 