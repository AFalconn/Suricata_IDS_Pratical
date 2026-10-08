# Suricata Setup Procedure

## 1. Verify installation

```bash
suricata -V
suricata --build-info
```

## 2. Identify interface

```bash
ip addr
ip route
```

## 3. Back up configuration

```bash
sudo cp /etc/suricata/suricata.yaml /etc/suricata/suricata.yaml.backup
```

## 4. Configure Suricata

Edit:

```bash
sudo nano /etc/suricata/suricata.yaml
```

Review:

- `HOME_NET`
- `af-packet`
- `default-rule-path`
- `rule-files`

## 5. Update rules

```bash
sudo suricata-update
```

## 6. Install custom rule

```bash
sudo mkdir -p /etc/suricata/rules
sudo nano /etc/suricata/rules/local.rules
```

Add:

```text
alert icmp any any -> any any (msg:"SURICATA ICMP TEST ALERT"; sid:1000001; rev:1;)
```

## 7. Test configuration

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml
```

## 8. Restart

```bash
sudo systemctl restart suricata
sudo systemctl status suricata
```

## 9. Generate authorized ICMP traffic

```bash
ping -c 4 <AUTHORIZED-LAB-IP>
```

## 10. Check alerts

```bash
sudo tail -f /var/log/suricata/fast.log
```

```bash
sudo tail -f /var/log/suricata/eve.json | jq
```

For the full portfolio explanation, see the root `README.md`.
