#!/bin/bash

# Define the servers
servers=("gateway" "registry" "bap" "bpp")

# Path to your public key
pubkey=""

# Check if public key exists
if [ ! -f "$pubkey" ]; then
  echo "Public key not found at $pubkey"
  exit 1
fi

# Copy key to each server
for server in "${servers[@]}"; do
  echo "Copying key to $server..."
  ssh "$server" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '' >> ~/.ssh/authorized_keys && cat >> ~/.ssh/authorized_keys" < "$pubkey"
  if [ $? -eq 0 ]; then
    echo "Key copied successfully to $server."
  else
    echo "Failed to copy key to $server."
  fi
done
