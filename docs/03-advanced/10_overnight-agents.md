# Overnight Agents (24/7 Development)

**Priority:** 💡 Nice-to-have (Expert users only, Month 6+, Non-critical projects only)
**Time:** 3-6 months to master safely
**Benefit:** 8 hours of development while you sleep
**Risk:** 🔴 HIGH - Security, cost, quality concerns

---

## 🚨 CRITICAL WARNINGS: Read This Entire Section First

### This is the MOST ADVANCED and RISKIEST technique in this template.

**Boris Cherny (Claude Code creator) uses overnight agents, but with:**
- 4+ years AI development experience
- Deep understanding of AI limitations
- Trusted codebases only
- Rigorous morning review protocol
- $200-400/month budget

**Do NOT attempt this unless you meet ALL prerequisites below.**

---

## ⛔ Who Should ABSOLUTELY NOT Use This

**NEVER use overnight agents if ANY of these apply:**

❌ **Financial/Healthcare/Security-critical systems**
- Risk: Undetected security vulnerabilities
- Consequence: Data breach, compliance violation, legal liability

❌ **Production systems without staging**
- Risk: Direct production deployment
- Consequence: Downtime, data loss, customer impact

❌ **Less than 12 months Claude Code experience**
- Risk: Cannot identify AI hallucinations
- Consequence: Accept bad code as correct

❌ **Cannot budget $60-200 per overnight session**
- Risk: Cost spiral
- Consequence: Unexpected bills, budget overrun

❌ **Teams without code review process**
- Risk: Bad code merged unchecked
- Consequence: Technical debt, bugs in production

❌ **Codebases you don't deeply understand**
- Risk: Cannot review effectively
- Consequence: Subtle bugs undetected

❌ **Tight deadlines with no room for rework**
- Risk: Overnight work may be wrong direction
- Consequence: Wasted 8 hours, miss deadline

---

## ✅ Prerequisites (Must Meet ALL)

### Technical Prerequisites

- [ ] **18+ months with Claude Code** (not 12)
- [ ] **Master high-concurrency workflows** (6-10 terminals comfortable)
- [ ] **Deep codebase knowledge** (can review any file)
- [ ] **Staging environment** (never test in production)
- [ ] **Rollback capability** (can undo all changes quickly)
- [ ] **Comprehensive test suite** (catches regressions)

### Financial Prerequisites

- [ ] **$60-200 budget per overnight session**
- [ ] **Billing alerts set** ($50, $100, $200 thresholds)
- [ ] **Usage tracking enabled** (monitor costs daily)
- [ ] **Approval for AI costs** (if corporate card)

### Process Prerequisites

- [ ] **Mandatory code review** (all overnight code reviewed)
- [ ] **Security review protocol** (check for vulnerabilities)
- [ ] **Test verification** (all tests pass)
- [ ] **Git branches** (never commit to main)
- [ ] **Morning review time** (block 1-2 hours)

### Cognitive Prerequisites

- [ ] **Can identify hallucinations** (proven track record)
- [ ] **Comfortable rejecting 50%+ of overnight work** (if needed)
- [ ] **No pressure to use overnight output** (sunk cost fallacy)
- [ ] **Morning clarity** (not fatigued when reviewing)

**If ANY prerequisite not met → Stop. Do not use overnight agents.**

---

## What Are Overnight Agents?

**Overnight agents** are Claude Code sessions you start before bed, assigning them tasks to work on while you sleep. You wake up to completed (or attempted) work ready for review.

### The Promise

```
Evening (10 PM):  Start 5-10 agents with tasks
Night (10 PM-6 AM): Agents work autonomously (8 hours)
Morning (6 AM): Wake up to review-ready code
```

**Potential benefit:** 8 hours of development time without working

---

### The Reality

```
Evening (10 PM):  Start 5-10 agents with tasks
Night (10 PM-6 AM): Agents work, some hallucinate, some stall, cost accumulates
Morning (6 AM): Wake up to:
  - 3 agents produced good code ✅
  - 2 agents went wrong direction ❌
  - 2 agents hit errors and stopped ⚠️
  - 3 agents waiting for clarification ⏸️
  - Cost: $120 (some wasted on wrong directions)

Morning review: 2 hours to:
  - Review good code (keep)
  - Discard bad code (wasted cost)
  - Debug stuck agents
  - Clarify waiting agents
  - Security scan all changes
```

**Actual benefit:** 3 agents' work (maybe 4-6 hours equivalent), after 2 hours review

**Net gain:** 2-4 hours (if lucky), -2 hours (if unlucky)

---

## Cost Analysis

### Per-Night Cost Breakdown

**Scenario 1: 5 Agents, 8 Hours**

| Agent | Task | Tokens Used | Cost | Outcome |
|-------|------|-------------|------|---------|
| 1 | Feature A | 50K | $15 | ✅ Success |
| 2 | Feature B | 40K | $12 | ✅ Success |
| 3 | Tests | 30K | $9 | ✅ Success |
| 4 | Refactor | 60K | $18 | ❌ Wrong direction |
| 5 | Docs | 20K | $6 | ⏸️ Waiting |
| **Total** | - | **200K** | **$60** | **3/5 useful** |

**Effective cost per useful agent:** $20 ($60 / 3)

---

**Scenario 2: 10 Agents, 8 Hours (Ambitious)**

| Agent | Task | Tokens Used | Cost | Outcome |
|-------|------|-------------|------|---------|
| 1-3 | Features | 120K | $36 | ✅ 2 success, 1 fail |
| 4-6 | Tests | 90K | $27 | ✅ All success |
| 7-8 | Refactor | 100K | $30 | ❌ Both wrong |
| 9-10 | Docs | 40K | $12 | ⏸️ Both waiting |
| **Total** | - | **350K** | **$105** | **5/10 useful** |

**Effective cost per useful agent:** $21 ($105 / 5)

**Wasted cost:** $45 (on wrong directions + waiting)

---

### Cost Optimization Strategies

**1. Use cheaper models for agents**
- Sonnet for implementation ($15/M tokens)
- Haiku for routine tasks ($5/M tokens - 66% cheaper)
- Opus only for architecture

**2. Set token limits per agent**
```markdown
# In agent instructions
Token budget: 50K tokens max
If approaching limit, summarize progress and pause.
```

**3. Morning check-in (mid-night)**
- Wake at 2 AM
- Quick 10-min check: Are agents on track?
- Stop wrong directions early
- Save $20-40 in wasted tokens

**4. Start with 3 agents, not 10**
- Fewer agents = less waste
- Prove success before scaling

---

## Setup Instructions

### Step 1: Choose Appropriate Tasks

**✅ Good overnight tasks:**
- Well-defined features (clear requirements)
- Independent work (no dependencies between agents)
- Non-critical paths (errors won't break system)
- Mechanical refactoring (rename, restructure)
- Test writing (for completed features)
- Documentation updates

**❌ Bad overnight tasks:**
- Ambiguous requirements ("improve performance")
- Security-sensitive code (auth, encryption)
- Complex architecture decisions
- Tasks requiring frequent clarification
- Production deployments
- Database migrations

---

### Step 2: Prepare Agent Instructions

**Template for each agent:**

```markdown
# Overnight Agent [N] - [Task Name]

**Task:** [Very specific, unambiguous description]

**Context:**
- Codebase: [Brief overview]
- Related files: [List files to read]
- Constraints: [Any limitations]

**Acceptance Criteria:**
1. [Specific criterion 1]
2. [Specific criterion 2]
3. [Specific criterion 3]

**Token Budget:** 50K tokens

**What to do if stuck:**
1. Document the blocker clearly
2. Pause and wait for morning review
3. DO NOT guess or hallucinate

**Security checklist:**
- [ ] No hardcoded secrets
- [ ] All inputs validated
- [ ] No SQL injection risks
- [ ] No XSS vulnerabilities

**Testing requirements:**
- [ ] Unit tests written
- [ ] Tests passing
- [ ] Coverage ≥ 80%

**Completion signal:**
When done, add this to MORNING_REVIEW.md:
```
Agent [N] - [Task Name]: ✅ Complete
Files changed: [list]
Tests: [pass/fail count]
Ready for review: Yes/No
Blockers: [none or list]
```
```

---

### Step 3: Launch Agents (claude.ai, not CLI)

**Important:** Use claude.ai (web) for overnight agents, NOT CLI.

**Why:**
- claude.ai projects persist (survive browser close)
- CLI sessions die when terminal closes
- Web UI shows all agent states in morning

**Launch process:**

```
1. Open claude.ai
2. Create project: "Overnight-2026-01-13"
3. Upload agent instructions (5-10 separate conversations)
4. Start each agent:
   "Execute the instructions in [uploaded-file].md"
5. Verify each started working (check first response)
6. Close browser (agents keep working)
7. Go to sleep
```

---

### Step 4: Morning Review Protocol (CRITICAL)

**Block 1-2 hours for thorough review. Do NOT skip this.**

#### Review Checklist (Each Agent)

**Step 1: Read completion status**
```markdown
Check MORNING_REVIEW.md:
- What did agent claim to do?
- Did it complete or hit blockers?
- Any warnings/errors?
```

**Step 2: Security review (MOST IMPORTANT)**
```bash
# Search for common vulnerabilities
rg "process\.env\." --type ts  # Hardcoded env vars?
rg "eval\(" --type js          # Code execution?
rg "password|secret|key" --type py  # Sensitive data?
rg "\$\{.*\}" --type sql       # SQL injection?

# Review all changes for security
git diff main..branch | grep -i "password\|secret\|token\|auth"
```

**Step 3: Code quality review**
```bash
# Run linter
npm run lint

# Run tests
npm test

# Check coverage
npm run coverage

# Review test quality
# Are tests meaningful or just boilerplate?
```

**Step 4: Logic review**
```markdown
For each changed file:
1. Read the code (don't just trust tests passed)
2. Check edge cases (null, empty, invalid input)
3. Verify business logic correct
4. Look for hallucinations (AI invented APIs?)
```

**Step 5: Accept or reject decision**

**Accept if ALL true:**
- ✅ No security vulnerabilities
- ✅ Tests pass and are meaningful
- ✅ Code quality good (linter happy)
- ✅ Logic correct (no hallucinations)
- ✅ Meets acceptance criteria

**Reject if ANY true:**
- ❌ Security concerns (even minor)
- ❌ Tests fail or are superficial
- ❌ Code quality poor
- ❌ Logic wrong or hallucinated
- ❌ Doesn't meet criteria

**When in doubt → Reject. Sunk cost fallacy is real.**

---

## Risk Management

### Risk 1: Security Vulnerabilities Introduced

**Mitigation:**
1. Never use overnight agents on security-critical code
2. Morning security scan (automated + manual)
3. Staging environment testing before production
4. Peer review (another human checks your review)

**Example vulnerability:**
```python
# Agent might write this (SQL injection risk)
query = f"SELECT * FROM users WHERE id = {user_id}"

# Should be (parameterized)
query = "SELECT * FROM users WHERE id = %s"
cursor.execute(query, (user_id,))
```

---

### Risk 2: Hallucinations (AI Invents APIs)

**Mitigation:**
1. Check all API calls against actual documentation
2. Run integration tests (not just unit tests)
3. Don't trust "this looks right"

**Example hallucination:**
```javascript
// Agent invents API that doesn't exist
import { validateEmail } from 'email-validator';  // Real package
const isValid = validateEmail.checkDomain(email); // HALLUCINATION - method doesn't exist

// Actual API
import { validate } from 'email-validator';
const isValid = validate(email);  // Correct
```

---

### Risk 3: Cost Spiral

**Mitigation:**
1. Set token limits per agent (50K max)
2. Billing alerts ($50, $100, $200)
3. Mid-night check-in (2 AM, quick 10 min)
4. Start with 3 agents, not 10

**Cost spiral scenario:**
```
Agent gets stuck in loop:
- Tries approach A (10K tokens) → fails
- Tries approach B (10K tokens) → fails
- Tries approach C (10K tokens) → fails
- Repeats with variations (100K tokens) → stops at limit
Cost: $30 wasted on stuck agent
```

---

### Risk 4: Technical Debt Accumulation

**Mitigation:**
1. Reject low-quality code (even if tests pass)
2. Morning refactor pass (clean up accepted code)
3. Don't accept "good enough" just because it's overnight work
4. Track technical debt metrics

**Example technical debt:**
```javascript
// Agent might write overly complex code
function calculateTotal(items) {
  return items.reduce((acc, item) => {
    if (item.discount) {
      if (item.discount.type === 'percentage') {
        return acc + (item.price - (item.price * item.discount.value / 100));
      } else if (item.discount.type === 'fixed') {
        return acc + (item.price - item.discount.value);
      }
    }
    return acc + item.price;
  }, 0);
}

// Should be simplified
function calculateTotal(items) {
  return items.reduce((acc, item) => acc + calculateItemPrice(item), 0);
}

function calculateItemPrice(item) {
  if (!item.discount) return item.price;
  if (item.discount.type === 'percentage') {
    return item.price * (1 - item.discount.value / 100);
  }
  return item.price - item.discount.value;
}
```

---

## When to Stop Using Overnight Agents

**Stop immediately if:**

❌ **Security incident occurred**
- Overnight agent introduced vulnerability
- Result: Data breach, compliance violation

❌ **Quality degradation**
- Accepting too much low-quality code
- Technical debt accumulating

❌ **Cost exceeds benefit**
- $200/night but only 2 hours of useful work
- Not sustainable

❌ **Mental health impact**
- Anxious about overnight agents
- Waking up dreading review
- Feeling pressured to use output

❌ **Team pushback**
- Code reviews rejecting overnight code
- Team doesn't trust AI-generated code

❌ **Regulatory concerns**
- Compliance requires human-only development
- Industry standards violated

---

## Success Metrics

### Week 1 (3 agents per night)

- ✅ 2/3 agents produce usable code
- ✅ Morning review < 1 hour
- ✅ No security issues found
- ✅ Cost < $60/night

---

### Month 1 (5 agents per night)

- ✅ 3-4/5 agents produce usable code
- ✅ Morning review 1-1.5 hours
- ✅ Security protocol catching issues
- ✅ Net gain: 4-6 hours of work per night

---

### Month 3+ (Expert level)

- ✅ Boris Cherny level: 5-10 agents, high success rate
- ✅ Morning review < 1 hour (faster at spotting issues)
- ✅ Cost-effective ($20/useful agent)
- ✅ Net gain: 6-8 hours of work per night
- ✅ Zero security incidents

---

## Alternatives to Overnight Agents

**Before committing to overnight agents, consider:**

### Option 1: Early Morning Session

**Instead of:** Overnight agents (10 PM - 6 AM)
**Try:** Early start (6 AM - 8 AM, high-focus session)

**Benefit:**
- Human oversight (catch errors immediately)
- No wasted tokens on wrong directions
- Same 2 hours of work, but higher quality

---

### Option 2: Lunch Break Session

**Instead of:** Overnight agents (risky, unmonitored)
**Try:** Focused lunch session (12 PM - 1 PM)

**Benefit:**
- Fresh mind (not fatigued)
- Immediate feedback
- Lower risk

---

### Option 3: Weekend Deep Work

**Instead of:** 5 overnight sessions (Mon-Fri)
**Try:** 1 deep work session Saturday (4 hours focused)

**Benefit:**
- No interruptions
- Can handle complex tasks
- Same total time, higher quality

---

## Related Guides

- **High-Concurrency Workflows:** `docs/03-advanced/09_high-concurrency-workflows.md`
- **Parallel Terminals:** `docs/02-optimization/06_parallel-terminals.md`
- **Model Selection:** `docs/02-optimization/01_model-selection-strategy.md`
- **/verify Command:** `.claude/commands/verify.md` (use in morning review)

---

## Summary

**Key Takeaways:**

🚨 **Overnight agents = HIGHEST RISK technique in this template**

⛔ **Never use on:** Financial, healthcare, security-critical systems

✅ **Prerequisites:** 18+ months experience, $60-200/night budget, trusted codebase

✅ **Morning review is MANDATORY:** 1-2 hours, security-first approach

⚠️ **Reject liberally:** Don't accept low-quality code due to sunk cost fallacy

✅ **Alternatives exist:** Early morning, lunch break, weekend deep work

**Final Warning:**

Boris Cherny uses overnight agents successfully because:
- 4+ years AI development experience
- Deep understanding of AI capabilities and limitations
- Rigorous review protocols
- Trusted codebases only
- Acceptable risk tolerance

**Most developers should NOT use overnight agents.**

If you're reading this and thinking "I want to try overnight agents":
- **Stop**
- Verify ALL prerequisites (especially 18+ months experience)
- Start with 1 agent, not 5
- Use on side project first (never production)
- Be ready to stop immediately if issues arise

98% of developers achieve optimal productivity WITHOUT overnight agents.

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.3
**Based on:** Boris Cherny's advanced workflow patterns
**Warning Level:** 🔴🔴 CRITICAL - Expert Users Only, High Risk
