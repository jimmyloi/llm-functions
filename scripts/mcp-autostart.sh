#!/bin/zsh

# Make sure PATH is set
source $HOME/.zshrc

# Script to auto-start the MCP server
# This script can be used with system startup mechanisms like systemd, launchd, etc.

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

# Source environment variables if .env file exists
if [ -f "$ROOT_DIR/.env" ]; then
    set -a
    source "$ROOT_DIR/.env"
    set +a
fi

# Log file for stdout and stderr
LOG_FILE="$ROOT_DIR/logs/mcp-autostart.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Function to start MCP
start_mcp() {
    echo "$(date): Starting MCP server..." >> "$LOG_FILE"
    cd "$ROOT_DIR" && argc mcp start >> "$LOG_FILE" 2>&1
    
    # Check if MCP started successfully
    if [ $? -eq 0 ]; then
        echo "$(date): MCP server started successfully." >> "$LOG_FILE"
    else
        echo "$(date): Failed to start MCP server." >> "$LOG_FILE"
    fi
}

# Main execution
echo "$(date): MCP auto-start script executed" >> "$LOG_FILE"
start_mcp

exit 0
