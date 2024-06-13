from flask import Flask, render_template, request
from flask_socketio import SocketIO, emit
import random

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key'
socketio = SocketIO(app)

messages = []

# Expanded list of random names
names = [
    'Onion', 'Garlic', 'Leek', 'Chive', 'Shallot', 'Scallion', 'Pepper', 'Ginger', 'Turmeric', 'Saffron',
    'Basil', 'Cilantro', 'Dill', 'Parsley', 'Rosemary', 'Thyme', 'Oregano', 'Tarragon', 'Mint', 'Sage',
    'Paprika', 'Cardamom', 'Clove', 'Nutmeg', 'Cinnamon', 'Vanilla', 'BayLeaf', 'Cumin', 'Fennel', 'Anise',
    'Fenugreek', 'Marjoram', 'Chervil', 'Lovage', 'Savory', 'Sorrel', 'Tamarind', 'Caraway', 'Celery', 'Mustard'
]

@app.route('/')
def index():
    name = random.choice(names) + str(random.randint(1, 100))
    return render_template('index.html', messages=messages, name=name)

@socketio.on('new_message')
def handle_new_message(data):
    name = data['name']  # Use the username from the client
    message = data['message']
    messages.append({'name': name, 'message': message})
    emit('new_message', {'name': name, 'message': message}, broadcast=True)

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=80)
