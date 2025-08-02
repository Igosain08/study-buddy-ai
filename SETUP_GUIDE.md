# 🎓 Study Buddy AI - Setup Guide

## 🚀 Quick Start

### 1. Get Groq API Key
1. Go to [Groq Console](https://console.groq.com/)
2. Sign up for a free account
3. Create an API key
4. Copy the API key

### 2. Configure API Key
Edit the `.env` file and replace `your_groq_api_key_here` with your actual API key:

```bash
GROQ_API_KEY=your_actual_groq_api_key_here
```

### 3. Run the Application
```bash
streamlit run application.py
```

### 4. Access the App
Open your browser and go to the URL shown in the terminal (usually `http://localhost:8501`)

## 📋 What This App Does

**Study Buddy AI** is an intelligent quiz generator that:

- 🧠 Uses Groq AI to generate educational questions
- 📝 Creates multiple-choice and fill-in-the-blank questions
- 🎯 Adjusts difficulty levels (Easy, Medium, Hard)
- 📊 Provides instant scoring and feedback
- 💾 Saves quiz results as CSV files
- 🎨 Has a beautiful Streamlit web interface

## 🔧 Features

### Quiz Types
- **Multiple Choice Questions**: 4 options with 1 correct answer
- **Fill in the Blank**: Complete the sentence with the correct word

### Customization Options
- **Topic**: Any subject (History, Science, Math, etc.)
- **Difficulty**: Easy, Medium, Hard
- **Question Count**: 1-10 questions per quiz

### Results & Analytics
- ✅/❌ Visual feedback for each answer
- 📈 Score percentage calculation
- 📄 Download results as CSV
- 📊 Detailed answer explanations

## 🛠️ Technical Details

### Dependencies
- `streamlit` - Web interface
- `langchain` - AI framework
- `langchain-groq` - Groq AI integration
- `pandas` - Data handling
- `python-dotenv` - Environment variables

### File Structure
```
CODE/
├── application.py          # Main Streamlit app
├── requirements.txt        # Python dependencies
├── .env                   # API key configuration
├── src/
│   ├── generator/         # Question generation logic
│   ├── llm/              # AI client setup
│   ├── models/           # Data schemas
│   ├── prompts/          # AI prompt templates
│   ├── utils/            # Helper functions
│   └── config/           # Settings and configuration
└── manifests/            # Kubernetes deployment files
```

## 🚨 Troubleshooting

### Common Issues

1. **"GROQ_API_KEY not configured"**
   - Make sure you've updated the `.env` file with your actual API key
   - Restart the application after updating

2. **Import errors**
   - Run: `pip install -r requirements.txt`
   - Make sure you're in the `CODE` directory

3. **Groq API errors**
   - Check your internet connection
   - Verify your API key is correct
   - Check Groq service status

4. **Streamlit not starting**
   - Make sure port 8501 is available
   - Try: `streamlit run application.py --server.port 8502`

## 🎯 Usage Tips

1. **Start Simple**: Try "Easy" difficulty with 3-5 questions
2. **Be Specific**: Use detailed topics like "World War II" instead of "History"
3. **Save Results**: Download your quiz results for later review
4. **Experiment**: Try different question types and topics

## 🔒 Security Notes

- Never commit your `.env` file to version control
- Keep your Groq API key private
- The app runs locally on your machine

## 📞 Support

If you encounter issues:
1. Check the troubleshooting section above
2. Verify your Groq API key is working
3. Ensure all dependencies are installed correctly

---

**Happy Learning! 🎓✨** 