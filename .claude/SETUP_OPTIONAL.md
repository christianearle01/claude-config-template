# Optional Features - Package Security

**Purpose:** Optional security guidance for Claude Code projects that install external packages (npm, Python, etc.).

**Note:** This template itself has zero dependencies - these are preventative docs for YOUR projects.

---

## Package Malware Protection (OPTIONAL)

**When to use this:**
- ✅ Projects that install npm packages
- ✅ Projects that use pip/Python packages
- ✅ Team projects with package managers
- ❌ Documentation-only projects (like this template)

---

## Quick Setup: NPM Projects

```bash
# 1. Copy .npmrc to block install scripts
cp ~/claude-config-template/.npmrc .

# 2. Weekly audit
npm audit

# 3. Commit lockfile
git add package-lock.json
```

**Resources:**
- Universal guide: `01_global-setup/03_nice-to-have/02_package-security-principles.md`
- NPM checklist: `01_global-setup/03_nice-to-have/03_npm-security-checklist.md`
- NPM scripts: `examples/npm-security/` (5 automation scripts)

---

## Quick Setup: Python Projects

```bash
# 1. Copy pip.conf to prefer wheels
cp ~/claude-config-template/pip.conf .

# 2. Weekly audit
pip install pip-audit && pip-audit

# 3. Pin versions
pip freeze > requirements.txt
```

**Resources:**
- Universal guide: `01_global-setup/03_nice-to-have/02_package-security-principles.md`
- Python checklist: `01_global-setup/03_nice-to-have/03_python-security-checklist.md`
- Python scripts: `examples/python-security/` (5 automation scripts)

---

## Real Threats (Factual Examples)

These are **real incidents** (not theoretical):

- **event-stream (NPM, 2018):** 2M weekly downloads compromised
- **ctx/php (Python PyPI, 2022):** AWS credentials exfiltrated
- **rest-client (Ruby, 2019):** Backdoor from compromised account

**Conclusion:** Package security is not paranoia - it's prudent engineering for projects using external dependencies.

---

## When NOT to worry about this

- Documentation projects (like this template)
- Projects with no package.json or requirements.txt
- Static sites with no build process
- Pure Bash/shell script projects

---

**Back to main setup:** See [SETUP_CONTEXT.md](SETUP_CONTEXT.md)
