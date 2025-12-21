# Spec-Driven Development

**Plan before you code - See the architecture before generating implementation**

---

## Why Spec-First?

**The Problem (Jake Nations - Netflix):**
> "AI makes code faster than humans can learn"

When AI generates code directly from user intent:
- ❌ You ship code you don't understand
- ❌ AI preserves tech debt as "patterns"
- ❌ Rework is common (long conversations = architecture smell)
- ❌ Essential complexity mixed with accidental complexity

**The Solution:**
Research → **Planning (Spec)** → Implementation

**Spec = "Paint by numbers" plan visible to human BEFORE code generation**

---

## What is a Spec?

A **project-spec.yaml** file that documents:

1. **Essential Complexity** - What MUST exist (business requirements)
2. **Accidental Complexity** - What should be REMOVED (tech debt)
3. **Architecture** - Patterns and components
4. **Implementation Sequence** - Step-by-step phases with validation
5. **Validation Checkpoints** - How to verify success

**Human-readable YAML** - You review and approve BEFORE any code is written.

---

## When to Use Spec-Generator

### ✅ Use Spec-Generator When:

**Complex refactors:**
- Changes affect 3+ files
- Architectural modifications
- Tech debt cleanup

**New features:**
- Feature requires new components
- Multiple integration points
- Unclear requirements (need to think through design)

**High-stakes decisions:**
- Authentication/authorization changes
- Database schema changes
- External API integrations

**Example:** "Refactor authentication from sessions to JWT"
- Spec identifies: Essential (login, tokens, validation) vs Accidental (session storage, Redis calls)
- Implementation sequence: Interfaces → Tests → Implementation → Cleanup

### ❌ Skip Spec-Generator When:

**Simple changes:**
- Bug fixes (1-2 line changes)
- Typo corrections
- Documentation updates
- Trivial feature additions (<10 lines)

**User provides detailed spec:**
- Requirements are crystal clear
- Implementation is obvious
- No architectural decisions needed

---

## How to Invoke Spec-Generator

### Method 1: Direct Invocation

```
Ask Claude Code:

"Use the spec-generator agent to plan a refactor of our authentication
system from session cookies to JWT tokens."
```

Claude will:
1. Analyze your codebase
2. Identify essential vs accidental complexity
3. Generate `project-spec.yaml`
4. Ask you to review and approve

### Method 2: Via Initializer Agent (Automatic)

```
Ask Claude Code:

"I want to add real-time notifications for order updates"
```

Initializer agent will:
1. Automatically call spec-generator
2. Generate spec
3. Wait for your approval
4. Create `features.json` from approved spec

---

## How to Review a Spec

When Claude presents a `project-spec.yaml`, ask yourself:

### 1. Essential Complexity Check
**Question:** "Does this capture the core business requirements?"

**Look for:**
- ✅ User needs clearly stated
- ✅ Business logic requirements
- ✅ Domain constraints (regulations, integrations)
- ❌ Missing requirements

**Example (good):**
```yaml
essential_complexity:
  requirements:
    - User login with email/password
    - Token expiry (15 min access, 7 day refresh)
    - Password hashing (bcrypt, 12 rounds)
```

### 2. Accidental Complexity Check
**Question:** "Is this code actually tech debt, or is there a reason it exists?"

**Look for:**
- ✅ Duplicate code flagged
- ✅ Dead code identified
- ✅ High confidence scores (>0.8)
- ⚠️ Medium confidence items (review carefully)
- ❌ False positives (code is intentional, not debt)

**Example (good):**
```yaml
accidental_complexity_to_remove:
  - pattern: "Session cookie logic"
    locations: ["src/auth/session-manager.ts:45-180"]
    confidence: 0.95
    action: "Delete after JWT verified"
```

**Example (review needed):**
```yaml
accidental_complexity_to_remove:
  - pattern: "Defensive null checks"
    confidence: 0.6  # ⚠️ LOW - might be intentional
```

### 3. Implementation Sequence Check
**Question:** "Can I follow this step-by-step without getting stuck?"

**Look for:**
- ✅ Concrete tasks (not vague)
- ✅ Phases build on each other
- ✅ Validation after each phase
- ❌ Missing validation checkpoints

**Example (good):**
```yaml
implementation_sequence:
  phase_1:
    tasks:
      - Create IJWTService interface
      - Define JWT payload type
    validation:
      - [ ] All interfaces compile
      - [ ] No 'any' types

  phase_2:
    tasks:
      - Write JWTService unit tests
    validation:
      - [ ] All tests fail (RED phase)
```

### 4. Risks and Rollback Check
**Question:** "What could go wrong, and can we recover?"

**Look for:**
- ✅ Risks identified
- ✅ Mitigation strategies
- ✅ Rollback plan
- ✅ Gradual rollout strategy

**Example (good):**
```yaml
risks:
  - "Existing mobile apps may expect cookies"

migration_strategy:
  - "Feature flag: JWT auth alongside sessions for 1 week"
  - "Rollback plan: Re-enable sessions if critical issues"
```

---

## Example Specs

### Example 1: Authentication Refactor
**File:** `examples/specs/user-auth-refactor.yaml`

**Scenario:** Replace session cookies with JWT tokens

**Key sections:**
- **Essential complexity:** Login, token generation, validation (JWT standard)
- **Accidental complexity:** Session storage (Redis), cookie parsing legacy code
- **Implementation:** 4 phases (interfaces → tests → implementation → cleanup)
- **Validation:** Security checklist (secrets in env, HTTPS, token expiry)

**Confidence:** 88% (proven pattern, low risk)

**View full spec:** [examples/specs/user-auth-refactor.yaml](../../examples/specs/user-auth-refactor.yaml)

---

### Example 2: API Performance Optimization
**File:** `examples/specs/api-optimization.yaml`

**Scenario:** Fix N+1 query problem causing 2,500ms response time

**Key sections:**
- **Essential complexity:** Paginated product listing, filtering, sorting
- **Accidental complexity:** N+1 queries (categories, ratings), missing indexes
- **Implementation:** 5 phases (measure → fix queries → add indexes → add caching → validate)
- **Validation:** Performance metrics (response time, query count, load test)

**Expected outcome:** 2,500ms → <200ms (92% reduction)

**View full spec:** [examples/specs/api-optimization.yaml](../../examples/specs/api-optimization.yaml)

---

### Example 3: New Feature Addition
**File:** `examples/specs/feature-addition.yaml`

**Scenario:** Add real-time order notifications (WebSocket + Push API)

**Key sections:**
- **Essential complexity:** Real-time notifications, browser push, email fallback
- **Accidental complexity:** Polling-based status check (replace with WebSocket)
- **Implementation:** 5 phases (interfaces → tests → backend → frontend → integration)
- **Validation:** Browser compatibility (95%+ coverage), load test (1000 concurrent)

**Confidence:** 78% (real-time features have more complexity)

**View full spec:** [examples/specs/feature-addition.yaml](../../examples/specs/feature-addition.yaml)

---

## Integration with Workflow

### Before Spec-Generator: Manual Exploration
```
User: "Optimize the slow product listing API"

Claude (old way):
1. Reads controller file
2. Reads repository file
3. Reads database schema
4. Identifies N+1 queries
5. Writes fix directly ❌
6. User discovers tech debt preserved
7. Long conversation to refine...
```

**Problem:** No planning phase, rework common

### After Spec-Generator: Plan First
```
User: "Optimize the slow product listing API"

Claude (new way):
1. Calls spec-generator agent
2. Spec analyzes codebase
3. Generates project-spec.yaml
4. User reviews and approves ✅
5. Coder agent implements exactly to spec
6. Quality reviewer validates against spec
```

**Benefit:** Human approval before code, clear architecture, less rework

---

## Spec-Driven TDD Workflow

**Combining spec-first with test-driven development:**

```
1. User intent
   ↓
2. Spec-Generator creates project-spec.yaml
   ↓
3. Human reviews and approves
   ↓
4. Coder writes tests (RED phase)
   ↓
5. Coder implements to make tests pass (GREEN phase)
   ↓
6. Coder refactors based on spec (REFACTOR phase)
   ↓
7. Quality Reviewer validates against spec
   ↓
8. User verifies outcome
```

**Key insight:** Spec + TDD = High confidence implementation

---

## Customizing Specs

### Adding Custom Sections

You can extend the YAML format:

```yaml
# Standard sections
essential_complexity: ...
accidental_complexity_to_remove: ...
architecture: ...
implementation_sequence: ...
validation_checkpoints: ...

# Custom sections (add as needed)
accessibility_requirements:
  - WCAG 2.1 Level AA compliance
  - Keyboard navigation support
  - Screen reader compatibility

internationalization:
  - Support English, Spanish, French
  - RTL layout for Arabic
  - Currency formatting per locale

compliance:
  - GDPR data retention (30 days)
  - HIPAA audit logging
  - SOC 2 encryption requirements
```

### Adjusting Confidence Thresholds

**Default thresholds:**
- 🟢 High: 0.9+ (definitely tech debt, safe to remove)
- 🟡 Medium: 0.6-0.9 (likely tech debt, needs review)
- 🔴 Low: <0.6 (uncertain, human must decide)

**Adjust based on your risk tolerance:**

```yaml
# Conservative team (financial systems)
confidence_thresholds:
  high: 0.95
  medium: 0.85
  low: <0.85

# Aggressive team (MVP startup)
confidence_thresholds:
  high: 0.8
  medium: 0.6
  low: <0.6
```

---

## Common Mistakes

### 1. Skipping Spec for "Simple" Changes
**Mistake:** "This is just a small refactor, I don't need a spec"

**Result:** Small refactor becomes large refactor, tech debt preserved

**Fix:** Use spec-generator for ANY refactor affecting 3+ files

### 2. Not Reviewing Accidental Complexity Carefully
**Mistake:** Trusting all confidence scores blindly

**Result:** Deleting code that was intentional, not tech debt

**Fix:** Review items with confidence <0.8, ask "why does this code exist?"

### 3. Vague Implementation Sequence
**Mistake:** Spec says "Implement the feature" with no breakdown

**Result:** Coder agent makes architectural choices you don't want

**Fix:** Break into concrete phases: interfaces → tests → implementation

### 4. Missing Rollback Plan
**Mistake:** Spec assumes everything will work perfectly

**Result:** Production issues with no recovery plan

**Fix:** Always include rollback plan, especially for database changes

### 5. Not Testing the Spec
**Mistake:** Spec looks good on paper, but unvalidated

**Result:** Implementation reveals missing requirements

**Fix:** Walk through spec mentally, "can I actually implement this?"

---

## Jake Nations Test for Specs

**Before approving a spec, ask:**

1. **Does this make me faster, or smarter?**
   - ✅ Smarter: I understand the plan before code generation
   - ❌ Faster: Spec is auto-approved, I don't learn architecture

2. **Does this encourage "easy" or "simple"?**
   - ✅ Simple: Separates essential from accidental (one-fold clarity)
   - ❌ Easy: Skips hard thinking about tech debt

3. **Will I understand the code this generates?**
   - ✅ Yes: Spec shows reasoning, I can explain to teammates
   - ❌ No: Spec is too technical, I'm just copying AI output

4. **Are we preserving complexity or creating clarity?**
   - ✅ Clarity: Accidental complexity explicitly removed
   - ❌ Preserving: No tech debt analysis, AI treats all code as "patterns"

---

## FAQ

**Q: How long does spec generation take?**
A: 5-15 minutes for most features. Worth it to avoid hours of rework.

**Q: Can I edit the spec after approval?**
A: Yes! Specs are living documents. Update as you learn during implementation.

**Q: What if the spec is wrong?**
A: Better to catch it during review than during implementation. Iterate on spec first.

**Q: Do I need a spec for every task?**
A: No. Simple bug fixes and documentation updates don't need specs. Use for complex changes (3+ files).

**Q: Can I use spec-generator for non-code tasks?**
A: Yes! Use for documentation refactors, workflow changes, process improvements.

**Q: How do I know if accidental complexity is real tech debt?**
A: Check confidence score. If <0.8, review carefully. Ask "why does this code exist?"

---

## Resources

**Learn more:**
- [Spec-Generator Agent](../../.claude/agents/spec-generator.md) - Agent documentation
- [Example Specs](../../examples/specs/) - 3 complete examples
- [Jake Nations Talk](https://www.youtube.com/watch?v=eIoohUmYpGI) - "The Infinite Software Crisis"
- [Quality Workflows](../../docs/00-start-here/11_quality-workflows.md) - Integration with quality agents

**Related concepts:**
- [Understanding Over Speed](../../CHANGELOG.md#4220) - v4.22.0 philosophy
- [Proactive Paradigm](../../docs/00-start-here/10_proactive-paradigm.md) - Proactive vs reactive agents
- [Domain Memory Architecture](../../.claude/agents/initializer.md) - Integration with features.json

---

## Summary

**Spec-Driven Development Core Principles:**

1. **Plan before code** - See architecture before implementation
2. **Essential vs accidental** - Separate business logic from tech debt
3. **Human approval** - Review spec, not generated code
4. **Validation checkpoints** - Catch regressions early
5. **Understanding over speed** - Learn the plan, don't just ship code

**The outcome:**
- ✅ Less rework (plan catches issues early)
- ✅ Better architecture (intentional design, not emergent)
- ✅ Tech debt removal (explicitly identified and deleted)
- ✅ Understanding (you know what the code does and why)

**Best practice:**
> Use spec-generator for any change affecting 3+ files. Review spec carefully. Approve plan before generating code.

---

**Version:** v4.22.0 (2025-12-21)
**Philosophy:** Research → Planning → Implementation (Jake Nations - Netflix)
