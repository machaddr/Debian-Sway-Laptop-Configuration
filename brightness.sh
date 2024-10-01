#!/bin/bash

# Adjust brightness
if [ "$1" == "up" ]; then
    light -A 5
elif [ "$1" == "down" ]; then
    light -U 5
else
    echo "Usage: brightness.sh [up|down]"
    exit 1
fi

# Get current brightness level
brightness=$(light -G)

# Display notification
notify-send "Brightness" "$brightness"
