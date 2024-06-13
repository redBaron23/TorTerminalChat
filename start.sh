#!/bin/sh

# Start Tor
tor -f /etc/tor/torrc &

# Check if the hidden_folder volume is mounted
if [ -d "hidden_service" ]; then
  echo "Custom hidden_service found. Copying to $HIDDEN_SERVICE_PATH."
  # Copy the custom hidden_folder to Tor's hidden service directory
  cp -a hidden_service/. "$HIDDEN_SERVICE_PATH"
  chmod -R 700 "$HIDDEN_SERVICE_PATH"
  chown -R root:root "$HIDDEN_SERVICE_PATH"
else
  echo "No custom hidden_service found. Using default hidden_service directory."
fi

echo "The Onion URL is $(cat "$HIDDEN_SERVICE_PATH/hostname")"

# Start your application
python app.py
