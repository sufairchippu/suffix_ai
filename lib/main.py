from fastapi import FastAPI, Body
from pydantic import BaseModel
import google.generativeai as genai

app = FastAPI(title="Gemini Chatbot API")

# Configure your API key
genai.configure(api_key="AIzaSyCPBiHUeCpZQT1qplZRRWaGMXILBc8kJ4s")

class ChatRequest(BaseModel):
    message: str
    history: list = []

@app.post("/chat")
def chat(req: ChatRequest):
    # Create a model instance
    model = genai.GenerativeModel('gemini-pro')

    # Prepare chat history
    messages = [{"role": "user", "parts": [req.message]}]
    for h in req.history:
        messages.append({"role": h['role'], "parts": [h['content']]})

    # Generate response
    response = model.generate_content(messages)
    return {"response": response.text}
    