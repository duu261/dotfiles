#!/bin/bash

# Get the CPU utilization percentage
CPU_UTIL=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Determine the icon based on CPU utilization
case $CPU_UTIL in
  [0-9]) ICON="󰝦" ;;        # 0-9%
  [1-2][0-9]) ICON="󰪞" ;;   # 10-29%
  [3-4][0-9]) ICON="󰪟" ;;   # 30-49%
  [5-6][0-9]) ICON="󰪣" ;;   # 50-69%
  [7-8][0-9]) ICON="󰪤" ;;   # 70-89%
  9[0-4]) ICON="󰪥" ;;      # 90-94%
  9[5-9]|100) ICON="󰪢" ;;  # 95-100%
  *) ICON="󰪠" ;;            # Default
esac

# Output JSON for Waybar
echo "{\"text\": \"$ICON\", \"tooltip\": \"CPU Utilization: $CPU_UTIL%\"}"

