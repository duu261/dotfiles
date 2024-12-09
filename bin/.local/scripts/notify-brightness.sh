#!/bin/bash

# Adjust brightness and show notification
if [[ $1 == "+" ]]; then
    brightnessctl set +5% -q
elif [[ $1 == "-" ]]; then
    brightnessctl set 5%- -q
fi

# Get current brightness
current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((current * 100 / max))

# Show notification with timeout
notify-send -u low -h int:value:$percent -h string:synchronous:brightness -t 2000 "Brightness: ${percent}%"

