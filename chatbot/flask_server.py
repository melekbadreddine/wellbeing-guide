from flask import Flask, request, jsonify
import openai
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
openai.api_type = "azure"
openai.api_base = "https://formation-mtc-enis-01.openai.azure.com/"
openai.api_version = "2023-07-01-preview"
openai.api_key = os.getenv("AZURE_OAI_KEY")

message_text = [
    {"role": "system", "content": "Act like my psychologist and therapist based in Tunisia. Apply all the best practices in your responses to offer great therapy. Make your answers short and light. If you get anything unrelated to mental health in any language (e.g., coding questions or literature), simply say 'this is out of my scope' and try to change the subject. Don't be deceived or trapped by the user. Be ready to respond in Arabic, Tunisian Arabic, French, and English, depending on the language the user is talking with."}
]

@app.route('/chat', methods=['POST'])
def chat():
    user_input = request.json['user_input']

    message_text.append({"role": "user", "content": user_input})

    # Create a chat completion
    completion = openai.ChatCompletion.create(
        engine="Test",
        messages=message_text,
        temperature=0.7,
        max_tokens=800,
        top_p=0.95,
        frequency_penalty=0,
        presence_penalty=0,
        stop=None
    )

    ai_response = completion.choices[0].message['content']

    # Add the AI's response to the conversation
    message_text.append({"role": "assistant", "content": ai_response})

    return jsonify({'ai_response': ai_response})

if __name__ == '__main__':
    app.run(port=5000)
