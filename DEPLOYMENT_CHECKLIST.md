# ✅ Study Buddy AI - Deployment Checklist

## 🎯 **Current Status:**
- ✅ Configuration updated with your information
- ✅ Code committed to Git
- ✅ GitHub remote added
- ✅ Branch renamed to main

## 📋 **Next Steps Checklist:**

### **Step 1: Create GitHub Repository**
- [ ] Go to https://github.com/new
- [ ] Repository name: `study-buddy-ai`
- [ ] Make it Public
- [ ] Don't initialize with README
- [ ] Create repository

### **Step 2: Create DockerHub Repository**
- [ ] Go to https://hub.docker.com/repositories
- [ ] Click "Create Repository"
- [ ] Repository name: `study-buddy-ai`
- [ ] Make it Public
- [ ] Create repository

### **Step 3: Push Code to GitHub**
```bash
git push -u origin main
```

### **Step 4: Set Up Google Cloud Platform**
- [ ] Create GCP account: https://console.cloud.google.com/
- [ ] Create new project
- [ ] Enable billing (free tier)
- [ ] Create VM instance:
  - Name: `gitops`
  - Machine Type: E2 Standard (16 GB RAM)
  - Boot Disk: 256 GB Ubuntu 24.04 LTS
  - Networking: Enable HTTP and HTTPS traffic

### **Step 5: Connect to VM and Install Dependencies**
```bash
# Connect to VM via SSH
gcloud compute ssh gitops

# On VM, run these commands:
sudo apt update && sudo apt upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo snap install kubectl --classic
minikube start --driver=docker
```

### **Step 6: Set Up Jenkins**
```bash
# On VM, run:
docker run -d --name jenkins \
-p 8080:8080 \
-p 50000:50000 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
-u root \
-e DOCKER_GID=$(getent group docker | cut -d: -f3) \
--network minikube \
jenkins/jenkins:lts

# Get admin password:
docker logs jenkins
```

### **Step 7: Configure Jenkins**
- [ ] Access Jenkins: `http://YOUR_VM_IP:8080`
- [ ] Install suggested plugins
- [ ] Create admin user
- [ ] Install additional plugins: Docker, Docker Pipeline, Kubernetes

### **Step 8: Set Up Credentials**
- [ ] Generate GitHub token with permissions: `repo`, `admin:org`, `workflow`
- [ ] Add GitHub credentials in Jenkins (ID: `github-token`)
- [ ] Generate DockerHub access token
- [ ] Add DockerHub credentials in Jenkins (ID: `dockerhub-token`)

### **Step 9: Set Up ArgoCD**
```bash
# On VM, run:
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl edit svc argocd-server -n argocd
# Change: type: ClusterIP to type: NodePort
```

### **Step 10: Create Jenkins Pipeline**
- [ ] In Jenkins: New Item → Pipeline
- [ ] Name: `study-buddy-ai`
- [ ] Pipeline from SCM → Git
- [ ] Repository URL: `https://github.com/Igosain08/study-buddy-ai.git`
- [ ] Credentials: Select `github-token`
- [ ] Branch: `main`

### **Step 11: Set Up ArgoCD Application**
- [ ] Access ArgoCD UI: `http://YOUR_VM_IP:31704`
- [ ] Login with admin password
- [ ] Create application:
  - Name: `study-buddy-ai`
  - Repository URL: `https://github.com/Igosain08/study-buddy-ai.git`
  - Path: `manifests`
  - Sync Policy: Automatic

### **Step 12: Create Kubernetes Secret**
```bash
# On VM, run:
kubectl create secret generic groq-api-secret \
  --from-literal=GROQ_API_KEY="your_groq_api_key" \
  -n argocd
```

## 🎉 **Final Result:**
- ✅ Full CI/CD Pipeline with Jenkins
- ✅ Docker Containerization
- ✅ Kubernetes Deployment
- ✅ GitOps with ArgoCD
- ✅ Professional DevOps Setup

## 📝 **For Resume:**
- **Project**: Study Buddy AI - Full CI/CD Pipeline
- **Technologies**: Python, Streamlit, Docker, Kubernetes, Jenkins, ArgoCD, GitOps
- **Infrastructure**: Google Cloud Platform, Minikube
- **GitHub**: https://github.com/Igosain08/study-buddy-ai
- **Live Demo**: Your deployed app URL

---

**Ready to start? Begin with Step 1! 🚀** 