#!/bin/sh

# Start Tor
tor -f /etc/tor/torrc &

# Check if HIDDEN_SERVICE_PATH environment variable is set
if [ -d "$HIDDEN_SERVICE_PATH" ]; then
  echo "Custom hidden_service directory found. Using $HIDDEN_SERVICE_PATH."
  # Copy the custom hidden_service directory to Tor's default location
  cp -R "$HIDDEN_SERVICE_PATH"/* /var/lib/tor/hidden_service/
else
  echo "Using default hidden_service directory."
fi

# Start your application
python app.py
