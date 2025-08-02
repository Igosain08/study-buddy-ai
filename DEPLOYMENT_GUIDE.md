# 🚀 Study Buddy AI - Deployment Guide for Resume

## 📋 **What You Need to Set Up:**

### **1. GitHub Repository**
- Create a new repository on GitHub
- Push your code to GitHub

### **2. DockerHub Account**
- Create a DockerHub account
- Create a repository for your app

### **3. Cloud Platform (Choose One)**
- **Heroku** (Easiest)
- **Railway** (Free tier)
- **Render** (Free tier)
- **Google Cloud Platform** (Free tier)

## 🎯 **Step-by-Step Deployment**

### **Step 1: GitHub Setup**

1. **Create GitHub Repository:**
   - Go to [GitHub](https://github.com)
   - Click "New Repository"
   - Name: `study-buddy-ai`
   - Make it Public
   - Don't initialize with README

2. **Push Your Code:**
   ```bash
   git add .
   git commit -m "Initial commit: Study Buddy AI"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/study-buddy-ai.git
   git push -u origin main
   ```

### **Step 2: DockerHub Setup**

1. **Create DockerHub Account:**
   - Go to [DockerHub](https://hub.docker.com)
   - Sign up for free account

2. **Create Repository:**
   - Click "Create Repository"
   - Name: `study-buddy-ai`
   - Make it Public

3. **Update Dockerfile:**
   ```bash
   # Update the image name in manifests/deployment.yaml
   # Change: your-dockerhub-username/studybuddy
   # To: YOUR_DOCKERHUB_USERNAME/study-buddy-ai
   ```

### **Step 3: Update Configuration Files**

#### **Update Jenkinsfile:**
```groovy
// Change these lines:
DOCKER_HUB_REPO = "YOUR_DOCKERHUB_USERNAME/study-buddy-ai"
url: 'https://github.com/YOUR_USERNAME/study-buddy-ai.git'
git config user.name "YOUR_GITHUB_USERNAME"
git config user.email "your-email@example.com"
```

#### **Update manifests/deployment.yaml:**
```yaml
# Change this line:
image: YOUR_DOCKERHUB_USERNAME/study-buddy-ai:v1
```

### **Step 4: Choose Deployment Platform**

#### **Option A: Heroku (Recommended for Resume)**
1. **Install Heroku CLI:**
   ```bash
   brew install heroku/brew/heroku
   ```

2. **Create Heroku App:**
   ```bash
   heroku create your-study-buddy-ai
   ```

3. **Add Buildpacks:**
   ```bash
   heroku buildpacks:add heroku/python
   ```

4. **Set Environment Variables:**
   ```bash
   heroku config:set GROQ_API_KEY=your_groq_api_key
   ```

5. **Deploy:**
   ```bash
   git push heroku main
   ```

#### **Option B: Railway (Free & Easy)**
1. **Go to [Railway](https://railway.app)**
2. **Connect GitHub repository**
3. **Add environment variable:**
   - `GROQ_API_KEY` = your Groq API key
4. **Deploy automatically**

#### **Option C: Render (Free & Easy)**
1. **Go to [Render](https://render.com)**
2. **Create new Web Service**
3. **Connect GitHub repository**
4. **Add environment variable:**
   - `GROQ_API_KEY` = your Groq API key
5. **Deploy automatically**

## 📝 **For Your Resume:**

### **Project Description:**
```
Study Buddy AI - Intelligent Quiz Generator
• Built an AI-powered quiz application using Python, Streamlit, and Groq AI
• Implemented multiple question types (MCQ, Fill-in-blank) with difficulty levels
• Deployed using Docker containerization and CI/CD pipeline
• Technologies: Python, Streamlit, Groq AI, Docker, Git, GitHub Actions
```

### **GitHub Repository:**
```
https://github.com/YOUR_USERNAME/study-buddy-ai
```

### **Live Demo:**
```
https://your-app-name.herokuapp.com
```

## 🔧 **Advanced: Full CI/CD Pipeline**

If you want the complete Jenkins + Kubernetes setup:

1. **Set up Google Cloud Platform**
2. **Install Jenkins**
3. **Configure ArgoCD**
4. **Update all placeholder values in Jenkinsfile**

## 🎯 **Quick Resume-Ready Setup:**

### **Easiest Path (Recommended):**
1. **GitHub** → Push your code
2. **Railway/Render** → Connect GitHub repo
3. **Add environment variable** → Your Groq API key
4. **Deploy** → Get live URL

### **What to Put on Resume:**
- **Project Name**: Study Buddy AI
- **Description**: AI-powered quiz generator with intelligent question generation
- **Tech Stack**: Python, Streamlit, Groq AI, Docker
- **GitHub**: Your repo URL
- **Live Demo**: Your deployed app URL

## 🚀 **Ready to Deploy?**

Choose your deployment platform and I'll help you configure it step by step!

---

**This will make a great addition to your resume! 🎓✨** 