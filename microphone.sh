#!/bin/bash

NOTIFICATION_ID=5556

if pactl list sources | grep -q "Mute: yes"; then
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
else
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
fi
