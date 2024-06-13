#!/bin/sh

# Start Tor
tor -f /etc/tor/torrc &

# Check if the hidden_service volume is mounted
if [ -d "/hidden_service_volume" ]; then
  echo "Custom hidden_service found. Copying to $HIDDEN_SERVICE_PATH."
  # Copy the custom hidden_service to Tor's hidden service directory
  cp -a /hidden_service_volume/. "$HIDDEN_SERVICE_PATH"
else
  echo "No custom hidden_service found. Using default hidden_service directory."
fi

# Start your application
python app.py