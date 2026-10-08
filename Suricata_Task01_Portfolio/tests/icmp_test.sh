#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <AUTHORIZED-LAB-IP>"
    exit 1
fi

TARGET="$1"

echo "Testing ICMP detection against authorized lab host: $TARGET"
ping -c 4 "$TARGET"

echo
echo "ICMP test completed."
echo "Check /var/log/suricata/fast.log for SID 1000001."
