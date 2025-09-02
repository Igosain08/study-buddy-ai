# 🎓 Study Buddy AI

An intelligent quiz generator powered by Groq AI that creates educational questions on any topic. Perfect for learning, interviews, and portfolio demonstrations!

## 🚀 Quick Start

### Local Development
1. **Get Groq API Key**
   - Visit [Groq Console](https://console.groq.com/)
   - Sign up and create an API key

2. **Configure API Key**
   ```bash
   # Edit .env file and add your API key
   GROQ_API_KEY=your_actual_api_key_here
   ```

3. **Run the App**
   ```bash
   streamlit run application.py
   ```

4. **Open Browser**
   - Go to `http://localhost:8501`
   - Start creating quizzes!

### 🐳 Kubernetes Deployment (Minikube)
For portfolio demonstrations and interview showcases:

```bash
# Quick deployment with Minikube
./deploy-minikube.sh YOUR_GROQ_API_KEY
```

See [MINIKUBE_DEPLOYMENT.md](MINIKUBE_DEPLOYMENT.md) for detailed instructions.

## ✨ Features

- 🧠 **AI-Powered Questions**: Generate intelligent quizzes on any topic
- 📝 **Multiple Formats**: Multiple choice and fill-in-the-blank questions
- 🎯 **Difficulty Levels**: Easy, Medium, Hard
- 📊 **Instant Scoring**: Real-time feedback and results
- 💾 **Export Results**: Save quiz results as CSV files
- 🎨 **Beautiful UI**: Clean, responsive Streamlit interface
- 🐳 **Containerized**: Docker and Kubernetes ready
- 🔒 **Secure**: Environment-based configuration

## 🎯 How to Use

1. **Enter a Topic**: Be specific (e.g., "Python Functions", "World War II")
2. **Choose Question Type**: Multiple Choice or Fill in the Blank
3. **Set Difficulty**: Easy, Medium, or Hard
4. **Select Number of Questions**: 1-10 questions
5. **Generate Quiz**: Click the button and wait for AI to create questions
6. **Take the Quiz**: Answer all questions
7. **Submit & Review**: Get your score and see correct answers
8. **Download Results**: Save your quiz results as CSV

## 🔧 Requirements

- Python 3.8+
- Groq API key (free)
- Internet connection
- Docker (for containerized deployment)
- Minikube (for Kubernetes deployment)

## 📦 Installation

```bash
# Install Python dependencies
pip install -r requirements.txt

# For containerized deployment
docker build -t study-buddy-ai:latest .
```

## 🐳 Deployment Options

### Local Development
```bash
streamlit run application.py
```

### Docker
```bash
docker build -t study-buddy-ai:latest .
docker run -p 8501:8501 -e GROQ_API_KEY=your_key study-buddy-ai:latest
```

### Kubernetes (Minikube)
```bash
./deploy-minikube.sh YOUR_GROQ_API_KEY
```

## 🎓 Example Topics

- **Programming**: Python, JavaScript, Data Structures
- **History**: World War II, Ancient Rome, American Revolution
- **Science**: Chemistry, Physics, Biology
- **Math**: Algebra, Calculus, Statistics
- **Literature**: Shakespeare, Poetry, Novels
- **Geography**: Countries, Capitals, Landmarks

## 📚 Documentation

- [Setup Guide](SETUP_GUIDE.md) - Detailed setup instructions
- [Minikube Deployment](MINIKUBE_DEPLOYMENT.md) - Kubernetes deployment guide
- [Configuration Guide](CONFIGURATION_GUIDE.md) - Configuration options
- [Deployment Guide](DEPLOYMENT_GUIDE.md) - Production deployment

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

---

**Happy Learning! 🎓✨**
