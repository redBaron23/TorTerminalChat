from flask import Flask, render_template, request
from flask_socketio import SocketIO, emit
import random

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key'
socketio = SocketIO(app)

messages = []

# List of random names
names = ['Onion', 'Garlic', 'Leek', 'Chive', 'Shallot', 'Scallion', 'Pepper', 'Ginger', 'Turmeric', 'Saffron']

@app.route('/')
def index():
    name = random.choice(names) + str(random.randint(1, 100))
    return render_template('index.html', messages=messages, name=name)

@socketio.on('new_message')
def handle_new_message(message):
    name = request.remote_addr  # Use user's IP address as name
    messages.append({'name': name, 'message': message})
    emit('new_message', {'name': name, 'message': message}, broadcast=True)

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=80)