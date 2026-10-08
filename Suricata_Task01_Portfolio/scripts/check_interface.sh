#!/bin/bash
set -e

echo "=== IP Addresses ==="
ip addr

echo
echo "=== Routing Table ==="
ip route

echo
echo "Identify the interface carrying your lab traffic."
