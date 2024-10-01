#!/bin/bash

NOTIFICATION_ID=5555

if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
else
    pactl set-sink-mute @DEFAULT_SINK@ toggle
fi

