# Quality Context Optimization Guide

**Version:** 3.7.0
**Last Updated:** 2025-12-15

This guide explains how context quality affects AI code quality and provides strategies for optimizing context to improve quality gate results.

---

## Table of Contents

1. [Why Context Matters](#why-context-matters)
2. [The Four Levels of Context](#the-four-levels-of-context)
3. [Context Loading Strategies](#context-loading-strategies)
4. [Optimizing Each Context Level](#optimizing-each-context-level)
5. [Token Efficiency](#token-efficiency)
6. [Best Practices](#best-practices)

---

## Why Context Matters

### The Trust Problem

> "Developers who distrust AI code cited insufficient LLM context 80% of the time."

Context is the #1 factor determining AI code quality. Without proper context:
- AI generates generic code that doesn't fit your patterns
- Security issues arise from missing requirements knowledge
- Tests miss edge cases specific to your domain
- Standards violations occur due to unknown conventions

### Context vs Quality Correlation

```
Context Quality     → AI Code Quality
───────────────────────────────────────
Low (generic)       → 40% acceptable
Medium (codebase)   → 65% acceptable
High (full stack)   → 85% acceptable
Optimal (all 4)     → 95% acceptable
```

### Quality Gates and Context

Quality gates perform better with rich context:

| Gate | Without Context | With Context |
|------|-----------------|--------------|
| Security Scanner | Generic patterns | Domain-specific rules |
| Test Generator | Basic tests | Business logic coverage |
| Standards Enforcer | Static rules | Team-adapted suggestions |

---

## The Four Levels of Context

### Level 1: Codebase Context (Foundation)

**What it includes:**
- Current source files
- Project structure
- Dependencies (package.json, requirements.txt)
- Configuration files

**Impact on quality:**
- Enables pattern matching in existing code
- Identifies inconsistencies with current implementation
- Detects unused imports, dead code

**Token usage:** 60-70% of context budget

### Level 2: Standards Context (8% of usage)

**What it includes:**
- `coding-standards.md` (global standards)
- `CLAUDE.md` (project conventions)
- `.eslintrc`, `.prettierrc` (enforced rules)
- Team preferences from learning history

**Impact on quality:**
- Enables team-specific suggestions
- Reduces false positives (knows what team accepts)
- Enforces consistency across codebase

**Token usage:** ~8% of context budget

**Key insight:** Standards context has the highest ROI per token. Small investment, large quality improvement.

### Level 3: Historical Context (Patterns)

**What it includes:**
- Git history (recent commits)
- PR history (what passed review)
- Commit messages (decision rationale)
- Past quality gate results

**Impact on quality:**
- Understands evolution of codebase
- Knows what changes were rejected before
- Learns from past mistakes

**Token usage:** 10-15% of context budget

### Level 4: Quality Context (Validation)

**What it includes:**
- Test results (passing/failing)
- Security audit logs
- Performance benchmarks
- Code review feedback patterns

**Impact on quality:**
- Validates assumptions with real data
- Prioritizes issues based on impact
- Tracks quality trends over time

**Token usage:** 5-10% of context budget

---

## Context Loading Strategies

### Strategy 1: Progressive Loading

Load context in layers based on task complexity:

```markdown
**Simple task (typo fix):**
└─ Level 1: Affected file only

**Medium task (new feature):**
├─ Level 1: Feature files + related modules
└─ Level 2: CLAUDE.md standards

**Complex task (architecture change):**
├─ Level 1: Multiple modules
├─ Level 2: Full standards
├─ Level 3: Recent commits affecting area
└─ Level 4: Test results for affected areas
```

### Strategy 2: On-Demand Loading

Load additional context when needed:

```markdown
**Initial load:** Level 1 (codebase basics)
    ↓
**Security scan finds issue**
    ↓
**Load additional:** Security audit logs (Level 4)
    ↓
**Standards check fails**
    ↓
**Load additional:** Team preference history (Level 2)
```

### Strategy 3: Precomputed Summaries

Instead of loading raw files, use summaries:

```markdown
**Raw context (expensive):**
- Full git log: 5,000 tokens
- All test results: 3,000 tokens
- Complete ESLint config: 1,000 tokens

**Summarized context (efficient):**
- Recent changes summary: 500 tokens
- Test status summary: 200 tokens
- Active standards: 300 tokens

Savings: 8,000 tokens → 1,000 tokens (87% reduction)
```

---

## Optimizing Each Context Level

### Optimizing Level 1: Codebase Context

**Problem:** Loading entire codebase is expensive and noisy

**Solutions:**

1. **Relevance filtering:**
   ```markdown
   Task: "Fix login bug"

   Load: src/auth/**
   Skip: src/cart/**, src/admin/**

   Tokens saved: 70%
   ```

2. **Import tracing:**
   ```markdown
   Starting file: src/auth/LoginForm.tsx

   Trace imports:
   ├─ src/services/authService.ts
   ├─ src/hooks/useAuth.ts
   └─ src/context/AuthContext.tsx

   Load only traced files (not entire src/)
   ```

3. **Summary files:**
   ```markdown
   Instead of: 50 component files
   Load: components/README.md (architecture overview)

   Gives: Structure understanding
   Costs: 200 tokens vs 10,000 tokens
   ```

### Optimizing Level 2: Standards Context

**Problem:** Full standards docs are lengthy

**Solutions:**

1. **Category filtering:**
   ```markdown
   Task: "Add API endpoint"

   Load standards for:
   - API conventions
   - Error handling
   - Security requirements

   Skip standards for:
   - UI components
   - Testing patterns (not relevant yet)
   ```

2. **Confidence-based filtering:**
   ```markdown
   From quality-standards.json:

   Load: Rules with confidence > 75%
   Skip: Rules with confidence < 50% (team rarely follows)

   Result: Only relevant, accepted standards loaded
   ```

3. **CLAUDE.md sections:**
   ```markdown
   CLAUDE.md structure:

   ## Code Style (always load)
   ## API Conventions (load for API tasks)
   ## Testing (load for test tasks)
   ## Deployment (load for deploy tasks)

   Load only relevant sections
   ```

### Optimizing Level 3: Historical Context

**Problem:** Git history can be massive

**Solutions:**

1. **Recency filter:**
   ```markdown
   Load: Commits from last 30 days
   Skip: Older history

   Rationale: Recent patterns more relevant
   ```

2. **Path filter:**
   ```markdown
   Task: "Modify cart logic"

   Load: git log -- src/cart/
   Skip: git log (entire repo)

   Tokens: 500 vs 5,000
   ```

3. **Summary extraction:**
   ```markdown
   Instead of: Full commit diffs
   Extract: Commit messages only

   Pattern: "feat:", "fix:", "refactor:"

   Gives: Intent without implementation details
   ```

### Optimizing Level 4: Quality Context

**Problem:** Test/security logs are verbose

**Solutions:**

1. **Status summaries:**
   ```markdown
   Instead of: Full test output (2,000 lines)
   Load: Test summary

   { "total": 150, "passed": 148, "failed": 2, "coverage": 85 }

   Tokens: 50 vs 5,000
   ```

2. **Failure focus:**
   ```markdown
   Load: Failed tests only
   Skip: Passing tests (not actionable)

   Rationale: Quality gates focus on issues
   ```

3. **Trend data:**
   ```markdown
   Instead of: All historical scans
   Load: Trend summary

   "Coverage trend: 80% → 82% → 85% (improving)"
   "Security issues: 5 → 3 → 1 (decreasing)"
   ```

---

## Token Efficiency

### Context Budget Allocation

**Recommended distribution:**

| Level | Allocation | Purpose |
|-------|------------|---------|
| Level 1: Codebase | 60-70% | Core understanding |
| Level 2: Standards | 8-10% | Team conventions |
| Level 3: Historical | 10-15% | Evolution context |
| Level 4: Quality | 5-10% | Validation data |

### Token Savings by Strategy

| Strategy | Savings | Trade-off |
|----------|---------|-----------|
| Relevance filtering | 70% | May miss related code |
| Summary files | 80% | Less detail |
| Confidence filtering | 50% | Miss low-priority rules |
| Recency filtering | 60% | Miss old patterns |
| Status summaries | 90% | No detailed logs |

### Example: Full vs Optimized

**Full context load (unoptimized):**
```
Level 1: All source files       15,000 tokens
Level 2: Full standards          2,000 tokens
Level 3: Complete git history    5,000 tokens
Level 4: All test/security logs  3,000 tokens
─────────────────────────────────────────────
Total:                          25,000 tokens
```

**Optimized context load:**
```
Level 1: Relevant files only     5,000 tokens
Level 2: Applicable standards      500 tokens
Level 3: Recent, path-filtered     800 tokens
Level 4: Status summaries          200 tokens
─────────────────────────────────────────────
Total:                           6,500 tokens

Savings: 74% (18,500 tokens)
```

---

## Best Practices

### 1. Start with Standards

Load Level 2 (standards) before Level 1 (codebase):

```markdown
Why: Standards tell AI what patterns to look for
Result: More focused codebase analysis
Efficiency: Better quality with same token budget
```

### 2. Use features.json as Index

features.json provides structured context:

```markdown
What it gives:
- Feature scope (which files to load)
- Test criteria (what to validate)
- Dependencies (related features)
- Status (what's complete vs in-progress)

Token cost: ~200 tokens
Value: Guides all other context loading
```

### 3. Leverage Quality Gate History

Use past quality results to focus current scans:

```markdown
If previous scan found SQL injection:
- Load: SQL-related security rules
- Focus: Database access patterns
- Skip: UI security rules (less relevant)

Result: Targeted, efficient scan
```

### 4. Progressive Disclosure

Start minimal, expand as needed:

```markdown
Step 1: Load minimal context
Step 2: Run quality gates
Step 3: If issues found, load additional context for that area
Step 4: Re-run specific gate with enriched context

Benefit: Only pay for context when needed
```

### 5. Cache Stable Context

Some context doesn't change often:

```markdown
Cache candidates:
- CLAUDE.md (changes rarely)
- coding-standards.md (changes rarely)
- Project structure (changes slowly)
- Team preferences (changes gradually)

Refresh: Daily or on file change
Benefit: Instant load, no token cost
```

### 6. Context Quality > Quantity

Better to have 5,000 tokens of relevant context than 25,000 tokens of everything:

```markdown
High-quality context:
- Directly relevant to task
- Recently updated
- Team-validated patterns
- Actionable information

Low-quality context:
- Tangentially related
- Outdated information
- Unvalidated patterns
- Verbose logs
```

---

## Quick Reference

### Context Loading Checklist

- [ ] Load standards first (Level 2)
- [ ] Read features.json for scope
- [ ] Filter codebase to relevant files (Level 1)
- [ ] Add recent history for area (Level 3)
- [ ] Include quality summaries (Level 4)

### Token Budget Quick Guide

| Task Type | Recommended Budget |
|-----------|-------------------|
| Simple fix | 2,000-5,000 tokens |
| New feature | 5,000-10,000 tokens |
| Complex refactor | 10,000-15,000 tokens |
| Full audit | 15,000-25,000 tokens |

### Context Priority by Gate

| Gate | Priority Context |
|------|-----------------|
| Security Scanner | Security standards, audit logs |
| Test Generator | features.json criteria, existing tests |
| Standards Enforcer | CLAUDE.md, team preferences |

---

## Summary

Context optimization is about loading the **right** information, not **all** information:

1. **Quality over quantity** - Relevant context beats comprehensive context
2. **Standards have highest ROI** - 8% of budget, major quality impact
3. **Progressive loading** - Start minimal, expand as needed
4. **Use structured indexes** - features.json guides context loading
5. **Cache stable context** - Don't reload what doesn't change

**Result:** Better quality gate results with fewer tokens, faster execution, and more focused recommendations.
