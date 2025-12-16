# NPM Package Security Checklist

**For:** Protecting your Claude Code projects from malicious npm packages

**Time:** 2 minutes to scan

---

## ✅ Essential Security Measures

### Before Installing Any Package

- [ ] **Audit before install**: Run `npm audit` before adding packages
- [ ] **Check package reputation**:
  - Weekly downloads > 10,000 (check on npmjs.com)
  - Recent updates (within last 6 months)
  - Verified publisher badge
  - Public GitHub repository available
- [ ] **Review package.json scripts**: Check for suspicious `preinstall`, `postinstall`, or `install` commands
- [ ] **Use exact versions**: `npm install --save-exact package@1.2.3`
- [ ] **Enable lockfile**: Always commit `package-lock.json` to git

### Project Configuration

- [ ] **Create `.npmrc`**: Copy from template root or examples/npm-security/
- [ ] **Ignore scripts**: Add `ignore-scripts=true` to `.npmrc`
- [ ] **Set audit level**: Add `audit-level=moderate` to `.npmrc`
- [ ] **Use official registry only**: `registry=https://registry.npmjs.org/`
- [ ] **Save exact versions**: Add `save-exact=true` to `.npmrc`

### Ongoing Maintenance

- [ ] **Weekly audits**: Run `npm audit` every week
- [ ] **Update dependencies carefully**: Run `npm outdated` monthly, review changelogs
- [ ] **Review changelogs**: Read CHANGELOG.md before major version updates
- [ ] **Monitor security advisories**: Subscribe to npm security alerts
- [ ] **Remove unused dependencies**: Run `npx depcheck` quarterly

---

## 🚨 Red Flags - Don't Install If:

1. **Package has < 1,000 weekly downloads** (typosquatting risk)
2. **No GitHub repository or documentation**
3. **Obfuscated code in package** (base64, eval, hex strings)
4. **Suspicious install scripts** (curl, wget, rm -rf in postinstall)
5. **Recently created + high downloads** (coordinated attack pattern)
6. **Similar name to popular package** (lodash vs loadsh, react vs reactt)
7. **Maintainer account recently created** (< 30 days old)
8. **Package published very recently** (< 7 days) with no prior versions

---

## 🔍 Quick Verification Commands

```bash
# Check package reputation
npm view package-name

# See install scripts before running
npm view package-name scripts

# Audit specific package
npm audit --package-lock-only

# Verify package integrity
npm view package-name dist.integrity

# Check package download stats
npm view package-name time downloads

# See package dependencies
npm view package-name dependencies

# Check who maintains the package
npm view package-name maintainers
```

---

## 📦 Recommended Security Tools

**Install these dev dependencies:**

```bash
# Audit tool (built-in, no install needed)
npm audit

# Check for unused dependencies
npx depcheck

# Advanced security scanning (optional)
npm install --save-dev socket-security
npx socket-security check

# Check for outdated packages
npm outdated
```

---

## 🔒 Project Setup Template

**Quick setup for new projects:**

```bash
# 1. Copy .npmrc from template
cp /path/to/claude-config-template/.npmrc .

# 2. Initialize package.json with security settings
npm init -y

# 3. Add security scripts to package.json
npm pkg set scripts.audit="npm audit --audit-level=moderate"
npm pkg set scripts.audit:fix="npm audit fix"
npm pkg set scripts.verify="npm run audit && npm outdated"

# 4. Install packages with audit
npm install package-name --save-exact

# 5. Commit lockfile
git add package-lock.json
git commit -m "Add package-lock.json for security integrity"
```

---

## ⚡ Quick Start Commands

**Day-to-day security workflow:**

```bash
# Before installing ANY new package
npm audit
npm view package-name

# Install with security
npm install package-name --save-exact

# Weekly security check
npm audit && npm outdated

# Monthly dependency cleanup
npx depcheck
```

---

## 🔗 Related Documentation

**For more details:**
- **Universal Principles**: [Package Security Principles](./02_package-security-principles.md)
- **Comprehensive Guide**: [NPM Security Guide](./04_npm-security-guide.md)
- **Automation Scripts**: `examples/npm-security/`
- **Templates**: `.npmrc`, `examples/npm-security/package.json.template`

**External Resources:**
- [NPM Security Best Practices](https://docs.npmjs.com/security-best-practices)
- [Socket.dev - NPM Monitoring](https://socket.dev/)
- [Snyk Advisor](https://snyk.io/advisor/)

---

## 💡 Key Takeaways

1. ✅ **Block auto-execution** - Add `ignore-scripts=true` to `.npmrc`
2. ✅ **Audit before install** - Always run `npm audit` first
3. ✅ **Verify reputation** - Check downloads, GitHub, maintainers
4. ✅ **Commit lockfiles** - `package-lock.json` ensures integrity
5. ✅ **Use exact versions** - Prevent unexpected updates
6. ✅ **Regular audits** - Weekly `npm audit` is essential
7. ✅ **Review changes** - Read changelogs before updating
8. ✅ **Stay informed** - Subscribe to security advisories

---

**Remember:** Most npm malware runs via install scripts. Blocking them (`ignore-scripts=true`) prevents 80%+ of attacks!

**Last Updated:** 2025-12-09
**Version:** 1.0
