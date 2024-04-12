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
    user_info = request.json.get('user_info', {})  # Extract user information

    message_text.append({"role": "user", "content": user_input})

    # Generate response considering user information
    ai_response = generate_response(user_input, user_info, message_text)

    # Add the AI's response to the conversation
    message_text.append({"role": "assistant", "content": ai_response})

    return jsonify({'ai_response': ai_response})

def generate_response(user_input, user_info, message_text):
    # Append user information to the conversation history
    if user_info:
        user_info_message = {"role": "system", "content": f"User Info: {user_info}"}
        message_text.append(user_info_message)

    # Pass the updated conversation history to OpenAI for response generation
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

    # Extract the AI's response from the completion
    ai_response = completion.choices[0].message['content']

    return ai_response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
