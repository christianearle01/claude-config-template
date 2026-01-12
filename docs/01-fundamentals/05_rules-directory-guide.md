# .claude/rules/ Directory - Modular Rule Management

**Introduced:** Claude Code 2.0.0
**Purpose:** Reusable, composable rules separate from project-specific CLAUDE.md
**Reading Time:** 10 minutes

---

## Overview

The `.claude/rules/` directory enables **modular rule management** - a pattern for organizing reusable guidelines that agents automatically load alongside your project-specific CLAUDE.md file.

**Key Benefits:**
- **Reusability:** Share coding standards across multiple projects
- **Modularity:** Mix and match rules without cluttering CLAUDE.md
- **Team Alignment:** Consistent rules across all team members
- **Version Control:** Track rule changes independently from project docs

---

## When to Use .claude/rules/ vs CLAUDE.md

### Use `.claude/rules/` for:

✅ **Reusable Patterns:**
- Coding standards (naming conventions, code style)
- Security policies (OWASP top 10, secrets handling)
- Testing requirements (coverage thresholds, test patterns)
- Documentation standards (comment styles, README templates)

✅ **Team-Shared Guidelines:**
- Company-wide development practices
- Language-specific best practices
- Framework conventions (React hooks, Vue composition API)
- CI/CD requirements

✅ **Modular Composition:**
- Pick and choose rules per project type
- Enable/disable rules by adding/removing files
- Override specific rules without editing shared files

**Example:**
```
.claude/rules/
├── coding-standards-javascript.md  # Shared across 10 projects
├── security-owasp-top-10.md       # Company-wide policy
└── testing-jest-patterns.md       # Team best practices
```

### Use `CLAUDE.md` for:

✅ **Project-Specific Context:**
- Tech stack and architecture decisions
- Business logic and domain knowledge
- Project goals and constraints
- Team structure and workflow

✅ **Evolving Instructions:**
- Features in progress
- Temporary workarounds
- Sprint-specific guidance
- Project memory (changes over time)

✅ **Unique Requirements:**
- One-off constraints
- Project-specific edge cases
- Custom integrations
- Non-reusable patterns

**Example CLAUDE.md:**
```markdown
# Project Memory - E-Commerce Platform

**Tech Stack:** React, Node.js, PostgreSQL
**Goal:** Build marketplace for handmade crafts

## Current Sprint
- Implementing checkout flow with Stripe integration
- User authentication with JWT tokens

## Known Issues
- Payment webhook needs retry logic (WIP)
```

---

## Directory Structure

### Recommended Organization

```
.claude/
├── CLAUDE.md                       # Project-specific instructions
├── rules/
│   ├── coding-standards.md         # General coding practices
│   ├── javascript-standards.md     # Language-specific rules
│   ├── react-best-practices.md     # Framework-specific rules
│   ├── security-policies.md        # Security requirements
│   ├── testing-requirements.md     # Test coverage and patterns
│   └── documentation-standards.md  # Comment and doc standards
└── settings.json
```

### Naming Conventions

**Pattern:** `[category]-[specificity].md`

**Examples:**
- `coding-standards.md` - General (applies to all languages)
- `javascript-standards.md` - Language-specific
- `react-best-practices.md` - Framework-specific
- `security-owasp-top-10.md` - Standard/methodology-specific

**Tip:** Use descriptive names - agents and teammates should understand the rule's purpose at a glance.

---

## Loading Behavior

### Automatic Loading

Agents automatically load ALL rules in `.claude/rules/` when they start:

1. **Discovery:** Agent scans `.claude/rules/` directory
2. **Loading:** Reads all `.md` files in alphabetical order
3. **Application:** Applies rules alongside CLAUDE.md instructions
4. **Precedence:** Later rules override earlier rules in case of conflicts

**Example:**
```
.claude/rules/
├── 01-coding-standards.md      # Loaded first
├── 02-javascript-standards.md  # Loaded second (can override 01)
└── 03-react-best-practices.md  # Loaded last (highest precedence)
```

**Tip:** Use numeric prefixes (01-, 02-) to control loading order when precedence matters.

### Conflict Resolution

When rules conflict, **later rules win:**

**01-coding-standards.md:**
```markdown
- Use 2 spaces for indentation
```

**02-python-standards.md:**
```markdown
- Use 4 spaces for indentation (Python PEP 8)
```

**Result:** Python files use 4 spaces (02 overrides 01).

### Disabling Rules

**Temporarily disable a rule:**
- Rename: `testing-requirements.md` → `testing-requirements.md.disabled`
- Agent skips files without `.md` extension

**Permanently remove a rule:**
- Delete the file from `.claude/rules/`
- Commit the deletion to share with team

---

## Example Rules

### Example 1: Coding Standards (General)

**File:** `.claude/rules/coding-standards.md`

```markdown
# Coding Standards - All Languages

**Applies To:** All code in this repository

## General Principles

**SOLID Principles:**
- Single Responsibility: Each function/class does one thing
- Open/Closed: Open for extension, closed for modification
- Liskov Substitution: Subtypes must be substitutable for base types
- Interface Segregation: Many specific interfaces > one general interface
- Dependency Inversion: Depend on abstractions, not concretions

**DRY (Don't Repeat Yourself):**
- Extract repeated code into functions/modules
- Three strikes rule: 3+ occurrences = time to refactor

**YAGNI (You Aren't Gonna Need It):**
- Don't build features "just in case"
- Implement when actually needed, not speculatively

## Code Style

**Naming Conventions:**
- Variables: `camelCase` (JavaScript, Java) or `snake_case` (Python, Ruby)
- Constants: `UPPER_SNAKE_CASE`
- Classes: `PascalCase`
- Functions: Verb-noun pairs (`getUserById`, `calculateTotal`)

**Function Length:**
- Target: Under 20 lines
- Max: 50 lines (extract if longer)
- One level of abstraction per function

**File Length:**
- Target: Under 200 lines
- Max: 500 lines (split if longer)

**Comments:**
- **Why**, not **what** (code shows what, comments explain why)
- Update comments when code changes (stale comments worse than no comments)
- Avoid obvious comments (`i++; // increment i`)

## Error Handling

**Always handle errors:**
- Never swallow exceptions silently
- Log errors with context (what failed, why, when)
- Provide actionable error messages to users

**Fail fast:**
- Validate inputs at function entry
- Throw errors early, handle late
- Don't let invalid state propagate

---

**Enforcement:** Code reviews check for these standards.
**Exceptions:** Discuss with team lead before deviating.
```

---

### Example 2: Security Policies

**File:** `.claude/rules/security-policies.md`

```markdown
# Security Policies - OWASP Top 10 Compliance

**Applies To:** All code handling user data or external input

## Input Validation

**NEVER trust user input:**
- Validate all input at system boundaries (API, forms, file uploads)
- Use allowlists, not denylists (specify what's allowed, not what's blocked)
- Sanitize before processing (strip HTML, escape SQL, encode for context)

**Examples:**
```javascript
// ❌ BAD: No validation
const userId = req.params.id;
db.query(`SELECT * FROM users WHERE id = ${userId}`);

// ✅ GOOD: Validated and parameterized
const userId = parseInt(req.params.id, 10);
if (!userId || userId < 1) throw new Error('Invalid user ID');
db.query('SELECT * FROM users WHERE id = ?', [userId]);
```

## Authentication & Authorization

**Authentication (who are you?):**
- Use proven libraries (Passport.js, Auth0, AWS Cognito)
- Hash passwords with bcrypt (cost factor 12+)
- Implement MFA for sensitive accounts
- Rate-limit login attempts (5 attempts per 15 minutes)

**Authorization (what can you do?):**
- Check permissions for EVERY request (don't trust client-side checks)
- Principle of least privilege (grant minimum necessary permissions)
- Use role-based access control (RBAC) or attribute-based (ABAC)

**Examples:**
```javascript
// ❌ BAD: Client-side only check
if (user.role === 'admin') {
  // Show admin panel
}

// ✅ GOOD: Server-side enforcement
app.post('/admin/users', requireAuth, requireRole('admin'), (req, res) => {
  // Admin-only endpoint with server-side checks
});
```

## Secrets Management

**NEVER commit secrets:**
- Use environment variables for API keys, passwords, tokens
- Add `.env` files to `.gitignore`
- Use secret managers (AWS Secrets Manager, HashiCorp Vault)

**Detection:**
- Pre-commit hooks scan for secrets (git-secrets, trufflehog)
- CI/CD pipelines reject commits with secrets

**Examples:**
```javascript
// ❌ BAD: Hardcoded secret
const apiKey = 'sk-1234567890abcdef';

// ✅ GOOD: Environment variable
const apiKey = process.env.API_KEY;
if (!apiKey) throw new Error('API_KEY not configured');
```

## SQL Injection Prevention

**Always use parameterized queries:**
```javascript
// ❌ BAD: String concatenation
db.query(`SELECT * FROM users WHERE email = '${email}'`);

// ✅ GOOD: Parameterized query
db.query('SELECT * FROM users WHERE email = ?', [email]);
```

## XSS Prevention

**Escape output by default:**
```javascript
// ❌ BAD: Raw HTML insertion
div.innerHTML = userComment;

// ✅ GOOD: Escaped text
div.textContent = userComment;

// ✅ GOOD: Framework auto-escapes
<div>{{ userComment }}</div>  // Vue/React escapes by default
```

## CSRF Protection

**Use CSRF tokens for state-changing operations:**
```javascript
// ✅ GOOD: CSRF protection
app.use(csrf());
app.post('/transfer-money', csrfProtection, (req, res) => {
  // Process transfer
});
```

---

**Enforcement:** Security reviews required for PRs touching auth/data handling.
**Training:** Annual security training mandatory for all engineers.
**Incident Response:** Report vulnerabilities to security@company.com immediately.
```

---

### Example 3: Testing Requirements

**File:** `.claude/rules/testing-requirements.md`

```markdown
# Testing Requirements

**Applies To:** All production code

## Coverage Requirements

**Minimum thresholds:**
- Unit tests: 80% code coverage
- Integration tests: 70% critical paths
- E2E tests: 100% user-facing flows

**Enforcement:** CI/CD blocks PRs below thresholds

## Test Patterns

**Unit Tests:**
- Test one unit in isolation (function, class, module)
- Mock external dependencies
- Fast (<1ms per test)

**Integration Tests:**
- Test multiple units together
- Use real dependencies (database, file system)
- Slower (<100ms per test)

**E2E Tests:**
- Test full user workflows
- Use real UI and backend
- Slowest (<5s per test)

**Example:**
```javascript
// Unit test - pure function
describe('calculateTotal', () => {
  it('sums item prices correctly', () => {
    const items = [{ price: 10 }, { price: 20 }];
    expect(calculateTotal(items)).toBe(30);
  });
});

// Integration test - database
describe('UserRepository', () => {
  it('creates and retrieves user', async () => {
    const user = await repo.create({ email: 'test@example.com' });
    const found = await repo.findById(user.id);
    expect(found.email).toBe('test@example.com');
  });
});

// E2E test - full workflow
describe('Checkout Flow', () => {
  it('completes purchase end-to-end', async () => {
    await page.goto('/products');
    await page.click('.add-to-cart');
    await page.click('.checkout');
    await page.fill('#card-number', '4242424242424242');
    await page.click('.submit-payment');
    await expect(page.locator('.success-message')).toBeVisible();
  });
});
```

## Test Quality

**Tests must be:**
- **Independent:** No shared state between tests
- **Repeatable:** Same inputs = same outputs (no flakiness)
- **Self-contained:** Each test sets up and tears down its own data
- **Readable:** Clear test names (`it('returns error for invalid email')`)

**Avoid:**
- Testing implementation details (test behavior, not internals)
- Over-mocking (integration tests should use real dependencies)
- Giant test files (split by feature/module)

---

**CI/CD:** All tests run on every commit.
**Review:** Tests reviewed with equal rigor as production code.
```

---

## Migration Guide

### Moving Standards from CLAUDE.md to rules/

**Before (CLAUDE.md):**
```markdown
# Project Memory

## Tech Stack
React, Node.js, PostgreSQL

## Coding Standards
- Use semicolons in JavaScript
- 2 spaces for indentation
- ESLint rules must pass
...
```

**After:**

**.claude/rules/javascript-standards.md:**
```markdown
# JavaScript Coding Standards

- Use semicolons
- 2 spaces for indentation
- ESLint rules must pass
...
```

**CLAUDE.md:**
```markdown
# Project Memory

## Tech Stack
React, Node.js, PostgreSQL

## Current Sprint
- Implementing checkout flow
...
```

**Benefits:**
- Coding standards now reusable across projects
- CLAUDE.md focused on project-specific context
- Team can update standards without touching CLAUDE.md

---

## Best Practices

### 1. Start with General, Layer Specific

**Hierarchy:**
```
01-coding-standards.md          # All languages
02-javascript-standards.md      # JavaScript-specific
03-react-best-practices.md      # React-specific
04-project-specific-rules.md    # This project only
```

### 2. Keep Rules Focused

**❌ Bad:** One giant `all-rules.md` file (hard to navigate, impossible to reuse)

**✅ Good:** Separate files per concern (coding, security, testing)

### 3. Make Rules Actionable

**❌ Bad:** "Write good code" (vague)

**✅ Good:** "Functions must be under 20 lines; extract if longer" (specific)

### 4. Version Control Rules

**Track changes:**
```bash
git log .claude/rules/security-policies.md
# See who updated security rules and when
```

### 5. Review Rules Regularly

**Quarterly review:**
- Are rules still relevant?
- Do new technologies require new rules?
- Are rules being followed? (check code reviews)

---

## Troubleshooting

### "Agent isn't following my rules"

**Check:**
1. File in `.claude/rules/` directory? (Not `.claude/rule/` or `claude/rules/`)
2. File has `.md` extension? (Not `.txt` or `.markdown`)
3. Rule conflicts with later rule? (Check loading order)
4. Rule clear and actionable? (Vague rules ignored)

### "Rules conflict with each other"

**Solution 1: Loading Order**
- Rename files to control precedence: `01-general.md`, `02-specific.md`
- Later rules override earlier rules

**Solution 2: Explicit Overrides**
```markdown
# JavaScript Standards

**Overrides:** coding-standards.md says 4 spaces, but JavaScript uses 2 spaces per community convention.
```

### "Too many rules, agent confused"

**Solution: Consolidate**
- Merge related rules into single files
- Remove outdated rules
- Keep total under 10 files (guideline, not hard limit)

---

## Integration with Template

The claude-config-template provides:
- **Example rules** in `examples/rules/` directory
- **CLAUDE.md template** that references rules system
- **Setup wizards** that help create rules structure

**To use:**
1. Copy example rules to your `.claude/rules/`
2. Customize for your team/project
3. Commit to version control
4. Share with team

---

## Further Reading

- [CLAUDE.md Template](../../templates/CLAUDE.md.template) - Project memory format
- [Coding Principles Handbook](06_coding-principles-handbook.md) - General best practices
- [Anti-Patterns Guide](../00-start-here/05_anti-patterns.md) - Common mistakes to avoid

---

**Next:** [Environment Variables Guide](../02-optimization/06_environment-variables.md)
**Previous:** [MCP Setup Guide](03_mcp-setup.md)
