#!/bin/bash

echo "🚀 Study Buddy AI - Deployment Script"
echo "======================================"

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ Error: .env file not found!"
    echo "Please create .env file with your GROQ_API_KEY"
    exit 1
fi

# Check if GROQ_API_KEY is set
if ! grep -q "GROQ_API_KEY=" .env; then
    echo "❌ Error: GROQ_API_KEY not found in .env file!"
    echo "Please add: GROQ_API_KEY=your_actual_api_key"
    exit 1
fi

echo "✅ Environment check passed!"

echo ""
echo "📋 Next Steps:"
echo "1. Create GitHub repository: https://github.com/new"
echo "2. Create DockerHub repository: https://hub.docker.com/repositories"
echo "3. Choose deployment platform:"
echo "   - Railway (recommended): https://railway.app"
echo "   - Render: https://render.com"
echo "   - Heroku: https://heroku.com"
echo ""
echo "4. Update these files with your info:"
echo "   - Jenkinsfile (if using Jenkins)"
echo "   - manifests/deployment.yaml"
echo ""
echo "5. Push to GitHub:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/study-buddy-ai.git"
echo "   git push -u origin main"
echo ""
echo "🎯 For Resume:"
echo "- Project: Study Buddy AI"
echo "- Tech: Python, Streamlit, Groq AI, Docker"
echo "- GitHub: Your repo URL"
echo "- Live Demo: Your deployed app URL"
echo ""
echo "📖 See DEPLOYMENT_GUIDE.md for detailed instructions!" 