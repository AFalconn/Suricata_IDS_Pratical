#!/bin/bash
set -e

CONFIG="/etc/suricata/suricata.yaml"

echo "=== Testing Suricata Configuration ==="
sudo suricata -T -c "$CONFIG"

echo
echo "=== Searching for Custom SID ==="
sudo suricata -T -c "$CONFIG" 2>&1 | grep -E "1000001|SURICATA ICMP TEST ALERT" || true
