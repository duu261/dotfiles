#!/bin/bash
# Kill waybar process, ensure we're terminating it gracefully
killall waybar

# Wait for the process to die completely
sleep 1

# Start waybar and log any issues
waybar || echo "Error starting Waybar"

