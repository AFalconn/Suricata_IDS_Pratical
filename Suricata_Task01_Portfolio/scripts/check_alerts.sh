#!/bin/bash

echo "=== Recent Fast Alerts ==="
sudo tail -n 20 /var/log/suricata/fast.log

echo
echo "=== Recent EVE Events ==="
sudo tail -n 10 /var/log/suricata/eve.json
