#!/bin/sh

# Start the Tor service
tor -f /etc/tor/torrc &

# Wait for Tor to start (adjust as needed)
sleep 10

# Start the Python application
python app.py
