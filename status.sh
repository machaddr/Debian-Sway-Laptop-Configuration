#!/bin/bash

# Get CPU usage.
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
"$cpu_usage"

# Get CPU frequency.
cpu_freq=$(grep -E 'cpu MHz' /proc/cpuinfo | awk '{print $4}' | head -n 1 | awk '{printf "%.1f GHz", $1 / 1000}')
"$cpu_freq"

# Get CPU temperature.
cpu_temp=$(sensors | grep 'Package' | awk '{print $4}')
"$cpu_temp"

# Get the current Ethernet network interface
wireless_interface=$(ip link show | awk -F: '$1 == 2 {print $2}' | tr -d ' ')

# Get the download and upload speeds
Network=$(ifstat -i $wireless_interface 1 1 | awk 'NR==3 {print "Down: " $1 " KB/s Up: "$2 " KB/s"}')

# Get the current wireless network
wireless_network=$(/usr/sbin/iwgetid -r)
"$wireless_network"

# Get the current IP address
ip_address=$(hostname -I | awk '{print $1}')
"$ip_address"


# Get disk storage filled.
disk_usage=$(df -h / | awk 'NR==2{print $3 "/" $2}')
"$disk_usage"

# Get memory usage and total memory
memory_info=$(free -m | awk 'NR==2{print $3 "MB / " $2 "MB"}')
"$memory_info"

# Get Volume Pulseaudio
#volume=$(pactl list sinks | grep 'Volume:' | head -n 1 | awk '{print $5}')
#"$volume"

# Get Volume Pulseaudio
volume_info=$(pactl list sinks | grep 'Mute: ' | head -n 1 | awk '{print $2}')
volume_status=$(pactl list sinks | grep 'Volume: ' | head -n 1 | awk '{print $5}')
volume=$(echo "$volume_status" | sed 's/.$//')

# Determine volume display based on mute status
if [[ "$volume_info" == "yes" ]]; then
    volume_display="--%"
else
    volume_display="$volume%"
fi

# Returns the battery status.
battery_status=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage" | awk '{print $2}')
"$battery_status"

# Get Hour and Time
date_formatted=$(date +"%H:%M")
"$date_formatted"

# Output the formatted status
echo " 🖥️ CPU: $cpu_usage% ($cpu_freq) | 🌡️ CPU Temp: $cpu_temp  | 📡 Network: $wireless_network >> $Network >> IP: $ip_address | 💽 Disk: $disk_usage | 🖥️ RAM: $memory_info | 🔊 Vol: $volume_display | 🔋 BAT: $battery_status | $date_formatted"
