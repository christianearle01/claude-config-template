# Python Package Security Checklist

**For:** Protecting your Claude Code projects from malicious Python packages

**Time:** 2 minutes to scan

---

## ✅ Essential Security Measures

### Before Installing Any Package

- [ ] **Audit before install**: Run `pip-audit` or `safety check` before adding packages
- [ ] **Check package reputation**:
  - Weekly downloads > 10,000 (check on pypi.org)
  - Recent updates (within last 6 months)
  - Verified maintainer
  - Public GitHub repository available
- [ ] **Review setup.py**: Check for suspicious commands in setup.py or pyproject.toml
- [ ] **Use exact versions**: `pip install package==1.2.3` (not `>=` or `~=`)
- [ ] **Prefer wheels over source**: Use `pip install --only-binary :all: package-name`

### Project Configuration

#### Using pip:
- [ ] **Create `pip.conf`**: Copy from template root
- [ ] **Prefer binary wheels**: Add `only-binary=:all:` to pip.conf
- [ ] **Use official PyPI only**: `index-url = https://pypi.org/simple/`
- [ ] **Pin versions**: Use exact versions in requirements.txt
- [ ] **Add hashes**: Generate with `pip-compile --generate-hashes` (production)

#### Using Poetry (Recommended):
- [ ] **Initialize with Poetry**: `poetry init`
- [ ] **Use exact versions**: `poetry add package==1.2.3`
- [ ] **Commit poetry.lock**: Always commit lockfile to git
- [ ] **Separate dev/prod**: Use `poetry add --group dev` for dev dependencies

### Ongoing Maintenance

- [ ] **Weekly audits**: Run `pip-audit` or `safety check` weekly
- [ ] **Update dependencies carefully**: Run `pip list --outdated` monthly
- [ ] **Review changelogs**: Read release notes before major updates
- [ ] **Monitor security advisories**: Subscribe to PyPI security alerts
- [ ] **Remove unused dependencies**: Run `pip-autoremove` quarterly

---

## 🚨 Red Flags - Don't Install If:

1. **Package has < 1,000 weekly downloads** (typosquatting risk)
2. **No PyPI project page or documentation**
3. **Obfuscated code** (base64, exec, compile in setup.py)
4. **Suspicious setup.py commands** (curl, wget, os.system in setup.py)
5. **Recently created + high downloads** (coordinated attack)
6. **Similar name to popular package** (requests vs reqeusts, numpy vs numpi)
7. **Source-only distribution** (no wheels available - requires running setup.py)
8. **Package published very recently** (< 7 days) with no prior versions

---

## 🔍 Quick Verification Commands

### pip Commands:

```bash
# Check package reputation
pip show package-name

# See package details on PyPI
pip index versions package-name

# Download without installing (for inspection)
pip download package-name --no-deps

# Check package files
pip show -f package-name

# Verify package integrity (if using hashes)
pip install -r requirements.txt --require-hashes
```

### Poetry Commands:

```bash
# Check package info
poetry show package-name

# Show package tree
poetry show --tree

# Check for outdated packages
poetry show --outdated

# Dry run before adding
poetry add package-name --dry-run
```

---

## 📦 Recommended Security Tools

**Install these security tools:**

```bash
# pip-audit (official PyPA tool)
pip install pip-audit
pip-audit

# Safety (vulnerability database)
pip install safety
safety check

# Bandit (Python code security linter)
pip install bandit
bandit -r .

# pip-autoremove (remove unused packages)
pip install pip-autoremove
```

**For Poetry projects:**

```bash
# Add to dev dependencies
poetry add --group dev bandit safety

# Run security checks
poetry run bandit -r .
poetry export -f requirements.txt | safety check --stdin
```

---

## 🔒 Project Setup Template

### Quick setup for pip projects:

```bash
# 1. Copy pip.conf from template
cp /path/to/claude-config-template/pip.conf .

# 2. Create virtual environment
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
# .venv\Scripts\activate   # Windows

# 3. Install security tools
pip install pip-audit safety

# 4. Create requirements.txt with exact versions
pip freeze > requirements.txt

# 5. Install packages with audit
pip-audit
pip install package-name==1.2.3

# 6. Update and commit requirements
pip freeze > requirements.txt
git add requirements.txt
git commit -m "Add requirements.txt with pinned versions"
```

### Quick setup for Poetry projects:

```bash
# 1. Initialize Poetry project
poetry init

# 2. Copy pyproject.toml template
cp examples/python-security/pyproject.toml.template pyproject.toml

# 3. Add dependencies
poetry add package-name==1.2.3

# 4. Add security tools (dev dependencies)
poetry add --group dev pip-audit safety bandit

# 5. Commit lockfile
git add poetry.lock pyproject.toml
git commit -m "Add Poetry lockfile for security integrity"
```

---

## ⚡ Quick Start Commands

**Day-to-day security workflow:**

### Using pip:

```bash
# Before installing ANY new package
pip-audit
pip show package-name

# Install with security (wheels only)
pip install --only-binary :all: package-name==1.2.3

# Weekly security check
pip-audit && pip list --outdated

# Monthly dependency cleanup
pip list --format=freeze > current-deps.txt
# Review and remove unused
```

### Using Poetry:

```bash
# Before installing ANY new package
poetry show package-name

# Install with audit
poetry add package-name==1.2.3

# Weekly security check
poetry export -f requirements.txt | pip-audit -r /dev/stdin
poetry show --outdated

# Monthly cleanup
poetry show --tree  # Review dependencies
```

---

## 🔗 Related Documentation

**For more details:**
- **Universal Principles**: [Package Security Principles](./02_package-security-principles.md)
- **Comprehensive Guide**: [Python Security Guide](./05_python-security-guide.md)
- **Automation Scripts**: `examples/python-security/`
- **Templates**: `pip.conf`, `examples/python-security/requirements.txt.template`, `examples/python-security/pyproject.toml.template`

**External Resources:**
- [PyPI Security](https://pypi.org/security/)
- [pip-audit Documentation](https://github.com/pypa/pip-audit)
- [Poetry Security](https://python-poetry.org/docs/)
- [Python Packaging User Guide](https://packaging.python.org/)

---

## 💡 Key Takeaways

1. ✅ **Use wheels only** - Add `only-binary=:all:` to pip.conf
2. ✅ **Audit before install** - Run `pip-audit` or `safety check` first
3. ✅ **Verify reputation** - Check downloads, GitHub, maintainers
4. ✅ **Commit lockfiles** - `poetry.lock` or hashed `requirements.txt` ensure integrity
5. ✅ **Use exact versions** - No `>=`, `~=`, or `^` operators
6. ✅ **Prefer Poetry** - Better security by default (no install hooks)
7. ✅ **Regular audits** - Weekly `pip-audit` is essential
8. ✅ **Virtual environments** - Always isolate project dependencies

---

## 🎯 pip vs Poetry Security Comparison

| Feature | pip | Poetry |
|---------|-----|--------|
| **Lockfile** | Manual (requires pip-tools) | Automatic (poetry.lock) |
| **Install Scripts** | Runs setup.py by default ⚠️ | No install hooks ✅ |
| **Hash Verification** | Manual (--require-hashes) | Automatic ✅ |
| **Dependency Resolution** | Basic | Advanced ✅ |
| **Audit Tool** | pip-audit (separate install) | Export + pip-audit |
| **Security** | Requires configuration | Secure by default ✅ |

**Recommendation:** Use Poetry for new projects (better security defaults).

---

**Remember:** Most Python malware runs via setup.py. Using wheels (`only-binary=:all:`) prevents 80%+ of attacks!

**Last Updated:** 2025-12-09
**Version:** 1.0
