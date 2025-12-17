# Integration Patterns: How Tools Work Together

**Version:** v4.18.0
**Updated:** 2025-12-17

Master the art of combining tools for maximum effectiveness.

---

## Table of Contents

1. [Why Integration Patterns Matter](#why-integration-patterns-matter)
2. [Sequential Tool Chains](#sequential-tool-chains)
3. [Parallel Tool Usage](#parallel-tool-usage)
4. [Agent Combinations](#agent-combinations)
5. [Skill Integration](#skill-integration)
6. [Anti-Patterns](#anti-patterns)
7. [Pattern Selection Guide](#pattern-selection-guide)

---

## Why Integration Patterns Matter

### The Integration Gap

**Problem:** Users learn individual tools but don't know how to combine them effectively.

**Symptoms:**
- Using Explore agent when Grep + Read would suffice
- Running sequential tools that could run in parallel (2x slower)
- Missing skill shortcuts that eliminate agent overhead
- Over-using complex tools for simple tasks

**Solution:** Learn integration patterns - HOW tools work together.

### The 4-Layer Model

```
Context Management
       ↓
  Commands (Workflows)
       ↓
   Skills (Expertise)
       ↓
   Agents (Complex Tasks)
```

**Key insight:** Tools at different layers integrate differently. Understanding the patterns multiplies effectiveness.

---

## Sequential Tool Chains

**When:** Tools depend on each other's output (A → B → C)

### Pattern 1: Investigate → Decide → Implement

**Use case:** Bug fixes, refactoring, feature additions

**Chain:**
```
1. Grep or Explore (find the problem/location)
   ↓ output: file paths, code context
2. Read (understand the code)
   ↓ output: full file contents
3. Sequential-thinking or Adversarial-validator (decide approach)
   ↓ output: implementation plan
4. Edit or Write (make changes)
   ↓ output: modified code
5. Bash (test changes)
   ↓ output: test results
6. Git commit (save work)
```

**Example from workflows:**
- [Bug Fix Workflow](../../examples/workflows/01_bug-fix-workflow.md) - Grep → Read → Edit → Test
- [Refactor Workflow](../../examples/workflows/03_refactor-workflow.md) - Explore → Adversarial-validator → Edit

**Token cost:** 1,800-5,400 depending on complexity

**Why sequential:** Each step informs the next. Can't edit before reading, can't commit before testing.

---

### Pattern 2: Explore → Plan → Domain Memory

**Use case:** Multi-session features, large projects

**Chain:**
```
1. Explore agent (understand codebase structure)
   ↓ output: architecture understanding
2. Plan agent (design implementation approach)
   ↓ output: implementation strategy
3. Initializer agent (create structured breakdown)
   ↓ output: features.json, progress.md
4. Coder agent (implement features atomically)
   ↓ output: working code, updated artifacts
```

**Example from workflows:**
- [New Feature Workflow](../../examples/workflows/02_new-feature-workflow.md) - Initializer → Coder (multiple sessions)

**Token cost:** 8,500-12,000 for complete feature

**Why sequential:** Domain memory (Initializer) requires understanding of scope. Coder requires domain memory to exist.

---

### Pattern 3: Mode-Selector → Specialized Agent

**Use case:** Uncertain which approach to take

**Chain:**
```
1. Mode-selector agent (determine optimal workflow)
   ↓ output: recommended mode + model + approach
2. Appropriate specialized agent (execute with right complexity)
   ↓ output: task completion
```

**Example from workflows:**
- [Optimization Workflow](../../examples/workflows/04_optimization-workflow.md) - Mode-selector → Prompt-polisher (educational)

**Token cost:** 1,000-2,500 depending on mode chosen

**Why sequential:** Mode-selector informs which agent/mode to use. Can't choose agent before knowing optimal approach.

---

## Parallel Tool Usage

**When:** Tools are independent (A + B + C simultaneously)

### Pattern 4: Multi-File Reading

**Use case:** Understanding multiple related files

**Parallel calls:**
```bash
Read src/components/Header.tsx
Read src/components/Sidebar.tsx
Read src/hooks/useAuth.ts
```

**Instead of:**
```bash
Read Header → wait → Read Sidebar → wait → Read useAuth
```

**Token savings:** 0 (same tokens)
**Time savings:** 66% faster (3 serial calls → 1 parallel round)

**Why parallel:** No dependency between reads. All files available simultaneously.

---

### Pattern 5: Multi-Agent Exploration

**Use case:** Exploring different areas of codebase

**Parallel calls:**
```bash
@explore authentication flow in src/auth/
@explore API endpoints in src/api/
@explore database models in src/models/
```

**Token cost:** 4,500 total (1,500 per agent)
**Time:** 1 round instead of 3

**Why parallel:** Each exploration is independent. Results can be compared afterward.

**When to use:** Large codebase, need broad understanding quickly

---

### Pattern 6: Validation in Parallel

**Use case:** Quality checks before release

**Parallel calls:**
```bash
@security-scanner (check for vulnerabilities)
@test-generator (ensure coverage)
@standards-enforcer (validate conventions)
```

**Token cost:** 3,000-5,000 total
**Time:** 1 round instead of 3

**Why parallel:** Independent validations. Can aggregate results after.

**Example:** Quality-reviewer agent orchestrates these in parallel

---

### Pattern 7: Release Workflow Chain (NEW in v4.19.0)

**Use case:** Production deployment validation

**Chain:**
```
1. @quality-reviewer (security, tests, standards)
   ↓ output: quality confidence score
2. version-management skill (check all files synced)
   ↓ output: version consistency report
3. commit-readiness-checker skill (validate changelog)
   ↓ output: changelog completeness
4. git status check (clean working directory)
   ↓ output: git state validation
5. @deployment-readiness (comprehensive pre-deploy check)
   ↓ output: deployment confidence score + blockers
```

**Automated via:**
```bash
/release
```

**Token cost:**
- Manual chain: 3,700 tokens (running each step separately)
- /release command: 1,200 tokens (orchestrated)
- **Savings:** 2,500 tokens (68% reduction, projected)

**Time:**
- Manual: 25-35 minutes
- Automated: 2-3 minutes
- **Time saved:** 22-32 minutes per release

**Why sequential:** Each step must pass before proceeding. Fails fast on blockers.

**Pass criteria:** All steps ≥85% confidence

**Output:** Comprehensive release report with confidence scoring

**Example:** [Deployment Readiness Workflow](../../examples/workflows/05_deployment-readiness-workflow.md)

**Integration with decision framework:**
- Follow deployment decision tree (step-by-step validation)
- Use /release for quick validation, manual steps for debugging
- Confidence scoring guides next action (fix blockers vs deploy)

**Why this pattern matters:**
- Prevents production incidents (catches issues before deploy)
- Reduces deployment anxiety ("did I check everything?")
- Standardizes release process (repeatable, auditable)
- Demonstrates v4.18.0 integration patterns in action

---

## Agent Combinations

**When:** Agents complement each other's strengths

### Combination 1: Initializer + Coder (Domain Memory)

**Pattern:**
- **Initializer (Opus):** Feature decomposition, learning path design
- **Coder (Sonnet):** Implementation, testing, artifact updates

**Use when:**
- Multi-session projects
- Need persistent memory
- Want atomic feature delivery

**Token distribution:**
- Initializer: 2,000 tokens (one-time upfront)
- Coder: 1,200-2,300 tokens per session
- **Savings:** 19% from reduced regrounding across sessions

**Example:** [New Feature Workflow](../../examples/workflows/02_new-feature-workflow.md)

---

### Combination 2: Plan + Quality-Reviewer

**Pattern:**
- **Plan agent (Sonnet):** Design implementation strategy
- **Quality-reviewer (Haiku):** Validate security, tests, standards

**Use when:**
- Need confidence in implementation quality
- High-stakes changes
- Team has strict standards

**Token distribution:**
- Plan: 2,000-5,000 tokens
- Quality-reviewer: 1,500-3,000 tokens
- **Value:** Prevents costly post-deployment fixes

---

### Combination 3: Explore + Adversarial-Validator

**Pattern:**
- **Explore agent (Haiku):** Understand codebase patterns
- **Adversarial-validator (Opus):** Decide between valid approaches

**Use when:**
- Refactoring with architectural implications
- Multiple valid solutions exist
- Need confidence in decision

**Token distribution:**
- Explore: 1,500 tokens
- Adversarial-validator: 2,500 tokens
- **Value:** Prevents architectural regret

**Example:** [Refactor Workflow](../../examples/workflows/03_refactor-workflow.md)

---

### Combination 4: Mode-Selector + Prompt-Polisher

**Pattern:**
- **Mode-selector (Sonnet):** Determine optimal mode (fast/balanced/educational)
- **Prompt-polisher (varies):** Optimize with selected complexity

**Use when:**
- Uncertain which optimization level to use
- Want data-driven mode selection
- Balance speed vs learning

**Token distribution:**
- Mode-selector: 800 tokens
- Prompt-polisher: 200-1,200 tokens (depending on mode)
- **Value:** Right complexity for the situation

**Example:** [Optimization Workflow](../../examples/workflows/04_optimization-workflow.md)

---

## Skill Integration

**When:** Skills provide shortcuts that eliminate agent overhead

### Integration 1: Skill → Agent

**Pattern:** Skill answers question, agent acts on answer

**Example:**
```bash
# User asks: "Which projects need version updates?"
# → Projects-registry skill auto-invokes (250 tokens)
# → Returns: "3 projects at outdated versions"

# Then: Use Plan agent to coordinate updates
@plan Update versions for projects X, Y, Z
# → Plan agent: 2,000 tokens
```

**Without skill:**
```bash
# Manual exploration:
Bash ls ~/.claude/projects/ → cd each → check versions
# → 1,500 tokens to discover same information

# Then plan:
@plan Update versions...
# → Plan agent: 2,000 tokens
```

**Skill savings:** 1,250 tokens (83% reduction in discovery phase)

---

### Integration 2: Command → Skill → Agent

**Pattern:** Command triggers workflow, skill provides insights, agent acts

**Example:**
```bash
# User runs: /test
# → Runs test suite via command (200 tokens)
# → Tests fail with cryptic errors

# Testing-workflow skill auto-invokes (400 tokens)
# → Diagnoses: "API endpoint returning 500, likely auth issue"

# Then: Use Explore agent to investigate
@explore auth flow in src/auth/
# → Explore agent: 1,500 tokens
```

**Without skill:**
```bash
# Manual diagnosis:
Read test output → grep for clues → read multiple files
# → 2,000 tokens to understand failure

# Then explore:
@explore ...
# → Explore agent: 1,500 tokens
```

**Skill savings:** 1,600 tokens (44% reduction in diagnosis phase)

---

### Integration 3: Agent Proposes → Skill Validates

**Pattern:** Agent makes suggestion, skill checks feasibility

**Example:**
```bash
# Plan agent suggests: "Add feature X to project Y"
# → Plan agent: 2,000 tokens

# Projects-registry skill checks (auto-invoked)
# → "Warning: Project Y is at v1.0.0, dependencies outdated"

# Adjust plan based on skill insight
# → Plan agent: 500 tokens (update)
```

**Without skill:**
```bash
# Implement blindly, discover issues during implementation
# → Wasted 3,000 tokens on failed approach
# → Re-plan and re-implement
# → Total: 5,500 tokens
```

**Skill savings:** 3,000 tokens (preventing wasted implementation)

---

## Anti-Patterns

**What NOT to do when integrating tools**

### Anti-Pattern 1: Over-Using Agents for Simple Tasks

**❌ Bad:**
```bash
@explore Find the config file
# → 1,500 tokens for exploration
```

**✅ Good:**
```bash
Glob pattern="**/config.*"
# → 100 tokens, instant result
```

**Lesson:** Start with simplest tool. Escalate only if needed.

---

### Anti-Pattern 2: Sequential When Parallel is Possible

**❌ Bad:**
```bash
Read src/Header.tsx
# wait...
Read src/Footer.tsx
# wait...
Read src/Sidebar.tsx
# wait...
# → 3 rounds, 90 seconds
```

**✅ Good:**
```bash
Read src/Header.tsx
Read src/Footer.tsx
Read src/Sidebar.tsx
# → 1 round, 30 seconds (66% faster)
```

**Lesson:** If tools don't depend on each other, run in parallel.

---

### Anti-Pattern 3: Skipping Exploration Before Decision

**❌ Bad:**
```bash
# Immediately refactor without understanding:
Edit src/auth.ts
# → Breaks things, 2,000 tokens wasted
```

**✅ Good:**
```bash
# Explore first, then decide:
@explore auth flow
# → 1,500 tokens, understanding
@adversarial-validator Refactor approach?
# → 2,500 tokens, confident decision
Edit src/auth.ts
# → Works first time
```

**Lesson:** Upfront exploration prevents costly rework.

---

### Anti-Pattern 4: Wrong Model for Agent

**❌ Bad:**
```bash
@explore --model=opus
# → Using expensive model for mechanical task
# → 1,500 tokens at 3x cost ($0.045 vs $0.015)
```

**✅ Good:**
```bash
@explore --model=haiku
# → Using cheap model for exploration
# → 1,500 tokens at 1x cost ($0.015)
# → 91% cost reduction
```

**Lesson:** Match model to task complexity (see Model Selection Strategy).

---

### Anti-Pattern 5: Not Using Skills for Repeated Queries

**❌ Bad:**
```bash
# Every time: manually check project status
Bash cat ~/.claude/projects-registry.json
# → 600 tokens per query
```

**✅ Good:**
```bash
# Natural language, skill auto-invokes:
"Show outdated projects"
# → 250 tokens per query (58% savings)
```

**Lesson:** Skills eliminate repeated manual operations.

---

## Pattern Selection Guide

### Decision Matrix: Which Integration Pattern?

| Situation | Recommended Pattern | Example |
|-----------|---------------------|---------|
| **Tools depend on each other** | Sequential chain | Grep → Read → Edit |
| **Tools are independent** | Parallel execution | Read 3 files at once |
| **Multi-session project** | Initializer + Coder | Domain memory pattern |
| **Uncertain approach** | Mode-selector → Agent | Determine complexity first |
| **High-stakes decision** | Explore → Adversarial-validator | Refactoring, architecture |
| **Quality validation needed** | Plan → Quality-reviewer | Pre-release checks |
| **Repeated query** | Skill → Agent (if needed) | Projects-registry + Plan |
| **Workflow shortcut** | Command → Skill → Agent | /test → Testing-workflow |

---

### Quick Selection Process

**Step 1: Identify dependencies**
```
Do tools depend on each other's output?
├─ YES → Sequential chain
└─ NO → Consider parallel
```

**Step 2: Identify complexity**
```
Is this a simple or complex task?
├─ SIMPLE → Direct tools (Read, Edit, Grep)
├─ MEDIUM → Single agent (Explore, Plan)
└─ COMPLEX → Agent combinations (Initializer + Coder)
```

**Step 3: Check for skill shortcuts**
```
Is this a repeated query or common task?
├─ YES → Check if skill exists
└─ NO → Use agents/commands
```

**Step 4: Validate model choice**
```
Which model for each agent?
├─ CREATIVE/ARCHITECTURAL → Opus
├─ CODING/IMPLEMENTATION → Sonnet
└─ MECHANICAL/EXPLORATORY → Haiku
```

---

## Integration Examples

### Example 1: Simple Bug Fix (Minimal Integration)

```
Tools: Grep → Read → Edit
Pattern: Sequential chain
Agents: None (direct tools suffice)
Model: N/A
Tokens: ~800
Time: 10 minutes
```

**When:** Known error message, simple fix

---

### Example 2: New Feature (Heavy Integration)

```
Tools: Explore → Initializer → Coder (3 sessions) → Quality-reviewer
Pattern: Sequential chain + Domain memory + Validation
Agents: 4 agents with different models
Models: Haiku (Explore), Opus (Initializer), Sonnet (Coder), Haiku (Quality-reviewer)
Tokens: ~12,000 across sessions
Time: 3 sessions (~90 minutes total)
```

**When:** Multi-session feature, need quality confidence

---

### Example 3: Refactoring (Balanced Integration)

```
Tools: Explore → Adversarial-validator → Edit → Test
Pattern: Sequential chain with decision validation
Agents: 2 agents with appropriate models
Models: Haiku (Explore), Opus (Adversarial-validator)
Tokens: ~5,400
Time: 45 minutes
```

**When:** Architectural implications, multiple valid approaches

---

## Success Metrics

You've mastered integration patterns when you can:

1. ✅ **Identify dependencies** - Know when sequential vs parallel
2. ✅ **Choose right complexity** - Direct tools vs agents vs combinations
3. ✅ **Use skills efficiently** - Recognize skill shortcuts
4. ✅ **Match models to tasks** - Opus/Sonnet/Haiku appropriately
5. ✅ **Avoid anti-patterns** - Don't over-engineer or under-prepare

---

## Related Resources

**Learn the individual tools:**
- [Decision Framework](../01-fundamentals/09_decision-framework.md) - When to use which tool
- [Model Selection Strategy](01_model-selection-strategy.md) - Opus/Sonnet/Haiku guide

**See patterns in action:**
- [Bug Fix Workflow](../../examples/workflows/01_bug-fix-workflow.md) - Simple integration
- [New Feature Workflow](../../examples/workflows/02_new-feature-workflow.md) - Heavy integration
- [Refactor Workflow](../../examples/workflows/03_refactor-workflow.md) - Balanced integration
- [Optimization Workflow](../../examples/workflows/04_optimization-workflow.md) - Graduated complexity

**Deep dives:**
- [Domain Memory Architecture](../../CLAUDE.md#domain-memory-architecture-v360) - Initializer + Coder
- [Skills Paradigm](../01-fundamentals/02_skills-paradigm.md) - Future of shortcuts
- [Agents Documentation](../../.claude/agents/) - Individual agent details

---

**Last updated:** v4.18.0 (2025-12-17)
