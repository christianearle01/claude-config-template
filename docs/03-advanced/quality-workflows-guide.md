# Quality Workflows Guide

**Version:** 3.7.0
**Last Updated:** 2025-12-15

This guide provides a comprehensive overview of the Quality Workflows framework introduced in v3.7.0, helping you break through the AI productivity glass ceiling.

---

## Table of Contents

1. [Overview](#overview)
2. [The Productivity Glass Ceiling](#the-productivity-glass-ceiling)
3. [Quality Gates Architecture](#quality-gates-architecture)
4. [Using Security Scanner](#using-security-scanner)
5. [Using Test Generator](#using-test-generator)
6. [Using Standards Enforcer](#using-standards-enforcer)
7. [Using Quality Orchestrator](#using-quality-orchestrator)
8. [SDLC Integration](#sdlc-integration)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

---

## Overview

The Quality Workflows framework addresses the critical gap between AI code generation speed and code quality. While AI can generate code 3x faster, teams often hit a productivity glass ceiling because:

- 67% of developers have serious quality concerns about AI-generated code
- AI code leads to 97% more PRs and 90% more review time
- Security incidents increase 3x alongside code volume increases

**Solution:** Automated quality gates that validate code at every SDLC phase, preserving speed gains while maintaining quality.

### Components

| Component | Purpose | Type |
|-----------|---------|------|
| Security Scanner | OWASP Top 10, CVE, secrets detection | Skill |
| Test Generator | Generate tests from features.json | Skill |
| Standards Enforcer | Apply team standards with learning | Skill |
| Quality Orchestrator | Coordinate all gates in parallel | Agent |

### Impact (Projected)

- **47%** improvement in code review productivity
- **66%** reduction in security incidents
- **2x** increase in trust in AI-generated code
- Break through to **2-3x sustained productivity**

---

## The Productivity Glass Ceiling

### The Problem

```
Without Quality Workflows:

AI Generation Speed: 3x faster
├─ More code produced
├─ More PRs created (97% increase)
├─ More review time (90% increase)
├─ More bugs to fix (42% dev time)
├─ More security incidents (3x)
└─ Net productivity: ~1.2x (glass ceiling)

Speed gains are lost to quality issues!
```

### The Solution

```
With Quality Workflows:

AI Generation Speed: 3x faster
├─ Code validated automatically
├─ Security issues caught early
├─ Tests generated from criteria
├─ Standards enforced consistently
└─ Net productivity: 2-3x (ceiling broken)

Quality enables speed, not slows it!
```

### Key Insight

> "To break the productivity glass ceiling and achieve 2x or 10x gains, companies must invest in agentic quality workflows that operate throughout the Software Development Life Cycle."

Quality workflows are not overhead - they're the **enabler** of AI productivity.

---

## Quality Gates Architecture

### Parallel Execution

All quality gates run simultaneously, reducing total check time:

```
Quality Orchestrator
    │
    ├─── Security Scanner ──┐
    │    (30s)             │
    ├─── Test Generator ───┼─ Parallel (30s total)
    │    (30s)             │
    └─── Standards ────────┘
         (20s)
    │
    ▼
Unified Report
```

**Benefits:**
- Fast feedback (30s vs 80s sequential)
- Comprehensive coverage (all aspects checked)
- Single report (no context switching)

### Status Determination

| Status | Criteria | Action |
|--------|----------|--------|
| ✅ Pass | No critical/high issues, coverage ≥80% | Proceed |
| ⚠️ Conditional | 1-3 high issues, coverage 60-80% | Review and decide |
| ❌ Fail | Any critical, >3 high, coverage <60% | Must fix first |

### Phase-Specific Behavior

| Phase | Active Gates | Strictness |
|-------|--------------|------------|
| Development | Standards | Low (fast iteration) |
| Review | All three | High (full validation) |
| Testing | Test Generator | Medium |
| Deployment | Security, Tests | Critical (security focus) |

---

## Using Security Scanner

### Purpose

Prevent the 3x security incidents problem by automatically detecting:
- OWASP Top 10 vulnerabilities
- Dependency CVEs
- Hardcoded secrets

### Basic Usage

```markdown
User: "Scan this file for security issues"
User: "Check for SQL injection"
User: "Are there any secrets in the code?"
User: "Run a full security audit"
```

### What It Checks

#### OWASP Top 10

| ID | Vulnerability | Example |
|----|--------------|---------|
| A01 | Broken Access Control | Missing auth checks |
| A02 | Cryptographic Failures | Weak password hashing |
| A03 | Injection | SQL injection, XSS |
| A07 | XSS | Unescaped user input |

#### Dependency CVEs

- Checks package.json, requirements.txt, go.mod
- Reports known vulnerable versions
- Provides upgrade paths

#### Secrets Detection

- API keys (AWS, Stripe, GitHub)
- Database credentials
- Private keys
- JWT secrets

### Example Output

```markdown
## Security Scan Results

**File:** src/api/users.ts
**Overall Risk:** Critical (1 critical, 1 high)

### Critical: SQL Injection
**Line:** 42
**Confidence:** 98%

**Vulnerable:**
```javascript
db.query(`SELECT * FROM users WHERE id = ${userId}`);
```

**Fix:**
```javascript
db.query('SELECT * FROM users WHERE id = ?', [userId]);
```

### High: Missing Authorization
**Line:** 78
**Confidence:** 92%

[Details and fix...]
```

### Confidence Levels

| Confidence | Meaning | Action |
|------------|---------|--------|
| 90-100% | Definite vulnerability | Fix immediately |
| 75-89% | Likely vulnerability | Investigate |
| 50-74% | Possible issue | Review context |
| <50% | Possibly false positive | Optional |

---

## Using Test Generator

### Purpose

Double trust in AI-generated code by automatically creating tests from features.json test criteria.

### Basic Usage

```markdown
User: "Generate tests for feat-001"
User: "What's my test coverage?"
User: "Are all test criteria covered?"
User: "Update features.json with test results"
```

### How It Works

1. **Read features.json** - Extract testCriteria for feature
2. **Detect framework** - Jest, Vitest, PyTest, Go, etc.
3. **Generate tests** - One test per criterion
4. **Update features.json** - Add test file path, update adoption

### Example: features.json → Tests

**Input:**
```json
{
  "id": "feat-001",
  "testCriteria": [
    "User can log in with valid credentials",
    "Invalid credentials show error message",
    "Session persists across page refresh",
    "User can log out successfully"
  ]
}
```

**Output:**
```javascript
describe('feat-001: User Login', () => {
  test('User can log in with valid credentials', async () => {
    // Arrange
    render(<LoginForm />);

    // Act
    fireEvent.change(screen.getByLabelText('Email'), { target: { value: 'test@example.com' } });
    fireEvent.change(screen.getByLabelText('Password'), { target: { value: 'password' } });
    fireEvent.click(screen.getByText('Login'));

    // Assert
    await waitFor(() => {
      expect(screen.getByText('Welcome')).toBeInTheDocument();
    });
  });

  // ... 3 more tests for other criteria
});
```

### Supported Frameworks

| Framework | Language | Pattern |
|-----------|----------|---------|
| Jest | JavaScript/TypeScript | describe/it/expect |
| Vitest | JavaScript/TypeScript | describe/it/expect |
| PyTest | Python | test_*/assert |
| Go testing | Go | TestXxx/t.Run |
| RSpec | Ruby | describe/it/expect |

### Coverage Analysis

```markdown
## Test Coverage Analysis

**Overall Coverage:** 78% (28/36 criteria tested)

| Feature | Criteria | Tested | Coverage |
|---------|----------|--------|----------|
| feat-001: Login | 4 | 4 | 100% ✅ |
| feat-002: Register | 4 | 4 | 100% ✅ |
| feat-003: Cart | 4 | 2 | 50% ⚠️ |

### Missing Coverage

**feat-003: Cart** (50%)
- [ ] Cart total updates correctly
- [ ] Cart persists across sessions
```

---

## Using Standards Enforcer

### Purpose

Apply coding standards intelligently with dynamic learning that adapts to team preferences over time.

### Basic Usage

```markdown
User: "Review this code against our standards"
User: "What are our team's coding preferences?"
User: "Accept this suggestion" / "Reject this suggestion"
User: "Show learning statistics"
```

### Dynamic Learning

Unlike static linters, Standards Enforcer **learns** from your decisions:

```
Initial: "Prefer early returns" (50% confidence)
    ↓
Team rejects 80% of suggestions
    ↓
Learning: Confidence drops to 25%
    ↓
Result: Suggestion hidden (team prefers explicit conditionals)
```

### Confidence Levels

| Confidence | Status | Display |
|------------|--------|---------|
| 95%+ | Required | Always shown, blocks merge |
| 75-94% | Strong | Always shown |
| 50-74% | Consider | Shown with context |
| 25-49% | Optional | Hidden by default |
| <25% | Disabled | Never shown |

### Team Preferences

After collecting decisions, the skill can report on team preferences:

```markdown
## Team Coding Profile

**Strong preferences (>90%):**
- Null/undefined checks (98%)
- Error logging with context (94%)
- Type annotations (91%)

**Low preferences (<60%):**
- Early returns (23%)
- Single-line ifs (35%)

**Detected style:** Conservative/defensive coding
```

### Learning Data

Stored in `.claude/quality-standards.json`:

```json
{
  "rules": [
    {
      "id": "null-checks",
      "confidence": 98,
      "acceptanceRate": 0.976,
      "status": "enforced"
    },
    {
      "id": "early-returns",
      "confidence": 25,
      "acceptanceRate": 0.23,
      "status": "low-confidence"
    }
  ]
}
```

---

## Using Quality Orchestrator

### Purpose

Coordinate all quality gates in parallel and provide comprehensive quality reports integrated with the Coder agent workflow.

### Basic Usage

```markdown
User: "Check quality for this feature"
User: "Review PR #123 for quality"
User: "Is this ready to deploy?"
```

### Integration with Coder Agent

**Automatic quality checks after feature completion:**

```
Coder Agent: "Feature feat-007 complete."
    ↓
Quality Orchestrator: Runs all gates in parallel
    ↓
Results:
- Security: ✅ Pass (92%)
- Tests: ✅ Pass (88%)
- Standards: ⚠️ Warning (75%)
    ↓
Overall: ✅ Conditional Pass
    ↓
Coder Agent: "Quality checks passed with warnings.
Would you like to fix issues or proceed?"
```

### Example Report

```markdown
## Quality Review: feat-007 (Shopping Cart)

**Phase:** Review
**Overall Status:** ✅ Conditional Pass

### Gate Results

| Gate | Status | Confidence | Issues |
|------|--------|------------|--------|
| Security | ✅ Pass | 92% | 0 critical, 1 medium |
| Tests | ✅ Pass | 88% | 85% coverage |
| Standards | ⚠️ Warning | 75% | 2 medium suggestions |

### Recommendations

1. **Should fix:** Add input validation to quantity field
2. **Should fix:** Add null checks in cartSlice.ts
3. **Optional:** Rename 'qty' to 'quantity'

**Estimated time:** 15-20 minutes
```

---

## SDLC Integration

### Quality at Every Phase

| Phase | Focus | Gates | Strictness |
|-------|-------|-------|------------|
| Planning | Requirements | - | - |
| Development | Fast feedback | Standards | Low |
| Review | Full validation | All three | High |
| Testing | Coverage | Test Generator | Medium |
| Deployment | Security | Security, Tests | Critical |

### Development Phase

- **Goal:** Fast iteration without slowdown
- **Active:** Standards Enforcer only
- **Behavior:** Light suggestions, don't block

### Review Phase

- **Goal:** Comprehensive validation before merge
- **Active:** All three gates
- **Behavior:** Full reports, block on critical/high

### Deployment Phase

- **Goal:** Final security check
- **Active:** Security Scanner + Tests
- **Behavior:** Block on ANY security issue

---

## Best Practices

### 1. Start with Security

Security issues are the highest priority. Run security scans:
- Before every commit
- In every PR
- Before every deployment

### 2. Let Standards Learn

Don't fight the learning system:
- Accept suggestions that match team style
- Reject suggestions that don't fit
- After ~50 decisions, system adapts to your team

### 3. Generate Tests from Criteria

Write test criteria in features.json first:
- Specific, observable behaviors
- Not implementation details
- Then generate tests automatically

### 4. Use Quality Orchestrator

Don't run gates manually one by one:
- Orchestrator runs all in parallel
- Single unified report
- Integrated with Coder agent

### 5. Review Phase is Critical

Development phase is light for speed, but:
- Review phase should be comprehensive
- Block PRs with critical/high issues
- This is where quality is enforced

---

## Troubleshooting

### Issue: Too Many False Positives

**Cause:** Static rules don't match team preferences

**Solution:**
1. Reject false positive suggestions
2. Let learning system adjust confidence
3. After ~10 rejections, suggestion will be hidden

### Issue: Gate Timeout

**Cause:** Large codebase or slow network

**Solution:**
```markdown
Options:
1. Increase timeout: `--timeout 60000`
2. Scan specific files: "Scan src/auth/"
3. Use development phase (lighter checks)
```

### Issue: Missing Test Framework

**Cause:** No testing dependencies installed

**Solution:**
```bash
# For React/JavaScript
npm install --save-dev jest @testing-library/react

# For Python
pip install pytest

# For Go
# Built-in, no installation needed
```

### Issue: Standards Conflict with CLAUDE.md

**Cause:** Different rules in different files

**Solution:**
- CLAUDE.md takes priority over coding-standards.md
- Update one file to match the other
- Document the decision

### Issue: Security Scanner Too Strict

**Cause:** Blocking on informational findings

**Solution:**
- Review confidence scores
- Only critical/high should block
- Medium/low are informational

---

## Quick Reference

### Commands

| Command | Description |
|---------|-------------|
| "Scan for security issues" | Run Security Scanner |
| "Generate tests for feat-XXX" | Run Test Generator |
| "Review against standards" | Run Standards Enforcer |
| "Check quality" | Run Quality Orchestrator |
| "Is this ready to deploy?" | Deployment quality check |

### Status Icons

| Icon | Meaning |
|------|---------|
| ✅ | Pass |
| ⚠️ | Warning (conditional pass) |
| ❌ | Fail (blocked) |
| ℹ️ | Informational |

### Confidence Colors

| Range | Color | Meaning |
|-------|-------|---------|
| 90-100% | Green | High confidence |
| 60-89% | Yellow | Medium confidence |
| 0-59% | Red | Low confidence |

---

## Next Steps

1. **Read:** QUALITY_WORKFLOWS.md for theoretical background
2. **Configure:** .claude/quality-config.json for your team
3. **Use:** Quality Orchestrator in your daily workflow
4. **Learn:** Let Standards Enforcer adapt to your team

**Remember:** Quality workflows are the enabler of AI productivity, not the brake. Embrace them to break through the glass ceiling!
