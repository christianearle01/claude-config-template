---
name: standards-enforcer
description: Applies coding standards from CLAUDE.md and coding-standards.md with dynamic learning that adapts to team preferences over time.
allowed-tools: Read, Grep, Bash
---

# Standards Enforcer Skill

**Purpose:** Apply coding standards intelligently with dynamic learning that adapts to team preferences, reducing false positives and improving suggestion quality over time.

**When to use:**
- User asks for "code review", "check standards", "lint this code"
- During PR review phase
- When Coder Agent completes a feature (quality gate)
- When onboarding to understand team conventions

**Key Innovation:** Dynamic learning - tracks acceptance/rejection rates to adapt confidence and reduce noise.

**Confidence-based responses:** Each suggestion includes learned confidence score based on historical acceptance.

---

## The Standards Problem

### Static Rules Don't Work

**Traditional approach:**
- Define rules in ESLint/Prettier config
- Rules are "mostly followed" (not rigorously enforced)
- One-size-fits-all doesn't match team culture
- Rules become stale as team evolves

**Problems with static rules:**
```
Rule defined: "Avoid nested if statements"
├─ Team A: Loves early returns (95% acceptance)
├─ Team B: Prefers explicit conditionals (20% acceptance)
└─ Same rule, different outcomes

Result: Team B ignores linter, trust erodes, rules stop mattering
```

### Dynamic Learning Solution

**This skill's approach:**
```
Suggestion → Developer Feedback → Model Update
"Avoid nested if"  → Rejected 80%     → Lower confidence
"Add null check"   → Accepted 95%     → Higher confidence
```

**Result:** Suggestions adapt to team preferences
- High-confidence suggestions shown prominently
- Low-confidence suggestions hidden or noted as "optional"
- Team feels understood, compliance increases

---

## Operation 1: Read and Apply Standards

**User Queries:**
- "Review this code against our standards"
- "Apply coding standards to this file"
- "Check if this follows our conventions"
- "What standards violations are in this code?"

### Standards Sources

1. **Project CLAUDE.md** (highest priority)
   - Team-specific conventions
   - Project-specific patterns
   - Exception rules

2. **Global coding-standards.md**
   - Organization-wide standards
   - Language best practices
   - Security requirements

3. **Config files** (.eslintrc, .prettierrc, pyproject.toml)
   - Enforced standards (auto-fixable)
   - Style preferences

4. **Inferred patterns** (lowest priority)
   - Patterns detected in existing code
   - Consistency rules

### Analysis Steps

1. **Load standards:**
   - Read CLAUDE.md conventions section
   - Read coding-standards.md if exists
   - Parse config files

2. **Scan code:**
   - Check against each standard
   - Note violations with line numbers
   - Calculate confidence from learning history

3. **Generate report:**
   - Group by confidence level
   - Provide fix suggestions
   - Include rationale

### Response Template

```markdown
## Standards Review

**File:** src/api/orders.ts
**Standards Applied:** CLAUDE.md + coding-standards.md
**Issues Found:** 3 high-confidence, 2 medium-confidence

---

### High Confidence (95%+) - Should Fix

#### 1. Missing null check before property access
**Line:** 42
**Confidence:** 98%
**Acceptance Rate:** 97% (this team accepts these)

**Issue:**
```typescript
const userName = user.profile.name;  // user.profile could be undefined
```

**Fix:**
```typescript
const userName = user?.profile?.name ?? 'Unknown';
```

**Rationale:** This team accepts null check suggestions 97% of the time. This pattern has prevented 3 runtime errors in the past month.

---

#### 2. Inconsistent error handling pattern
**Line:** 78-85
**Confidence:** 95%
**Acceptance Rate:** 92%

**Issue:**
```typescript
try {
  await processOrder(order);
} catch (e) {
  console.log(e);  // Team standard: use logger, include context
  throw e;
}
```

**Fix:**
```typescript
try {
  await processOrder(order);
} catch (error) {
  logger.error('Order processing failed', { orderId: order.id, error });
  throw new OrderProcessingError(order.id, error);
}
```

**Rationale:** From CLAUDE.md: "All errors must be logged with context and wrapped in domain-specific error types."

---

### Medium Confidence (60-94%) - Consider

#### 3. Function complexity exceeds threshold
**Line:** 102-145
**Confidence:** 68%
**Acceptance Rate:** 65%

**Issue:** Function `calculateOrderTotal` has cyclomatic complexity of 12 (team threshold: 10).

**Suggestion:** Extract tax calculation and discount application into separate functions.

**Note:** This team accepts complexity refactors 65% of the time. Consider if refactoring adds clarity or just moves code around.

---

### Low Confidence (<60%) - Optional/Hidden

*1 suggestion hidden due to low team acceptance (25%)*

Toggle to show: `--show-low-confidence`

---

### Summary

| Confidence | Count | Action |
|------------|-------|--------|
| High (95%+) | 2 | Fix before merge |
| Medium (60-94%) | 1 | Review and decide |
| Low (<60%) | 1 | Hidden (optional) |

**Estimated fix time:** 15 minutes
```

---

## Operation 2: Dynamic Learning

**User Queries:**
- "I accept this suggestion"
- "Reject this suggestion"
- "This rule doesn't apply here"
- "Show learning statistics"

### Learning Loop

```markdown
**Learning Cycle:**

1. **Suggestion Made:**
   - Standard: "Prefer early returns over nested ifs"
   - Initial confidence: 50% (neutral)

2. **Developer Response:**
   - Accept: Applied the suggestion
   - Reject: Dismissed or modified differently
   - Skip: No action (neutral)

3. **Model Update:**
   - Recalculate acceptance rate
   - Adjust confidence score
   - Update suggestion visibility threshold

4. **Future Behavior:**
   - High acceptance → Higher confidence → Show prominently
   - Low acceptance → Lower confidence → Hide or note as optional
```

### Learning Data Structure

```json
// .claude/quality-standards.json
{
  "version": "1.0",
  "lastUpdated": "2025-12-15T14:30:00Z",
  "learningEnabled": true,
  "rules": [
    {
      "id": "early-returns",
      "source": "coding-standards.md",
      "suggestion": "Prefer early returns over nested if statements",
      "category": "readability",
      "initialConfidence": 50,
      "currentConfidence": 25,
      "stats": {
        "timesShown": 15,
        "timesAccepted": 3,
        "timesRejected": 10,
        "timesSkipped": 2,
        "acceptanceRate": 0.23
      },
      "status": "low-confidence",
      "lastApplied": "2025-12-14T09:15:00Z",
      "notes": "Team prefers explicit conditionals for readability"
    },
    {
      "id": "null-checks",
      "source": "CLAUDE.md",
      "suggestion": "Add null/undefined check before property access",
      "category": "reliability",
      "initialConfidence": 75,
      "currentConfidence": 98,
      "stats": {
        "timesShown": 42,
        "timesAccepted": 41,
        "timesRejected": 1,
        "timesSkipped": 0,
        "acceptanceRate": 0.976
      },
      "status": "enforced",
      "lastApplied": "2025-12-15T11:30:00Z",
      "notes": "Team strongly prefers defensive coding"
    },
    {
      "id": "function-complexity",
      "source": "coding-standards.md",
      "suggestion": "Extract complex functions (complexity > 10)",
      "category": "maintainability",
      "initialConfidence": 60,
      "currentConfidence": 65,
      "stats": {
        "timesShown": 20,
        "timesAccepted": 13,
        "timesRejected": 7,
        "timesSkipped": 0,
        "acceptanceRate": 0.65
      },
      "status": "learning",
      "lastApplied": "2025-12-15T10:00:00Z",
      "notes": "Context-dependent - accepted for business logic, rejected for simple helpers"
    }
  ],
  "teamPreferences": {
    "inferred": [
      "Prefers explicit over implicit",
      "Values defensive coding (null checks)",
      "Tolerates moderate complexity in domain logic",
      "Prefers detailed error messages"
    ],
    "lastInferred": "2025-12-15T12:00:00Z"
  }
}
```

### Confidence Calculation

```markdown
**Formula:**

newConfidence = (initialConfidence × 0.3) + (acceptanceRate × 100 × 0.7)

**Adjustments:**
- Minimum samples: 5 (before adjusting from initial)
- Recency weight: Recent decisions weighted 1.5x
- Category bonus: Security rules get +10% floor

**Example:**
- Initial: 50%
- Acceptance: 3/10 (30%)
- Calculation: (50 × 0.3) + (30 × 0.7) = 15 + 21 = 36%
- With recency (recent rejections): 25%
- Status: "low-confidence"
```

### Response Template (Learning Update)

```markdown
## Learning Update

**Rule:** early-returns
**Action:** Rejected
**Previous Confidence:** 28%
**New Confidence:** 25%

---

### Stats Update

| Metric | Before | After |
|--------|--------|-------|
| Times Shown | 14 | 15 |
| Times Accepted | 3 | 3 |
| Times Rejected | 9 | 10 |
| Acceptance Rate | 25% | 23% |
| Confidence | 28% | 25% |

---

### Impact

This rule is now **low-confidence** for your team.

**Future behavior:**
- Will not be shown by default
- Can be seen with `--show-low-confidence` flag
- Will be reconsidered if team preferences change

**Pattern detected:** Your team prefers explicit conditionals over early returns.

---

### Team Preferences (Updated)

Based on 150 decisions across 12 rules:

**Strong preferences (>90% acceptance):**
- Null/undefined checks
- Error logging with context
- Type annotations on public APIs

**Moderate preferences (60-90%):**
- Function complexity limits
- Named exports over default

**Low preferences (<60%):**
- Early returns
- Single-line if statements
- Ternary operators for simple conditions
```

---

## Operation 3: Team Preference Detection

**User Queries:**
- "What are our team's coding preferences?"
- "Show team standards profile"
- "How does our team code?"
- "What patterns does our team prefer?"

### Analysis Steps

1. **Aggregate learning data:**
   - Calculate acceptance rates per category
   - Identify strong preferences (>90%)
   - Identify weak preferences (<60%)

2. **Infer patterns:**
   - Cross-rule correlations
   - Category-level preferences
   - Exception patterns

3. **Generate profile:**
   - Team coding style summary
   - Preference explanations
   - Recommendations

### Response Template

```markdown
## Team Coding Profile

**Team:** my-ecommerce-app
**Based on:** 250 decisions across 18 rules
**Profile Generated:** 2025-12-15

---

### Coding Philosophy

Based on learning data, your team prioritizes:

1. **Reliability over brevity** (confidence: 95%)
   - Strong preference for null checks (98% acceptance)
   - Defensive error handling (94% acceptance)
   - Explicit type annotations (91% acceptance)

2. **Readability over cleverness** (confidence: 88%)
   - Prefers explicit conditionals over early returns (23% early return acceptance)
   - Avoids ternary operators in complex conditions (35% acceptance)
   - Values descriptive variable names (89% acceptance)

3. **Maintainability with pragmatism** (confidence: 75%)
   - Accepts complexity refactors sometimes (65% acceptance)
   - Context-dependent: business logic yes, utilities no
   - Values consistency over perfection

---

### Category Breakdown

| Category | Avg Acceptance | Status |
|----------|---------------|--------|
| Reliability | 95% | Strong standard |
| Security | 92% | Strong standard |
| Readability | 78% | Team preference |
| Maintainability | 65% | Context-dependent |
| Style | 45% | Flexible |

---

### Strong Standards (90%+)

These rules are effectively **required** for your team:

1. **null-checks** (98%): Always check for null/undefined
2. **error-logging** (94%): Log errors with full context
3. **type-annotations** (91%): Annotate public API types
4. **input-validation** (90%): Validate external inputs

---

### Flexible Standards (<60%)

These rules are **suggestions only** for your team:

1. **early-returns** (23%): Team prefers explicit conditionals
2. **single-line-if** (35%): Team prefers braces always
3. **ternary-complex** (40%): Team prefers if/else
4. **default-exports** (55%): Team split on named vs default

---

### Recommendations

Based on your team's profile:

1. **Strengthen:**
   - Add null-checks to pre-commit hook (team already accepts 98%)
   - Make error-logging a required pattern

2. **Remove or relax:**
   - Consider removing early-returns rule (causes friction)
   - Make ternary-complex a warning instead of error

3. **Clarify:**
   - Document when complexity refactors are expected vs optional
   - Create explicit exceptions for utility functions

---

### Comparison to Industry

| Standard | Your Team | Industry Avg |
|----------|-----------|--------------|
| Null checks | 98% | 75% | Above average
| Error handling | 94% | 70% | Above average
| Early returns | 23% | 65% | Below average
| Type safety | 91% | 60% | Above average

**Assessment:** Your team is more conservative/defensive than industry average. This correlates with higher reliability but potentially slower development.
```

---

## Standard Categories

### Category 1: Reliability

**High-value, usually high acceptance**

```markdown
**Rules:**

1. **null-checks**
   - Check for null/undefined before property access
   - Default confidence: 85%
   - Typical acceptance: 90%+

2. **error-handling**
   - Wrap async operations in try/catch
   - Include context in error messages
   - Default confidence: 80%

3. **type-safety**
   - Avoid `any` type in TypeScript
   - Validate external data shapes
   - Default confidence: 75%
```

### Category 2: Security

**Highest priority, floor confidence**

```markdown
**Rules:**

1. **input-validation**
   - Validate all user inputs
   - Sanitize before database/HTML
   - Minimum confidence: 85% (floor)

2. **secret-handling**
   - No hardcoded credentials
   - Use environment variables
   - Minimum confidence: 90% (floor)

3. **auth-checks**
   - Verify permissions before actions
   - Don't trust client-side auth
   - Minimum confidence: 85% (floor)
```

### Category 3: Readability

**Team-dependent, varies widely**

```markdown
**Rules:**

1. **early-returns**
   - Prefer early returns over nested ifs
   - Default confidence: 50%
   - Typical range: 20-80% (team-dependent)

2. **naming-conventions**
   - Descriptive variable names
   - Consistent casing
   - Default confidence: 70%

3. **comment-quality**
   - Comments explain why, not what
   - No commented-out code
   - Default confidence: 60%
```

### Category 4: Maintainability

**Context-dependent**

```markdown
**Rules:**

1. **function-complexity**
   - Extract functions over threshold
   - Default confidence: 60%
   - Context: Apply to business logic, not utilities

2. **single-responsibility**
   - Functions do one thing
   - Default confidence: 55%
   - Context: More important in modules, less in scripts

3. **dry-principle**
   - Don't repeat yourself (3+ times)
   - Default confidence: 50%
   - Context: Premature abstraction is worse
```

---

## Edge Cases & Troubleshooting

### Edge Case 1: New Team (No Learning Data)

**Scenario:** Fresh project, no historical decisions

**Response:**
```markdown
**Cold Start Mode**

**Status:** No learning data available (new team/project)

**Approach:**
1. Using default confidence scores
2. Showing all suggestions (no filtering)
3. Learning will begin after 5 decisions per rule

**Recommendations:**
1. Start with high-priority rules (security, reliability)
2. Explicitly accept/reject suggestions to train faster
3. Review team preferences after ~50 decisions

**Initial profile:**
- All rules at default confidence
- No team preferences inferred
- Industry-average assumptions applied
```

### Edge Case 2: Conflicting Standards

**Scenario:** CLAUDE.md conflicts with coding-standards.md

**Response:**
```markdown
**Standards Conflict Detected**

**Conflict:**
- CLAUDE.md: "Use default exports for components"
- coding-standards.md: "Always use named exports"

**Priority Resolution:** CLAUDE.md > coding-standards.md

**Applied rule:** Default exports for components

**Recommendation:**
1. Update coding-standards.md to match CLAUDE.md
2. Or add exception in coding-standards.md
3. Document the decision in CLAUDE.md

**Note:** Consistent standards prevent team confusion.
```

### Edge Case 3: Context-Dependent Rule

**Scenario:** Rule should apply sometimes, not always

**Response:**
```markdown
**Context-Dependent Rule Detected**

**Rule:** function-complexity (extract if complexity > 10)

**Pattern observed:**
- Accepted 90% for business logic
- Accepted 30% for utility functions

**Learning:**
```json
{
  "id": "function-complexity",
  "contexts": [
    {
      "pattern": "src/services/**",
      "acceptanceRate": 0.90,
      "confidence": 92
    },
    {
      "pattern": "src/utils/**",
      "acceptanceRate": 0.30,
      "confidence": 35
    }
  ]
}
```

**Future behavior:**
- High confidence in services/ directory
- Low confidence in utils/ directory
- Context shown in suggestion
```

### Edge Case 4: Preference Drift

**Scenario:** Team preferences change over time

**Response:**
```markdown
**Preference Drift Detected**

**Rule:** early-returns

**Historical:**
- Months 1-3: 20% acceptance (team rejected)
- Months 4-6: 55% acceptance (increasing)
- Month 7: 75% acceptance (team preference changed)

**Analysis:**
Team preferences for early returns have shifted significantly.

**Options:**
1. **Reset learning:** Clear historical data, restart from 50%
2. **Recency bias:** Weight recent decisions more heavily (default)
3. **Investigate:** New team members? Code review feedback?

**Applied:** Recency bias (recent decisions weighted 2x)

**New confidence:** 68% (up from 35%)

**Note:** This rule will be shown more frequently now.
```

---

## Integration with Other Skills

### Integration with Security Scanner

```markdown
Security Scanner: "Found potential SQL injection"

Standards Enforcer: "Checking team standards for SQL handling..."

Team standard (from CLAUDE.md):
- "All database queries must use parameterized statements"
- Team acceptance: 100%

Standards Enforcer enhancement:
- Elevate from "suggestion" to "requirement"
- Add team-specific context: "This team has never accepted raw SQL"
- Include team's preferred pattern
```

### Integration with Test Generator

```markdown
Test Generator: "Generated tests for feat-007"

Standards Enforcer: "Applying test standards..."

Test standards (from coding-standards.md):
- "Tests must follow Arrange-Act-Assert pattern"
- "Test names must describe expected behavior"
- Team acceptance: 88%

Review findings:
- 2/6 tests don't follow AAA pattern
- 1/6 test has unclear name

Suggestion: "Would you like me to refactor tests to match team standards?"
```

### Integration with Quality Orchestrator

```markdown
Quality Orchestrator: "Running all quality gates..."

Standards Enforcer gate:
- High-confidence violations: 2
- Medium-confidence: 1
- Low-confidence: 3 (hidden)

Gate result: "Conditional pass"
- Must fix: 2 high-confidence issues
- Should consider: 1 medium-confidence issue
- Optional: 3 low-confidence (team typically rejects these)

Quality Orchestrator: "Standards gate: conditional pass (2 issues to address)"
```

---

## Configuration

### Enabling/Disabling Learning

```json
// .claude/quality-standards.json
{
  "learningEnabled": true,
  "learningSettings": {
    "minimumSamples": 5,
    "recencyWeight": 1.5,
    "securityFloor": 85,
    "autoHideThreshold": 40
  }
}
```

### Overriding Confidence

```markdown
**Manual override in CLAUDE.md:**

## Coding Standards Overrides

These standards are required regardless of learning:

- `null-checks`: Always required (confidence: 100%)
- `error-logging`: Always required (confidence: 100%)

These standards are disabled for this project:

- `early-returns`: Disabled (team decision)
- `single-line-if`: Disabled (style preference)
```

### Importing/Exporting Preferences

```markdown
**Export team preferences:**

File: team-preferences-export.json
- All learned confidence scores
- Team preference profile
- Can be shared with new team members/projects

**Import to new project:**
1. Copy team-preferences-export.json
2. Rename to .claude/quality-standards.json
3. Team preferences pre-loaded

**Use case:** Onboarding new developers with team's coding culture
```

---

## Skill Metadata

**Token Efficiency:**
- Standards review: ~500 tokens (vs ~2,000 manual review)
- Learning update: ~100 tokens per decision
- Team profile: ~400 tokens
- **Average savings: 60-75%**

**Use Cases:**
1. **Code review:** Apply standards with team context
2. **Onboarding:** Understand team conventions quickly
3. **Quality gate:** Enforce standards before merge
4. **Team alignment:** Identify and document preferences

**Complementary Skills:**
- **Security Scanner:** Elevate security standards
- **Test Generator:** Apply test standards
- **Quality Orchestrator:** Include in quality gates

**Confidence Philosophy:**
- **95%+:** Effectively required (team always accepts)
- **75-94%:** Strong suggestion (team usually accepts)
- **50-74%:** Consider carefully (team split)
- **25-49%:** Optional/hidden (team often rejects)
- **<25%:** Disabled (team never accepts)

---

## Quick Reference

### Common Commands

**Apply standards:**
```
"Review this code against our standards"
```

**Show team preferences:**
```
"What are our team's coding preferences?"
```

**Accept/reject suggestions:**
```
"Accept null-checks suggestion"
"Reject early-returns suggestion"
```

**Reset learning:**
```
"Reset learning for early-returns rule"
```

### Confidence Quick Guide

| Confidence | Status | Display |
|------------|--------|---------|
| 95%+ | Required | Always shown, blocks merge |
| 75-94% | Strong | Always shown |
| 50-74% | Consider | Shown with context |
| 25-49% | Optional | Hidden by default |
| <25% | Disabled | Never shown |
