#!/bin/sh

# Create the tor group if it doesn't exist
if ! getent group tor >/dev/null 2>&1; then
  addgroup -S tor
fi

# Create the tor user if it doesn't exist
if ! id -u tor >/dev/null 2>&1; then
  adduser -S -H -h /dev/null -G tor -g tor tor
fi

# Check if the hidden_folder volume is mounted
if [ -d "hidden_service" ]; then
  echo "Custom hidden_service found. Copying to $HIDDEN_SERVICE_PATH."
  # Copy the custom hidden_folder to Tor's hidden service directory
  cp -a hidden_service/. "$HIDDEN_SERVICE_PATH"
else
  echo "No custom hidden_service found. Using default hidden_service directory."
fi

chown -R tor:tor "$HIDDEN_SERVICE_PATH"
chmod -R 700 "$HIDDEN_SERVICE_PATH"

echo "The Onion URL is $(cat "$HIDDEN_SERVICE_PATH/hostname")"

# Start Tor as the tor user
su -s /bin/sh -c "tor -f /etc/tor/torrc" tor &

# Start your application with Gunicorn as the tor user
su -s /bin/sh -c "gunicorn --worker-class eventlet -w 1 --bind 0.0.0.0:80 app:app" tor