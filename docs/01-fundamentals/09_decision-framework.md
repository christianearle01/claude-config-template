# Decision Framework: Which Tool for Which Task?

**Version:** v4.18.0
**Updated:** 2025-12-17

Master the art of tool selection - knowing WHEN to use WHAT and WHY.

---

## Table of Contents

1. [Why Decision Frameworks Matter](#why-decision-frameworks-matter)
2. [Tool Selection Matrix](#tool-selection-matrix)
3. [Complexity Flowchart](#complexity-flowchart)
4. [Agents vs Commands vs Skills](#agents-vs-commands-vs-skills)
5. [Model Selection Integration](#model-selection-integration)
6. [Decision Trees by Task Type](#decision-trees-by-task-type)
7. [Quick Reference](#quick-reference)

---

## Why Decision Frameworks Matter

### The Problem: Integration Paralysis

After learning individual tools (agents, commands, skills, MCPs), users face a new challenge:
- "I know what each tool does, but which one should I use NOW?"
- "Should I use an agent or just read the file directly?"
- "When is sequential-thinking worth the extra tokens?"

**This is integration paralysis** - having powerful tools but not knowing which to choose.

### The Solution: Decision Frameworks

A decision framework is a **structured approach to tool selection** that:
1. Reduces cognitive load (follow the framework, not gut feeling)
2. Builds expertise faster (learn the patterns, not trial-and-error)
3. Optimizes outcomes (right tool = better results, fewer tokens)

**This guide teaches you the decision-making process, not just the tools.**

---

## Tool Selection Matrix

Quick reference: Match your task type to the recommended tool.

| Task Type | Recommended Tool | Why | Token Cost |
|-----------|------------------|-----|------------|
| **Read known file** | Read tool | Direct, fast, minimal overhead | Low (100-500) |
| **Find files by pattern** | Glob tool | Optimized for pattern matching | Low (50-200) |
| **Search code for keyword** | Grep tool | Fast text search | Low (100-300) |
| **Explore unknown codebase** | Explore agent | Systematic discovery | Medium (1K-3K) |
| **Plan implementation** | Plan agent | Architecture thinking | Medium (2K-5K) |
| **Complex decision** | Adversarial-validator agent | Multi-perspective analysis | High (3K-8K) |
| **Optimize prompt** | Prompt-polisher agent | Structured optimization | Medium (500-2K) |
| **Choose workflow mode** | Mode-selector agent | 6-dimension scoring | Medium (1K-2K) |
| **Repeated query** | Skill (auto-invoked) | Context-aware answers | Low (250-600) |
| **Workflow shortcut** | Skill | Pre-configured sequence | Low (varies) |
| **Multi-step reasoning** | Sequential-thinking MCP | Structured analysis | Medium (1K-3K) |

**Key principle:** Start with the simplest tool that solves the problem. Escalate only when needed.

---

## Complexity Flowchart

### When to Escalate from Simple to Complex Tools

```
START: What's the task?

├─ KNOWN file location?
│  YES → Use Read tool directly ✓
│  NO → Continue to exploration
│
├─ Simple PATTERN search?
│  YES → Use Glob (files) or Grep (content) ✓
│  NO → Continue to exploration
│
├─ Need to UNDERSTAND codebase structure?
│  YES → Use Explore agent ✓
│  NO → Continue to decision complexity
│
├─ Multiple VALID approaches?
│  YES → Use Adversarial-validator agent ✓
│  NO → Continue to implementation
│
├─ Need to PLAN multi-file changes?
│  YES → Use Plan agent ✓
│  NO → Use direct tools (Read + Edit)
│
└─ IMPLEMENT changes
   → Use appropriate tools (Edit, Write, Bash)
```

**Escalation triggers:**
1. **Uncertainty** - Don't know where to start → Explore agent
2. **Complexity** - Multiple files, unclear scope → Plan agent
3. **High stakes** - Architecture decisions → Adversarial-validator
4. **Optimization** - Want better approach → Mode-selector + Prompt-polisher

---

## Agents vs Commands vs Skills

### Understanding the Three Tool Types

| Feature | Agents | Commands | Skills |
|---------|--------|----------|--------|
| **Invocation** | `@agent-name` | `/command` | Automatic |
| **Purpose** | Complex tasks | Workflow shortcuts | Knowledge queries |
| **Scope** | READ+WRITE | READ+WRITE | READ-only |
| **Token cost** | High (1K-8K) | Varies | Low (250-600) |
| **Best for** | Multi-step tasks | Repeated operations | Frequent questions |
| **Examples** | Plan, Explore | /build, /test, /review | Projects-registry |

### When to Use Each

**Use Agents when:**
- Task requires multi-step reasoning
- Need structured output or analysis
- Want confidence scores and breakdowns
- Exploring multiple approaches
- **Example:** "I need to plan a refactoring strategy" → Plan agent

**Use Commands when:**
- Running project-specific workflows
- Repeated operations (build, test, review)
- Shortcuts for common sequences
- **Example:** "Run the test suite" → /test command

**Use Skills when:**
- Asking questions about known topics
- Querying project registry or status
- Need quick answers without exploration
- **Example:** "Which projects need updates?" → Projects-registry skill auto-invokes

### Combining Tools

**Powerful patterns:**
1. **Skill → Agent:** Skill answers question, agent acts on it
   - "Show outdated projects" (skill) → Plan updates (agent)

2. **Agent → Command:** Agent plans, command executes
   - Plan refactoring (agent) → /review to validate (command)

3. **Command → Skill:** Command runs, skill provides insights
   - /test (command) → Testing-workflow skill diagnoses failures

---

## Model Selection Integration

### Three-Question Method (from v3.11.0)

After choosing your tool, choose your model:

```
1. Is this CREATIVE or ARCHITECTURAL work?
   YES → Use Opus
   Examples: System design, architecture decisions, complex planning

2. Does this involve WRITING CODE?
   YES → Use Sonnet
   Examples: Implementation, refactoring, bug fixes

3. Is this MECHANICAL or EXPLORATORY?
   YES → Use Haiku
   Examples: File search, simple reads, pattern matching
```

### Model Selection by Tool

**Pre-configured in agents** (`.claude/agents/*.md`):

| Agent | Recommended Model | Why |
|-------|-------------------|-----|
| Adversarial-validator | **Opus** | Multi-perspective reasoning, high-stakes decisions |
| Project-planner | **Opus** | 6-perspective architecture analysis |
| Initializer | **Opus** | Feature decomposition, learning path design |
| Coder | **Sonnet** | Balanced implementation work |
| Prompt-polisher | **Sonnet** | Structured prompt optimization |
| Explore | **Haiku** | Fast codebase navigation |
| Quality-reviewer | **Haiku** | Rule-based orchestration |

**Cost impact:**
- Explore with Haiku vs Sonnet: 91% cheaper
- Adversarial-validator with Opus vs Sonnet: Worth 3x cost for better decisions
- Overall: 24% token reduction when using optimal models

---

## Decision Trees by Task Type

### Bug Fix Decision Tree

```
1. Do you know which FILE has the bug?
   YES → Read the file directly
   NO → Use Grep to search error message or Explore agent

2. Is the ROOT CAUSE obvious?
   YES → Fix directly with Edit
   NO → Use sequential-thinking MCP to analyze

3. Will the fix affect MULTIPLE files?
   YES → Use Plan agent to coordinate changes
   NO → Fix the single file

4. Is this a CRITICAL bug in production?
   YES → Use Testing-workflow skill + Quality-reviewer agent
   NO → Standard fix → test → commit workflow
```

**Example:**
- Known bug in `auth.ts` line 45 → Read → Edit → Done (200 tokens)
- Mystery authentication error → Grep "auth error" → Read files → sequential-thinking → Plan → Fix (3K tokens, but thorough)

---

### New Feature Decision Tree

```
1. Is the feature WELL-DEFINED with clear requirements?
   YES → Use Plan agent → Implement
   NO → Use Project-planner agent first (6 perspectives)

2. Will this require MULTIPLE sessions to complete?
   YES → Use Domain Memory pattern (Initializer + Coder agents)
   NO → Standard implementation

3. Does this involve ARCHITECTURE decisions?
   YES → Use Adversarial-validator agent (3 personas)
   NO → Proceed with Plan agent

4. Do you need QUALITY validation?
   YES → Use Quality-reviewer agent after implementation
   NO → Standard review process
```

**Example:**
- Add logout button → Plan → Implement → Done (2K tokens)
- Build user dashboard → Project-planner (Opus) → Initializer → Coder (Sonnet) → Quality-reviewer (4 sessions, 12K tokens total, but robust)

---

### Refactoring Decision Tree

```
1. Is the refactoring scope CLEAR?
   YES → Plan agent → Implement
   NO → Explore agent first to understand structure

2. Are there MULTIPLE valid approaches?
   YES → Adversarial-validator agent (compare approaches)
   NO → Proceed with chosen approach

3. Will this affect MANY files?
   YES → Create detailed plan, phase the work
   NO → Direct refactoring

4. Need to maintain BACKWARD compatibility?
   YES → Quality-reviewer agent for validation
   NO → Standard testing
```

**Example:**
- Extract 3 functions to utils → Read → Edit → Done (500 tokens)
- Refactor authentication system → Explore → Adversarial-validator (3 approaches) → Plan → Implement in phases (8K tokens, but prevents rework)

---

### Optimization Decision Tree

```
1. What are you optimizing?
   CODE PERFORMANCE → Profile first, Plan changes
   TOKEN USAGE → Mode-selector + Prompt-polisher agents
   WORKFLOW SPEED → Analyze bottlenecks, use appropriate automation

2. Do you know the OPTIMAL approach?
   YES → Implement directly
   NO → Use Adversarial-validator to compare approaches

3. Is this a ONE-TIME optimization?
   YES → Do it manually, document the pattern
   NO → Create skill or skill for reuse

4. Need to measure IMPACT?
   YES → Before/after metrics, validate improvement
   NO → Implement and monitor
```

**Example:**
- "My prompts are too verbose" → Prompt-polisher (educational mode) → Learn patterns → Apply (1.5K tokens, learn for future)
- "Which workflow mode?" → Mode-selector agent → Get recommendation (1K tokens)

---

### Deployment/Release Decision Tree (NEW in v4.19.0)

```
1. Are you ready to DEPLOY to production?
   YES → Continue to validation
   NO → Complete development first

2. Have you run QUALITY checks?
   YES → Continue to version validation
   NO → Use @quality-reviewer agent (security + tests + standards)

3. Is the VERSION bumped consistently?
   YES → Continue to changelog validation
   NO → Use version-management skill (check all files synced)

4. Is the CHANGELOG entry complete?
   YES → Continue to git validation
   NO → Update CHANGELOG.md with release notes

5. Is your GIT state clean?
   YES → Continue to deployment readiness
   NO → Commit all changes, ensure on correct branch

6. Are you confident this is READY to deploy?
   UNSURE → Use @deployment-readiness agent (comprehensive check)
   YES → Use /release command (orchestrates all checks)

7. All checks passed?
   YES → Create git tag, push to remote, deploy
   NO → Fix blockers reported in validation output
```

**Decision shortcuts:**

**Quick validation (2-3 min):**
```bash
/release
```
- Orchestrates all 5 checks sequentially
- Provides confidence-scored report
- Fails fast on blockers
- Token cost: 1,200 tokens
- Use when: Ready to ship, want comprehensive validation

**Manual validation (25-35 min):**
- Run each check individually
- Investigate each component deeply
- Token cost: 3,700 tokens
- Use when: First release, learning the process, debugging failures

**Example workflows:**

**Scenario A: Confident release**
```
User: "Ready to release v4.19.0"
→ /release
→ All checks pass (91% confidence)
→ Create tag: git tag -a v4.19.0 -m "Release v4.19.0"
→ Push: git push origin v4.19.0
→ Deploy
Total: 2 minutes, 1,200 tokens
```

**Scenario B: Uncertain, need validation**
```
User: "Is this ready to deploy?"
→ @deployment-readiness
→ Conditional (72% confidence) - 2 warnings found
→ Fix warnings (update docs, bump version)
→ Re-run: @deployment-readiness
→ Ready (88% confidence)
→ /release for final validation
→ Deploy
Total: 15 minutes, 2,400 tokens (still faster than manual 35 min)
```

**Scenario C: Failed validation**
```
User: "Ready to release"
→ /release
→ Step 1: Quality checks FAIL (62% confidence - 3 security issues)
→ Workflow stops, reports blockers with file:line
→ Fix security issues
→ Re-run: /release
→ All pass (89% confidence)
→ Deploy
Total: 20 minutes, 2,800 tokens (prevented production incident)
```

**When NOT to use automated deployment checks:**
- ❌ Still in development (tests failing, code incomplete)
- ❌ Experimental features (not ready for production)
- ❌ Hot fix without time for full validation (use judgment, but risky)
- ❌ Pre-alpha / proof-of-concept (no formal release process yet)

**Integration with v4.18.0 frameworks:**
- **Decision Framework:** Follow the 6-step tree above
- **Integration Pattern:** Sequential tool chain (quality → version → changelog → git → deployment)
- **Confidence Scoring:** ≥85% = safe, 60-84% = risky, <60% = blocked

---

## Quick Reference

### Start Here: 3-Step Decision Process

**Step 1: Define the task**
- What am I trying to accomplish?
- What do I already know vs need to discover?

**Step 2: Choose the simplest tool**
- Known file → Read
- Unknown location → Glob or Grep
- Need exploration → Explore agent
- Complex decision → Higher-level agent

**Step 3: Escalate only if needed**
- Simple tool didn't work? → Try next level
- Multiple approaches possible? → Use decision agent
- High stakes? → Use validation agent

---

### Red Flags: When You're Using the Wrong Tool

**🚩 Over-using agents for simple tasks**
- "I need to read config.json" → Don't use Explore agent, just Read
- **Fix:** Use simplest tool first (Read), escalate only if needed

**🚩 Using sequential-thinking for trivial decisions**
- "Should I use const or let?" → Don't need deep analysis
- **Fix:** Trust your judgment on straightforward choices

**🚩 Skipping exploration phase**
- Editing files without understanding codebase structure
- **Fix:** Use Explore agent first, especially in unfamiliar code

**🚩 Not using skills for repeated questions**
- Manually checking project status every time
- **Fix:** Skills auto-invoke for common queries (e.g., projects-registry)

**🚩 Using wrong model**
- Running Explore agent with Opus (expensive, unnecessary)
- **Fix:** Match model to task complexity (Haiku for exploration)

---

### Decision Framework Cheat Sheet

**Print or bookmark this:**

```
TASK                          → TOOL                    → MODEL
───────────────────────────────────────────────────────────────
Read known file               → Read                    → N/A
Find files                    → Glob                    → N/A
Search code                   → Grep                    → N/A
Explore codebase              → Explore agent           → Haiku
Plan implementation           → Plan agent              → Sonnet
Architecture decision         → Adversarial-validator   → Opus
Optimize prompt               → Prompt-polisher         → Sonnet
Choose workflow               → Mode-selector           → Sonnet
Complex reasoning             → Sequential-thinking MCP → Sonnet
Quick status check            → Skill (auto)            → N/A
Project workflow              → Skill           → N/A
Release validation            → /release OR @deployment-readiness → Sonnet
```

---

## Related Resources

**Learn more about the tools mentioned:**
- [Agents](#custom-agents) - 7 specialized agents with confidence scoring
- [Skills](02_skills-paradigm.md) - Automatic expertise invocation
- [Model Selection](../02-optimization/01_model-selection-strategy.md) - Three-Question Method
- [Prompt Patterns](08_prompt-patterns.md) - 10 reusable templates
- [Integration Patterns](../02-optimization/06_integration-patterns.md) - How tools work together (coming in v4.18.0)

**See it in action:**
- [Workflow Examples](../../examples/workflows/) - 4 end-to-end scenarios (coming in v4.18.0)

---

## Success Criteria

You've mastered the decision framework when you can:

1. ✅ **Quickly choose** the right tool for a task (< 30 seconds decision time)
2. ✅ **Explain your reasoning** (why this tool, not that one)
3. ✅ **Escalate appropriately** (start simple, add complexity only when needed)
4. ✅ **Avoid over-engineering** (not using Opus when Haiku suffices)
5. ✅ **Combine tools effectively** (agents + commands + skills working together)

**Next steps:**
1. Read through the [Workflow Examples](../../examples/workflows/) to see decisions in context
2. Practice with your own tasks, consciously applying the decision trees
3. Review your tool usage after a week - are you using the optimal tools?

---

**Keywords:** decision framework, tool selection, agents, commands, skills, complexity, escalation, optimization, workflow, meta-learning

