# 🛡️ Suricata IDS — Task 01
### Network Intrusion Detection, Custom Rule Creation & Alert Validation

![Linux](https://img.shields.io/badge/OS-Kali%20Linux-557C94?logo=kalilinux&logoColor=white)
![Suricata](https://img.shields.io/badge/Security%20Tool-Suricata-orange)
![Bash](https://img.shields.io/badge/Scripting-Bash-4EAA25?logo=gnubash&logoColor=white)
![Git](https://img.shields.io/badge/Version%20Control-Git-F05032?logo=git&logoColor=white)
![Status](https://img.shields.io/badge/Lab-Hands--On%20Complete-success)

> **Cybersecurity Lab Portfolio Project**
>
> This project documents the deployment and validation of **Suricata**, an open-source network intrusion detection and prevention engine, on Kali Linux. The lab demonstrates how to configure a network interface, define a trusted network, manage detection rules, create a custom ICMP signature, generate controlled traffic, and validate alerts through Suricata logs.

---

## 📌 Project Overview

The purpose of this lab was to move beyond simply installing a security tool and demonstrate a complete **detection workflow**:

```text
Network Traffic
      │
      ▼
┌───────────────────────┐
│   Suricata IDS        │
│                       │
│ Packet Capture        │
│ Rule Evaluation       │
│ Event Generation      │
└──────────┬────────────┘
           │
           ▼
     Custom ICMP Rule
       SID: 1000001
           │
           ▼
      Security Alert
       ┌────┴────┐
       ▼         ▼
   fast.log   eve.json
```

The lab uses a custom ICMP detection rule to demonstrate the complete path from **traffic → detection → alert → evidence**.

---

# 🎯 Objectives

By completing this lab, I aimed to:

- Verify a working Suricata installation.
- Identify the correct Linux network interface.
- Safely back up the Suricata configuration.
- Configure `HOME_NET`.
- Configure packet capture using `af-packet`.
- Update the Suricata ruleset.
- Create and load a custom detection rule.
- Validate the Suricata configuration before deployment.
- Run Suricata as a system service.
- Generate controlled ICMP traffic.
- Detect the traffic using a custom rule.
- Validate alerts through `fast.log` and `eve.json`.
- Document the investigation using Git and GitHub.

---

# 🧰 Technologies & Tools

| Technology | Purpose |
|---|---|
| Kali Linux | Security testing environment |
| Suricata | Network IDS/IPS |
| Bash | Linux automation and testing |
| ICMP | Controlled test traffic |
| `suricata-update` | Rule management |
| `systemctl` | Service management |
| `jq` | JSON log analysis |
| Git | Version control |
| GitHub | Portfolio/documentation |

---

# 🏗️ Repository Structure

```text
Suricata_Task01/
│
├── README.md
├── .gitignore
│
├── docs/
│   └── suricata_setup.md
│
├── evidence/
│   └── README.md
│
├── git-workflow/
│   └── README.md
│
├── results/
│   └── README.md
│
├── scripts/
│   ├── check_suricata.sh
│   ├── check_interface.sh
│   ├── test_suricata.sh
│   └── check_alerts.sh
│
├── suricata/
│   ├── local.rules
│   └── suricata-snippets.yaml
│
└── tests/
    ├── README.md
    └── icmp_test.sh
```

---

# 🔬 Lab Workflow

The lab follows a repeatable security operations workflow:

```text
01  Verify Suricata
        ↓
02  Identify Network Interface
        ↓
03  Back Up Configuration
        ↓
04  Configure HOME_NET
        ↓
05  Configure AF_PACKET
        ↓
06  Update Detection Rules
        ↓
07  Create Custom Rule
        ↓
08  Load Custom Rule
        ↓
09  Validate Configuration
        ↓
10  Start Suricata
        ↓
11  Generate Controlled Traffic
        ↓
12  Investigate Alerts
        ↓
13  Capture Evidence
        ↓
14  Document Results
```

---

# 1. Verify Suricata

The first step is confirming that Suricata is installed and available.

```bash
suricata -V
```

Additional build information:

```bash
suricata --build-info
```

If Suricata is not installed:

```bash
sudo apt update
sudo apt install suricata -y
```

---

# 2. Identify the Network Interface

The interface being monitored must be identified before configuring Suricata.

```bash
ip addr
```

or:

```bash
ip route
```

Example:

```text
default via 192.168.1.1 dev eth0
```

In this example:

```text
Monitored interface = eth0
```

> **Important:** `eth0` is only an example. The interface must be replaced with the interface actually present in the lab environment.

---

# 3. Back Up the Configuration

Before modifying Suricata:

```bash
sudo cp /etc/suricata/suricata.yaml \
/etc/suricata/suricata.yaml.backup
```

This provides a recovery point if a configuration change causes a problem.

---

# 4. Configure `HOME_NET`

`HOME_NET` identifies networks that Suricata considers local or trusted.

Example:

```yaml
HOME_NET: "[192.168.1.0/24]"
```

The correct network should be determined from the actual lab environment.

---

# 5. Configure Packet Capture

Suricata can use `af-packet` to capture traffic from a Linux network interface.

Example:

```yaml
af-packet:
  - interface: eth0
    cluster-id: 99
    cluster-type: cluster_flow
    defrag: yes
    tpacket-v3: yes
```

The interface must match the interface identified earlier.

---

# 6. Update Detection Rules

Suricata rules can be managed using:

```bash
sudo suricata-update
```

The main ruleset is normally placed under:

```text
/var/lib/suricata/rules/
```

Verify:

```bash
ls -lh /var/lib/suricata/rules/
```

---

# 7. Create a Custom Detection Rule

The custom rule for this lab is stored in:

```text
suricata/local.rules
```

Rule:

```text
alert icmp any any -> any any (msg:"SURICATA ICMP TEST ALERT"; sid:1000001; rev:1;)
```

### Rule analysis

| Component | Function |
|---|---|
| `alert` | Generates an alert |
| `icmp` | Matches ICMP traffic |
| `any any` | Any source |
| `->` | Traffic direction |
| `any any` | Any destination |
| `msg` | Alert description |
| `sid` | Unique signature ID |
| `rev` | Rule revision |

The custom signature ID is:

```text
1000001
```

---

# 8. Load the Custom Rule

The custom rule should be referenced from the Suricata configuration:

```yaml
default-rule-path: /var/lib/suricata/rules

rule-files:
  - suricata.rules
  - /etc/suricata/rules/local.rules
```

This separates the main managed ruleset from the custom lab rule.

---

# 9. Validate Before Deployment

Configuration testing is an important security administration habit.

Run:

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml
```

The configuration should successfully load before Suricata is restarted.

The custom rule can also be searched for:

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml 2>&1 | grep 1000001
```

---

# 10. Start Suricata

Restart the service:

```bash
sudo systemctl restart suricata
```

Check the service:

```bash
sudo systemctl status suricata
```

Expected state:

```text
Active: active (running)
```

---

# 11. Generate Controlled Test Traffic

The detection rule monitors ICMP.

Generate traffic against an **authorized lab host**:

```bash
ping -c 4 <AUTHORIZED-LAB-IP>
```

This creates ICMP packets that Suricata can inspect.

---

# 12. Validate the Alert

Monitor the fast alert log:

```bash
sudo tail -f /var/log/suricata/fast.log
```

The expected alert contains the custom signature:

```text
[1:1000001:1] SURICATA ICMP TEST ALERT
```

The detection chain is:

```text
Ping
  ↓
ICMP packet
  ↓
Network interface
  ↓
Suricata
  ↓
Rule SID 1000001
  ↓
Alert
  ↓
fast.log / eve.json
```

---

# 13. Investigate `eve.json`

Suricata's structured event log is:

```text
/var/log/suricata/eve.json
```

View it:

```bash
sudo tail -f /var/log/suricata/eve.json
```

For formatted JSON:

```bash
sudo tail -f /var/log/suricata/eve.json | jq
```

An alert event should contain:

```text
event_type: alert
```

and the custom message:

```text
SURICATA ICMP TEST ALERT
```

---

# 📊 Results

The successful result of this lab is demonstrated when:

- Suricata is installed and operational.
- The correct network interface is configured.
- `HOME_NET` is configured for the lab network.
- The Suricata configuration passes validation.
- SID `1000001` loads successfully.
- Suricata runs as an active service.
- Controlled ICMP traffic is generated.
- The custom ICMP rule triggers.
- The alert is visible in `fast.log`.
- The corresponding structured event appears in `eve.json`.

Detailed result notes can be maintained in:

```text
results/README.md
```

---

# 📸 Evidence

Screenshots and terminal captures should be stored in:

```text
evidence/
```

Recommended evidence:

```text
01-suricata-version.png
02-network-interface.png
03-config-backup.png
04-home-net.png
05-af-packet.png
06-rules-update.png
07-custom-rule.png
08-config-test.png
09-suricata-status.png
10-icmp-test.png
11-fast-log-alert.png
12-eve-json-alert.png
```

Evidence should show the command, relevant output, and enough context to demonstrate that the result came from the lab environment.

---

# ⚙️ Automation Scripts

The `scripts/` directory contains small Bash utilities for repeatable checks.

Examples:

```bash
./scripts/check_suricata.sh
./scripts/check_interface.sh
./scripts/test_suricata.sh
./scripts/check_alerts.sh
```

These scripts are intended to reinforce automation and reduce repetitive manual commands.

---

# 🧪 Testing

The `tests/` directory contains the controlled detection test.

The primary test is:

```text
ICMP traffic → Suricata → SID 1000001 → Alert
```

Run the ICMP test only against systems in an authorized lab environment.

---

# 🔐 Security Considerations

This project was performed as a controlled cybersecurity lab.

The ICMP rule is intentionally broad because the objective is to demonstrate the detection pipeline. In a production environment, detection rules should normally be tuned to reduce false positives and focus on meaningful security events.

Good operational practices demonstrated in this lab include:

- Backing up configuration before modification.
- Testing configuration before deployment.
- Using unique rule IDs.
- Separating custom rules from the main ruleset.
- Validating service status after changes.
- Reviewing both human-readable and structured logs.
- Keeping evidence of security testing.
- Using version control to document changes.

---

# 🧠 Key Learning Outcomes

This lab strengthened practical skills in:

### Network Security
- Network traffic monitoring
- IDS concepts
- Signature-based detection
- ICMP traffic analysis
- Alert investigation

### Linux
- Network interface discovery
- Configuration management
- File permissions
- Service management
- Log monitoring
- Bash scripting

### Suricata
- `suricata.yaml`
- `HOME_NET`
- `af-packet`
- Rule management
- Custom signatures
- `suricata-update`
- `fast.log`
- `eve.json`

### DevSecOps / Professional Workflow
- Git version control
- Structured project documentation
- Evidence management
- Repeatable testing
- Basic automation

---

# 🧩 Configuration vs Detection Rules

A key concept from this lab is the difference between configuration and detection logic.

```text
                 SURICATA
                     │
          ┌──────────┴──────────┐
          │                     │
   Configuration              Rules
          │                     │
 suricata.yaml          ┌───────┴────────┐
          │             │                │
     HOME_NET      suricata.rules   local.rules
     Interface        Main rules     Custom rule
     Rule paths
     Logging
```

### `suricata.yaml`

Controls **how Suricata operates**.

### `local.rules`

Controls **what specific traffic Suricata detects**.

Understanding this distinction is fundamental when troubleshooting IDS deployments.

---

# 🔄 Git Workflow

The project is maintained using Git.

Typical workflow:

```bash
git status
git add .
git commit -m "Document Suricata IDS lab"
git push
```

The repository provides a version-controlled record of the lab configuration, documentation, tests and evidence.

See:

```text
git-workflow/README.md
```

for the full Git workflow.

---

# 🚀 Possible Future Improvements

Future versions of this lab could include:

- HTTP detection rules
- DNS monitoring
- SSH brute-force detection
- TCP scan detection
- Custom rule tuning
- PCAP analysis
- Alert filtering with `jq`
- ELK/OpenSearch integration
- Security Onion integration
- Automated alert reporting
- Additional Bash automation
- Detection of multiple protocols
- False-positive analysis

---

# 📚 Project Documentation

| Resource | Purpose |
|---|---|
| `docs/` | Detailed technical procedure |
| `suricata/` | Custom Suricata materials |
| `tests/` | Detection testing |
| `scripts/` | Automation |
| `results/` | Lab results |
| `evidence/` | Screenshots and proof |
| `git-workflow/` | Git/GitHub workflow |

---

# ⚠️ Responsible Use

This project is intended for **authorized cybersecurity education and lab environments**.

Only generate traffic, monitor networks, or test detection rules on systems and networks that you own or have explicit permission to assess.

---

## 👩🏽‍💻 Skills Demonstrated

**Network Security • IDS • Suricata • Linux • Bash • Network Monitoring • Detection Engineering • Log Analysis • Git • GitHub • Cybersecurity Documentation • Security Testing**

---

### Project Status

**Task 01 — Suricata IDS Setup & Custom Detection**

```text
Configuration       ████████████████████  Complete
Custom Rule         ████████████████████  Complete
Detection Test      ████████████████████  Complete
Evidence            ████████████████████  Documented
Git Workflow        ████████████████████  Documented
```

> **Portfolio takeaway:** This project demonstrates the practical workflow of deploying an IDS, configuring its monitoring scope, creating a custom detection signature, generating controlled traffic, validating an alert, and documenting the complete security investigation.
