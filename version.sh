#!/bin/bash

# Get kernel version
KERNEL_VERSION=$(uname -r | cut -d '-' -f 1)

# Output the required JSON format continuously
echo '{"version":1}'
echo '['
echo '[],'

while :; do
    echo '[{"full_text":" Kernel: '"$KERNEL_VERSION"' | Debian GNU/Linux"}],'
    sleep 1
done

