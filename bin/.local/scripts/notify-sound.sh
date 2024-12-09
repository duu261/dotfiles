#!/bin/bash

action=$1

# Volume Control
if [[ $action == "volume-up" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
elif [[ $action == "volume-down" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ -5%
elif [[ $action == "volume-mute" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
fi

# Microphone Control
if [[ $action == "mic-mute" ]]; then
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
fi

# Get current states
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP '(yes|no)')
mic_mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -oP '(yes|no)')

# Send notifications with a shorter timeout
if [[ $action == "volume-up" || $action == "volume-down" || $action == "volume-mute" ]]; then
    if [[ $mute == "yes" ]]; then
        notify-send -u low -h string:synchronous:volume -t 2000 "Volume: Muted" # Timeout: 1 second
    else
        notify-send -u low -h int:value:${volume%\%} -h string:synchronous:volume -t 2000 "Volume: $volume" # Timeout: 1 second
    fi
elif [[ $action == "mic-mute" ]]; then
    if [[ $mic_mute == "yes" ]]; then
        notify-send -u low -h string:synchronous:mic -t 2000 "Microphone: Muted" # Timeout: 1 second
    else
        notify-send -u low -h string:synchronous:mic -t 2000 "Microphone: Unmuted" # Timeout: 1 second
    fi
fi

