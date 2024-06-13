#!/bin/bash

# Check if the version is provided as a command-line argument
if [ -z "$1" ]; then
  echo "Please provide the version as a command-line argument."
  exit 1
fi

# Set the version variable
VERSION=$1

# Build and push the Docker image with the specified version
docker buildx build -f Dockerfile.tor --platform linux/arm/v7,linux/amd64 -t redbaron23/terminalchat-tor:$VERSION -t redbaron23/terminalchat-tor:latest --push .