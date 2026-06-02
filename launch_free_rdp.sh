#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

while true; do
    echo "Starting xfreerdp..."
    xfreerdp /v:${RDP_HOST} /u:${RDP_USER} /bpp:${RDP_BPP} /network:${RDP_NETWORK}
    EXIT=$?
    echo "xfreerdp exited with code $EXIT, reconnecting in 3 seconds..."
    sleep 3
done
