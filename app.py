from flask import Flask, render_template, request
from flask_socketio import SocketIO, emit

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your-secret-key'
socketio = SocketIO(app)

messages = []

@app.route('/')
def index():
    return render_template('index.html', messages=messages)

@socketio.on('new_message')
def handle_new_message(message):
    name = request.remote_addr  # Use user's IP address as name
    messages.append({'name': name, 'message': message})
    emit('new_message', {'name': name, 'message': message}, broadcast=True)

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=80, allow_unsafe_werkzeug=True)