# Results

## Expected Result

The Suricata configuration should validate successfully.

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml
```

The custom rule should load with:

```text
SID: 1000001
```

After authorized ICMP traffic is generated, the expected detection is:

```text
SURICATA ICMP TEST ALERT
```

## Result Evidence

Add screenshots to `../evidence/` and record the actual outcome below.

### Configuration Test

- Status: `PENDING LAB EXECUTION`
- Evidence: `../evidence/08-config-test.png`

### Suricata Service

- Status: `PENDING LAB EXECUTION`
- Evidence: `../evidence/09-suricata-status.png`

### ICMP Detection

- Status: `PENDING LAB EXECUTION`
- Evidence: `../evidence/11-fast-log-alert.png`

### Structured Alert

- Status: `PENDING LAB EXECUTION`
- Evidence: `../evidence/12-eve-json-alert.png`

> Update these entries after running the lab. Do not claim a detection succeeded until the evidence has been captured.
