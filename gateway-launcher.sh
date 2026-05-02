#!/bin/bash
# gateway-launcher.sh - Launch OpenClaw Gateway with nvm node
# Ensures correct node version is used regardless of nvm upgrades
#
# Usage: gateway-launcher.sh [--port PORT]
# Default port: 18789

set -euo pipefail

# Configuration
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
GATEWAY_PORT="${1:-18789}"
OPENCLAW_PATH="/opt/homebrew/lib/node_modules/openclaw/dist/index.js"

# Load nvm
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
else
    echo "ERROR: nvm not found at $NVM_DIR" >&2
    exit 1
fi

# Use nvm to get the default node version (no hardcoded version)
NODE_PATH="$(nvm which default)"
if [ -z "$NODE_PATH" ] || [ ! -x "$NODE_PATH" ]; then
    echo "ERROR: Could not find default node via nvm" >&2
    exit 1
fi

# Verify node is available
if ! "$NODE_PATH" --version >/dev/null 2>&1; then
    echo "ERROR: Node at $NODE_PATH is not executable" >&2
    exit 1
fi

# Log startup
echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] Launching OpenClaw Gateway with node $("$NODE_PATH" --version)"

# Execute gateway
exec "$NODE_PATH" "$OPENCLAW_PATH" gateway --port "$GATEWAY_PORT"
