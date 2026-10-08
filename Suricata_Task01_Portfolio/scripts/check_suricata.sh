#!/bin/bash
set -e

echo "=== Suricata Version ==="
suricata -V

echo
echo "=== Suricata Binary ==="
command -v suricata

echo
echo "Suricata installation check completed."
