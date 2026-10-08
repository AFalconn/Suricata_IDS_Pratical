# Detection Tests

## Test 01 — ICMP Detection

Objective:

> Confirm that Suricata detects authorized ICMP traffic using SID `1000001`.

Test command:

```bash
./tests/icmp_test.sh <AUTHORIZED-LAB-IP>
```

Expected workflow:

```text
ICMP request
     ↓
Suricata packet capture
     ↓
Custom rule SID 1000001
     ↓
Alert
     ↓
fast.log / eve.json
```

Only test systems that you own or have explicit authorization to monitor.
