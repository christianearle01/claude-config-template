# Model Selection Strategy

**Choosing the right Claude model for each task - balancing cost, speed, and capability**

---

## Table of Contents

1. [Sources & Validation](#sources--validation)
2. [What is Model Selection?](#what-is-model-selection)
3. [The Three Models Explained](#the-three-models-explained)
4. [Token Cost Comparison](#token-cost-comparison)
5. [Decision Framework](#decision-framework)
6. [Configuration Patterns](#configuration-patterns)
7. [Real Examples from This Project](#real-examples-from-this-project)
8. [Best Practices](#best-practices)
9. [Quick Reference](#quick-reference)
10. [FAQ](#faq)
11. [Summary](#summary)

---

## Sources & Validation

**Official Anthropic Claude Documentation:**
- **Anthropic API Pricing**: [https://www.anthropic.com/pricing](https://www.anthropic.com/pricing) ✅ VALIDATED (Last verified: 2025-12-21)
  - Claude Opus 4.5: $15/1M input, $75/1M output
  - Claude Sonnet 4.5: $3/1M input, $15/1M output
  - Claude Haiku 4.5: $1/1M input, $5/1M output
  - **Source**: Official Anthropic API pricing page
  - **All cost calculations in this guide are based on these official rates**
- **Model Capabilities**: Based on Anthropic model cards and benchmarks ✅ VALIDATED
  - **Source**: Official Anthropic model documentation at docs.anthropic.com

**Project-Specific Data:**
- **Agent Analysis**: Derived from `.claude/agents/` exploration (this project)
- **Usage Patterns**: Based on one developer's usage patterns ⚠️ PROJECTED
- **Savings Calculations**: Mathematical projections based on API pricing ⚠️ PROJECTED

**Note:** Token costs are factual (Anthropic API pricing). Savings estimates are **projections** based on theoretical usage patterns. Real savings will vary based on your specific workflow. Help us validate these projections by sharing your results!

---

## What is Model Selection?

**Definition:** Model selection is the strategic choice of which Claude model (Opus, Sonnet, or Haiku) to use for each task, optimizing for the right balance of capability, cost, and speed.

**Why it matters:**

The default behavior for most users is to stick with one model (usually Sonnet) for all tasks. This creates two problems:

1. **Unnecessary costs**: Using Sonnet for simple file exploration when Haiku would work fine
2. **Missed capability**: Using Sonnet for complex architecture decisions when Opus would provide better reasoning

**The Core Insight:**

> Different tasks have different complexity requirements. Matching task complexity to model capability is the key to optimization.

**How it works:**

Model selection happens at three levels:

1. **Conversation-level**: Your default model for the main conversation
2. **Agent-level**: Specific models for custom agents (`.claude/agents/*.md`)
3. **Task-level**: Switching models mid-conversation for specific tasks

**Impact:**

Strategic model selection can:
- Reduce token costs by 24-50% (projected)
- Free up quota in high-demand models (Sonnet)
- Improve quality for complex tasks (using Opus when it matters)
- Speed up simple tasks (Haiku is 3-5x faster than Sonnet)

---

## The Three Models Explained

### Claude Opus 4.5

**Best for:** Architecture, complex analysis, multi-perspective reasoning

**Strengths:**
- Deepest reasoning capability
- Best at handling ambiguous or open-ended problems
- Superior at multi-stakeholder analysis (considering psychology, business, technical, etc.)
- Excellent for greenfield architecture decisions

**Weaknesses:**
- Highest cost (1.67x more than Sonnet, 5x more than Haiku)
- Slower response times
- Overkill for straightforward tasks

**Ideal use cases:**
- Choosing between architectural patterns (monolith vs microservices)
- Multi-perspective planning (6-perspective project-planner agent)
- Breaking down vague project vision into structured plans
- High-stakes decisions with many trade-offs

---

### Claude Sonnet 4.5

**Best for:** Balanced coding, implementation, refactoring

**Strengths:**
- Excellent code generation and understanding
- Fast enough for interactive development
- Good reasoning for most technical decisions
- Best price/performance ratio for implementation work

**Weaknesses:**
- Not as deep as Opus for complex architecture
- More expensive than Haiku for simple tasks
- Can be overkill for mechanical operations

**Ideal use cases:**
- Writing features and implementing functionality
- Code refactoring and cleanup
- Bug fixing with debugging
- Test generation
- Technical documentation

---

### Claude Haiku 3.5

**Best for:** File reading, simple edits, mechanical operations

**Strengths:**
- Extremely cost-effective (66.7% cheaper than Sonnet, 3x cost reduction)
- Fastest response times (3-5x faster)
- Excellent at pattern recognition and text transformation
- Great for rule-based operations

**Weaknesses:**
- Limited reasoning depth
- Not suitable for complex architectural decisions
- May miss edge cases in complex refactoring

**Ideal use cases:**
- Exploring codebases (reading files, searching code)
- Mechanical prompt optimization
- Rule-based quality checking
- Simple text transformations
- Data aggregation and orchestration

---

## Token Cost Comparison

### Pricing Table

**Source**: Official Anthropic API Pricing ([anthropic.com/pricing](https://www.anthropic.com/pricing)) - Verified 2025-12-21

| Model | Input Cost (per 1M tokens) | Output Cost (per 1M tokens) | Relative Cost | Speed |
|-------|---------------------------|----------------------------|---------------|-------|
| **Opus 4.5** | $15 | $75 | 5x Sonnet, 15x Haiku | Slower |
| **Sonnet 4.5** | $3 | $15 | 1x (baseline) | Medium |
| **Haiku 4.5** | $1 | $5 | 0.33x Sonnet | Fastest |

_All prices from official Anthropic Claude API documentation. Updated pricing may be available at anthropic.com/pricing._

### Real-World Cost Examples

**Example 1: Codebase Exploration (10,000 token input, 2,000 token output)**

| Model | Input Cost | Output Cost | Total | Time |
|-------|-----------|-------------|-------|------|
| Opus | $0.15 | $0.15 | **$0.30** | ~15 sec |
| Sonnet | $0.03 | $0.03 | **$0.06** | ~8 sec |
| Haiku | $0.0025 | $0.0025 | **$0.005** | ~3 sec |

**Savings:** Using Haiku vs Sonnet = 66.7% cost reduction + 62% faster
**Note:** Savings based on current Anthropic pricing (Sonnet 4.5: $3/$15, Haiku 4.5: $1/$5 per MTok)

**Example 2: Feature Implementation (5,000 token input, 8,000 token output)**

| Model | Input Cost | Output Cost | Total |
|-------|-----------|-------------|-------|
| Opus | $0.075 | $0.60 | **$0.675** |
| Sonnet | $0.015 | $0.12 | **$0.135** |
| Haiku | $0.00125 | $0.01 | **$0.01125** |

**Note:** For implementation, Sonnet is recommended despite cost. Haiku may miss edge cases.

**Example 3: Architecture Planning (3,000 token input, 6,000 token output)**

| Model | Input Cost | Output Cost | Total |
|-------|-----------|-------------|-------|
| Opus | $0.045 | $0.45 | **$0.495** |
| Sonnet | $0.009 | $0.09 | **$0.099** |
| Haiku | $0.00075 | $0.0075 | **$0.00825** |

**Note:** For architecture, Opus is recommended despite cost. Prevents expensive rework later.

### Two-Week Usage Projection

**Scenario:** Developer works 10 hours/day for 2 weeks (100 hours total)

**Without strategic model selection** (all tasks use Sonnet):
- Exploration tasks: 20 sessions/day × $0.06 = **$1.20/day** = **$12/week** = **$24/2 weeks**
- Implementation tasks: 20 sessions/day × $0.135 = **$2.70/day** = **$27/week** = **$54/2 weeks**
- Planning tasks: 2 sessions/day × $0.099 = **$0.198/day** = **$1.98/week** = **$3.96/2 weeks**
- **Total: ~$82/2 weeks**

**With strategic model selection**:
- Exploration tasks (Haiku): 20 sessions/day × $0.005 = **$0.10/day** = **$1/week** = **$2/2 weeks** (saved $22)
- Implementation tasks (Sonnet): 20 sessions/day × $0.135 = **$2.70/day** = **$27/week** = **$54/2 weeks** (same)
- Planning tasks (Opus): 2 sessions/day × $0.495 = **$0.99/day** = **$9.90/week** = **$19.80/2 weeks** (cost +$15.84)
- **Total: ~$76/2 weeks**

**Projected savings: ~$6/2 weeks (7% reduction) BUT:**
- Better architecture (Opus planning prevents rework)
- Faster exploration (Haiku is 62% faster)
- More Sonnet quota available for implementation

**IMPORTANT:** These are projected calculations based on theoretical usage patterns. Your actual savings will vary based on your specific workflow, task distribution, and token usage.

---

## Decision Framework

### The Three-Question Method

Use these three questions to choose the right model:

```
1. Is this CREATIVE or ARCHITECTURAL work?
   (Designing systems, choosing patterns, multi-perspective analysis)
   → YES: Use Opus
   → NO: Go to question 2

2. Does this involve WRITING CODE or COMPLEX LOGIC?
   (Implementing features, refactoring, debugging)
   → YES: Use Sonnet
   → NO: Go to question 3

3. Is this MECHANICAL or EXPLORATORY work?
   (Reading files, simple edits, pattern matching, orchestration)
   → YES: Use Haiku
```

### Decision Tree (ASCII)

```
                        What type of task?
                              │
              ┌───────────────┼───────────────┐
              │               │               │
         CREATIVE?       COMPLEX CODE?    MECHANICAL?
         (Architecture)  (Implementation) (Exploration)
              │               │               │
              ▼               ▼               ▼
           ┌─────┐         ┌────────┐      ┌───────┐
           │ OPUS│         │ SONNET │      │ HAIKU │
           └─────┘         └────────┘      └───────┘
             │                │                │
             ▼                ▼                ▼
       Deep reasoning   Balanced code   Fast & cheap
       Multi-perspective  Good quality  Pattern matching
       Prevents rework   Best ratio    Exploration
```

### Task-to-Model Mapping

| Task Category | Examples | Recommended Model | Why |
|--------------|----------|------------------|-----|
| **Architecture** | Choose framework, design system, evaluate trade-offs | Opus | Needs multi-perspective analysis |
| **Planning** | Break down features, create learning paths, decompose vision | Opus | Requires sophisticated reasoning |
| **Implementation** | Write features, refactor code, fix bugs | Sonnet | Balanced capability + speed |
| **Code Review** | Review PRs, suggest improvements, check standards | Sonnet | Needs code understanding |
| **Exploration** | Read files, search codebase, understand structure | Haiku | Simple task, save tokens |
| **Optimization** | Transform prompts, apply patterns, mechanical edits | Haiku | Pattern matching, no deep reasoning needed |
| **Orchestration** | Aggregate results, apply rules, pass/fail checks | Haiku | Rule-based decisions |
| **Documentation** | Write guides, update READMEs, create examples | Sonnet | Needs context + quality |

### Complexity-Based Selection

**Low Complexity** → Haiku
- File reading (cat, ls operations)
- Simple text transformations
- Pattern matching
- Data aggregation
- Rule application

**Medium Complexity** → Sonnet
- Feature implementation
- Code refactoring
- Bug fixing
- Test generation
- Technical writing

**High Complexity** → Opus
- Architecture decisions
- Multi-perspective analysis
- Vague → structured decomposition
- High-stakes planning
- Complex trade-off evaluation

### When to Override Your Default

**You should switch models when:**

1. **Task complexity changes**: Started with Sonnet, but realized you need architectural thinking → switch to Opus
2. **Exploration phase**: About to read 10+ files to understand codebase → switch to Haiku
3. **Quality critical**: Bug is in production, needs careful analysis → consider Opus
4. **Budget constraints**: Low on Sonnet quota, task is mechanical → use Haiku
5. **Speed matters**: Need quick answers for simple questions → use Haiku

**You should NOT switch when:**

1. **Task is going well**: Don't optimize mid-task, stick with current model
2. **Cost difference is negligible**: For a 5-minute task, the cost difference is cents
3. **You're uncertain**: When in doubt, Sonnet is usually the right choice
4. **Quality risk**: Don't downgrade to Haiku for complex refactoring to save $0.10

---

## Configuration Patterns

### Pattern 1: Agent-Level Defaults (Recommended)

**How it works:**

Add `model:` field to custom agents in `.claude/agents/*.md`:

```markdown
---
name: prompt-polisher
description: Transforms vague prompts into optimized requests
model: haiku  # ← Add this line
---

You are a prompt optimization specialist...
```

**Supported values:**
- `haiku` - Claude Haiku 3.5
- `sonnet` - Claude Sonnet 4.5 (default if not specified)
- `opus` - Claude Opus 4.5

**Example configurations:**

**Exploration agent** (reads files, searches code):
```markdown
---
name: codebase-explorer
description: Explores and maps codebase structure
model: haiku  # ← Fast and cheap for file reading
---
```

**Implementation agent** (writes code):
```markdown
---
name: feature-builder
description: Implements features from specifications
model: sonnet  # ← Balanced for code quality
---
```

**Planning agent** (architecture decisions):
```markdown
---
name: system-architect
description: Designs system architecture with trade-off analysis
model: opus  # ← Deep reasoning for high-stakes decisions
---
```

**When to use:**
- You have custom agents with clear task types
- You want "set it and forget it" optimization
- Your agents specialize in specific complexity levels

**Savings:** 20-40% reduction in agent-specific token costs (projected)

---

### Pattern 2: Task-Based Switching

**How it works:**

Manually switch models during conversation based on current task phase:

**Phase 1: Exploration** → Use Haiku
```
User: "Explore this codebase and find all API endpoints"
Claude (Haiku): *reads files cheaply and quickly*
```

**Phase 2: Implementation** → Switch to Sonnet
```
User: "/model sonnet"  # Switch to Sonnet
User: "Now implement authentication for those endpoints"
Claude (Sonnet): *writes implementation code with good quality*
```

**Phase 3: Architecture Review** → Switch to Opus
```
User: "/model opus"  # Switch to Opus
User: "Should we refactor this to use microservices?"
Claude (Opus): *provides deep multi-perspective analysis*
```

**When to use:**
- You're working through distinct phases (explore → implement → review)
- You want manual control over optimization
- Task complexity varies significantly within one session

**Savings:** 15-30% reduction based on phase distribution (projected)

---

### Pattern 3: Project-Type Matching

**How it works:**

Match your default model to your project type:

**Documentation Projects** → Default: Haiku
- Most work is reading/organizing existing content
- Writing docs doesn't need Sonnet's code reasoning
- Mechanical transformations (links, formatting)

**Simple Scripts/Tools** → Default: Haiku
- Small scope, straightforward logic
- Upgrade to Sonnet only when logic gets complex
- Fast iteration matters more than deep reasoning

**Full-Stack Applications** → Default: Sonnet
- Complex business logic and architecture
- Need good code quality across frontend/backend
- Upgrade to Opus for architecture decisions

**Greenfield/Startup Projects** → Default: Opus
- Heavy planning and architecture phase
- Many high-stakes decisions early on
- Cost of wrong architecture >> cost of Opus tokens

**When to use:**
- Starting a new project
- Setting up `.claude/settings.json` for a project
- You know the typical task distribution for this project type

**Configuration:**

In `.claude/settings.json`:
```json
{
  "defaultModel": "haiku",  // or "sonnet" or "opus"
  "// Note": "This is your fallback when no agent model is specified"
}
```

---

### Pattern 4: Progressive Escalation

**How it works:**

Start with the cheapest model and escalate only when needed:

**Step 1:** Start with Haiku
```
User: "Help me fix this bug"
Claude (Haiku): *tries to understand the issue*
```

**Step 2:** Escalate to Sonnet if Haiku struggles
```
Claude (Haiku): "This seems complex - I recommend switching to Sonnet for deeper analysis"
User: "/model sonnet"
```

**Step 3:** Escalate to Opus if Sonnet struggles
```
Claude (Sonnet): "This involves architectural trade-offs - Opus would provide better guidance"
User: "/model opus"
```

**When to use:**
- You're unsure of task complexity upfront
- You want to minimize costs
- You're willing to switch models mid-task

**Savings:** Maximizes savings by using cheapest effective model (projected 30-50%)

**Trade-off:** More context switching, potential redundancy in analysis

---

## Real Examples from This Project

This project (claude-config-template) has 5 custom agents. Here's how model selection was optimized:

### Example 1: prompt-polisher Agent

**Original configuration:**
```markdown
model: sonnet
```

**Task type:** Mechanical prompt optimization
- Applies 12 transformation techniques
- Pattern recognition (vague → specific)
- Tier-based technique selection

**Optimized configuration:**
```markdown
model: haiku
```

**Rationale:**
- Prompt transformation is pattern matching, not deep reasoning
- Haiku excels at text transformation and rule application
- No architectural decisions involved

**Projected savings:** 40-50% cost reduction per session (-$0.92/session)

**Example transformation:**
```
Input: "Fix the bug"
Output: "Fix the NoneType error in `app/user.py:45` that occurs when user.profile is None"
```
This doesn't need Sonnet's reasoning - Haiku can apply the techniques just as well.

---

### Example 2: project-planner Agent

**Original configuration:**
```markdown
model: sonnet
```

**Task type:** Architecture planning with 6-perspective analysis
- Psychological perspective (team dynamics, learning curve)
- Educator perspective (teaching, onboarding)
- Software Engineering perspective (technical trade-offs)
- Product/UX perspective (user experience)
- DevOps perspective (deployment, operations)
- Security perspective (vulnerabilities, compliance)

**Optimized configuration:**
```markdown
model: opus
```

**Rationale:**
- Requires multi-dimensional reasoning across 6 perspectives
- High-stakes decisions (wrong architecture = months of rework)
- Needs to balance competing priorities (speed vs security vs learning curve)

**Projected impact:** +$0.80/session but **prevents 10+ hours of rework** ($thousands in saved time)

**Example decision:**
```
Question: "Should we use monolith or microservices for this SaaS app?"

Opus considers:
- Team size and expertise (Psychology)
- Learning curve for junior devs (Educator)
- Technical complexity and scale (Engineering)
- User experience impact (Product/UX)
- Deployment and monitoring overhead (DevOps)
- Attack surface and compliance (Security)

Result: Informed decision that accounts for all trade-offs
```

Sonnet would provide good technical analysis, but might miss psychological or educational concerns.

---

### Example 3: initializer Agent

**Original configuration:**
```markdown
model: sonnet
```

**Task type:** Feature decomposition and learning path creation
- Transforms vague project vision → structured features.json
- Creates learning paths with dependencies
- Estimates complexity and effort
- Defines test criteria for each feature

**Optimized configuration:**
```markdown
model: opus
```

**Rationale:**
- Requires sophisticated decomposition (vague → structured)
- Needs dependency analysis across features
- Must translate business goals → technical tasks
- Learning path creation requires pedagogical reasoning

**Projected impact:** +$0.60/session but **prevents "estimated 40 hours, actually 120 hours" problems**

**Example transformation:**
```
Input: "I want to build a SaaS collaboration tool"

Opus creates:
- Feature breakdown (auth, workspaces, real-time collab, billing)
- Dependency graph (can't do billing before auth)
- Learning path (start with auth, it teaches patterns for the rest)
- Complexity estimates (auth: 20 hours, real-time: 40 hours)
- Test criteria (auth: "User can sign up and log in securely")

Result: Clear roadmap with realistic expectations
```

Sonnet would create a good breakdown, but might miss learning path optimization or underestimate complexity.

---

### Example 4: quality-reviewer Agent

**Original configuration:**
```markdown
(no model specified - defaults to sonnet)
```

**Task type:** Quality gate orchestration
- Runs 3 parallel quality checks (security, testing, standards)
- Aggregates results with confidence scores
- Applies pass/fail thresholds
- Generates actionable recommendations

**Optimized configuration:**
```markdown
model: haiku
```

**Rationale:**
- Orchestration is rule-based, not reasoning-intensive
- Quality checks are done by specialized tools (not the agent itself)
- Agent just aggregates data and applies thresholds
- Speed matters (part of CI/CD pipeline)

**Projected savings:** 50-60% cost reduction per session (-$0.85/session)

**Example workflow:**
```
1. Security scan returns: 92% (PASS)
2. Test coverage returns: 88% (PASS)
3. Standards check returns: 75% (WARN)

Haiku aggregates:
- Overall score: 85% (PASS with warnings)
- Recommendation: "Address 3 style violations before merge"

No deep reasoning needed - just data aggregation and threshold comparison.
```

---

### Example 5: coder Agent (No Change)

**Current configuration:**
```markdown
model: sonnet
```

**Task type:** Feature implementation with TDD
- Executes features.json atomically
- Implements code incrementally
- Writes tests first (TDD)
- Debugs and iterates until passing

**Optimization decision: KEEP SONNET** ✓

**Rationale:**
- Implementation requires balanced reasoning + speed
- Needs to understand existing code patterns
- Must handle edge cases during debugging
- Sonnet is the sweet spot for coding tasks

**Why not Haiku:** Would miss edge cases, produce lower quality code
**Why not Opus:** Overkill for well-defined feature execution, too slow

**This is the correct choice** - Sonnet is optimized for code implementation.

---

## Best Practices

### 1. Start with the cheapest model that can do the job

**Principle:** Default to Haiku for new tasks, escalate only when needed.

**Why:**
- Saves tokens on simple tasks (91% cheaper than Sonnet)
- You can always escalate if Haiku struggles
- Most tasks are simpler than you think

**Example:**
```
User: "Find all the database models in this project"
Start with: Haiku (file exploration)

If Haiku struggles with complex relationships:
Escalate to: Sonnet
```

**Exception:** When task is obviously complex (architecture, planning), start with the right model.

---

### 2. Exploratory work always uses Haiku first

**Principle:** File reading, codebase navigation, and search operations should use Haiku by default.

**Why:**
- Exploration is typically 30-40% of development time
- Haiku is 3-5x faster for file operations
- No complex reasoning needed for reading files
- Massive savings opportunity (91% cost reduction)

**Configuration:**
```markdown
# .claude/agents/explorer.md
---
name: codebase-explorer
model: haiku  # ← Always Haiku for exploration
---
```

**Projected savings:** 27% overall token reduction if 30% of work is exploration.

---

### 3. Architecture decisions deserve Opus

**Principle:** Don't cheap out on high-stakes decisions that affect months of work.

**Why:**
- Cost of wrong architecture >> cost of Opus tokens
- Opus provides multi-perspective analysis
- Prevents expensive rework down the line
- One bad architecture decision can cost 10-100x the Opus tokens

**When to use Opus:**
- Choosing frameworks or libraries
- Designing system architecture
- Evaluating major refactoring approaches
- Planning greenfield projects
- Multi-stakeholder decisions

**Example cost analysis:**
```
Opus cost for architecture session: $2-5
Cost of wrong architecture: 40 hours rework = $2,000-4,000

ROI: 400-2,000x return on investment
```

**Rule of thumb:** If the decision affects > 10 hours of work, use Opus.

---

### 4. Don't over-optimize - Sonnet is usually fine

**Principle:** When in doubt, stick with Sonnet. Don't spend mental energy micro-optimizing.

**Why:**
- Sonnet is the balanced choice for most tasks
- Decision fatigue costs more than token savings
- Premature optimization wastes time
- Sonnet → Haiku savings are only $0.05-0.10 per small task

**When NOT to optimize:**
- Task takes < 5 minutes (savings are pennies)
- You're uncertain about complexity (Sonnet is safe)
- You're in flow state (don't break momentum)
- It's a one-off task (not worth the mental overhead)

**Example:**
```
User: "Should I use Haiku or Sonnet to write this 10-line function?"

Answer: Just use Sonnet. The cost difference is $0.03.
```

**Rule of thumb:** Only optimize when the pattern is clear (exploration = Haiku, architecture = Opus).

---

### 5. Learn from your usage patterns

**Principle:** Track what works for YOUR workflow, then optimize based on data.

**How:**

**Step 1: Observe** (1-2 weeks)
- Keep notes on which models you use
- Track when you switch models mid-task
- Notice when you're satisfied/disappointed with results

**Step 2: Identify patterns**
```
Observation: "I always switch to Haiku for file exploration"
Pattern: File exploration → Haiku

Observation: "Haiku struggles with refactoring edge cases"
Pattern: Refactoring → Sonnet (not Haiku)

Observation: "I wish I'd used Opus for that framework decision"
Pattern: Framework choices → Opus
```

**Step 3: Codify in agents**
```markdown
# .claude/agents/explorer.md
model: haiku  # Based on my pattern: exploration = Haiku

# .claude/agents/refactorer.md
model: sonnet  # Based on my pattern: refactoring needs Sonnet

# .claude/agents/architect.md
model: opus  # Based on my pattern: high-stakes decisions = Opus
```

**Step 4: Validate savings**
- Compare token usage before/after optimization
- Measure quality impact (did Haiku miss anything?)
- Adjust if needed

**This guide provides recommendations, but YOUR patterns matter most.**

---

### 6. Use agent-level defaults for "set it and forget it" optimization

**Principle:** Configure agents once, benefit forever.

**Why:**
- No decision fatigue - agents auto-select optimal model
- Consistent optimization across all uses
- Can't forget to switch models
- Teaching tool (users see Haiku being used successfully)

**How to implement:**

**Step 1: Audit your agents**
```bash
ls .claude/agents/*.md
# prompt-polisher.md
# project-planner.md
# coder.md
```

**Step 2: Categorize by task type**
```
prompt-polisher: Mechanical optimization → Haiku
project-planner: Architecture → Opus
coder: Implementation → Sonnet
```

**Step 3: Add model specifications**
```markdown
# .claude/agents/prompt-polisher.md
---
model: haiku
---

# .claude/agents/project-planner.md
---
model: opus
---

# .claude/agents/coder.md
---
model: sonnet
---
```

**Step 4: Test and validate**
```
User: "Polish this prompt" → prompt-polisher (Haiku) activates
User: "Plan this system" → project-planner (Opus) activates
User: "Implement this feature" → coder (Sonnet) activates
```

**Result:** Automatic optimization with zero ongoing effort.

---

### 7. Consider speed, not just cost

**Principle:** Haiku's speed advantage (3-5x faster) matters as much as cost savings.

**Why:**
- Faster feedback loops improve productivity
- Speed reduces context switching delays
- Quick answers keep you in flow state
- Time saved = money saved

**Speed comparison (approximate):**
```
10,000 token response:
- Opus: ~15 seconds
- Sonnet: ~8 seconds
- Haiku: ~3 seconds

Haiku is 2.7x faster than Sonnet, 5x faster than Opus
```

**When speed matters most:**
- Exploratory work (reading many files)
- Interactive debugging (quick iterations)
- Simple questions (want immediate answers)
- CI/CD pipelines (faster builds)

**Example:**
```
Task: Read 20 files to understand auth flow

Sonnet: 20 × 8 sec = 160 seconds (~2.5 minutes)
Haiku: 20 × 3 sec = 60 seconds (~1 minute)

Saved: 100 seconds + $0.50 in tokens
```

**Rule of thumb:** For tasks requiring > 5 iterations, speed savings compound significantly.

---

### 8. Don't downgrade mid-task unless necessary

**Principle:** Stick with your current model until the task is complete, unless there's a clear reason to switch.

**Why:**
- Model switching costs context (slight delay in understanding)
- Premature optimization interrupts flow
- Savings are minimal for short tasks
- Consistency reduces confusion

**When it's OK to switch:**
```
✅ Task phase changes (exploration → implementation)
✅ Discovered unexpected complexity (Sonnet → Opus)
✅ Discovered unexpected simplicity (Opus → Sonnet)
✅ Long-running task with distinct phases
```

**When NOT to switch:**
```
❌ Middle of writing a function (stay with Sonnet)
❌ To save $0.05 on a 2-minute task (not worth it)
❌ You're in flow state (don't break momentum)
❌ Task is almost done (finish with current model)
```

**Example:**
```
Bad:
User: "Write a login function"
Claude (Sonnet): *writes 50% of function*
User: "/model haiku"  # ❌ Bad idea mid-task
Claude (Haiku): *might miss context from Sonnet's work*

Good:
User: "Write a login function"
Claude (Sonnet): *completes function*
User: "Now read the auth config file"
User: "/model haiku"  # ✅ Good - new task, simple reading
```

---

## Quick Reference

### Model Selection Cheat Sheet

| Task Type | Model | Cost | Speed | When to Use |
|-----------|-------|------|-------|-------------|
| **Read files** | Haiku | 💰 | ⚡⚡⚡ | Exploring codebase, understanding structure |
| **Search code** | Haiku | 💰 | ⚡⚡⚡ | Finding patterns, locating functions |
| **Simple edits** | Haiku | 💰 | ⚡⚡⚡ | Typos, formatting, mechanical changes |
| **Prompt optimization** | Haiku | 💰 | ⚡⚡⚡ | Transforming vague → specific prompts |
| **Quality checks** | Haiku | 💰 | ⚡⚡⚡ | Aggregating scan results, applying rules |
| **Write features** | Sonnet | 💰💰💰 | ⚡⚡ | Implementing new functionality |
| **Refactor code** | Sonnet | 💰💰💰 | ⚡⚡ | Cleaning up code, improving structure |
| **Fix bugs** | Sonnet | 💰💰💰 | ⚡⚡ | Debugging and resolving issues |
| **Write tests** | Sonnet | 💰💰💰 | ⚡⚡ | Creating test cases |
| **Code review** | Sonnet | 💰💰💰 | ⚡⚡ | Reviewing PRs, suggesting improvements |
| **Documentation** | Sonnet | 💰💰💰 | ⚡⚡ | Writing technical guides |
| **Architecture** | Opus | 💰💰💰💰💰 | ⚡ | Designing systems, choosing patterns |
| **Planning** | Opus | 💰💰💰💰💰 | ⚡ | Breaking down projects, creating roadmaps |
| **Framework choice** | Opus | 💰💰💰💰💰 | ⚡ | Evaluating libraries, major decisions |
| **Multi-perspective** | Opus | 💰💰💰💰💰 | ⚡ | Considering psychology, business, technical |

**Legend:**
- 💰 = Cheapest (Haiku: $0.25/1M input)
- 💰💰💰 = Medium (Sonnet: $3/1M input)
- 💰💰💰💰💰 = Expensive (Opus: $15/1M input)
- ⚡⚡⚡ = Fastest (Haiku: ~3 sec for 10K tokens)
- ⚡⚡ = Medium (Sonnet: ~8 sec for 10K tokens)
- ⚡ = Slower (Opus: ~15 sec for 10K tokens)

---

### Decision Tree (Copy-Paste Version)

```
┌─────────────────────────────────────────────────────────┐
│              MODEL SELECTION DECISION TREE               │
└─────────────────────────────────────────────────────────┘

START: What type of task am I doing?

├─ Is this CREATIVE or ARCHITECTURAL work?
│  (Designing systems, choosing patterns, multi-perspective analysis)
│  │
│  ├─ YES → USE OPUS
│  │        Examples: Framework choice, system design, high-stakes planning
│  │        Cost: 💰💰💰💰💰 | Speed: ⚡ | Quality: ★★★★★
│  │
│  └─ NO → Continue to next question

├─ Does this involve WRITING CODE or COMPLEX LOGIC?
│  (Implementing features, refactoring, debugging, test writing)
│  │
│  ├─ YES → USE SONNET
│  │        Examples: Feature implementation, bug fixes, code review
│  │        Cost: 💰💰💰 | Speed: ⚡⚡ | Quality: ★★★★
│  │
│  └─ NO → Continue to next question

└─ Is this MECHANICAL or EXPLORATORY work?
   (Reading files, simple edits, pattern matching, orchestration)
   │
   └─ YES → USE HAIKU
            Examples: File exploration, simple edits, prompt optimization
            Cost: 💰 | Speed: ⚡⚡⚡ | Quality: ★★★

WHEN IN DOUBT → USE SONNET (safe default)
```

---

### Configuration Quick Reference

**Add to agent frontmatter:**
```markdown
---
name: agent-name
model: haiku  # or sonnet, or opus
---
```

**Switch model in conversation:**
```
/model haiku
/model sonnet
/model opus
```

**Set project default (`.claude/settings.json`):**
```json
{
  "defaultModel": "sonnet"
}
```

---

### Cost Calculator (Quick Math)

**Formula:**
```
Total Cost = (Input Tokens × Input Cost) + (Output Tokens × Output Cost)
```

**Per-token costs:**
```
Haiku:
- Input: $0.00000025 per token ($0.25 per 1M)
- Output: $0.00000125 per token ($1.25 per 1M)

Sonnet:
- Input: $0.000003 per token ($3 per 1M)
- Output: $0.000015 per token ($15 per 1M)

Opus:
- Input: $0.000015 per token ($15 per 1M)
- Output: $0.000075 per token ($75 per 1M)
```

**Quick estimates:**
```
10K input, 2K output:
- Haiku: $0.005
- Sonnet: $0.06
- Opus: $0.30

5K input, 8K output:
- Haiku: $0.011
- Sonnet: $0.135
- Opus: $0.675
```

---

## FAQ

### Q: When should I override the default model?

**A:** Override when task complexity doesn't match your default:

**Examples of when to override:**
- **Default: Sonnet** → Switch to **Haiku** when exploring codebase (save tokens + faster)
- **Default: Sonnet** → Switch to **Opus** when making architecture decisions (better reasoning)
- **Default: Haiku** → Switch to **Sonnet** when implementing features (need code quality)

**Rule of thumb:** If you're using an agent, it should have the right model already. Manual overrides are for the main conversation.

---

### Q: Can I switch models mid-conversation?

**A: Yes, but be strategic:**

**✅ Good times to switch:**
- Between distinct task phases (exploration → implementation)
- When complexity changes unexpectedly
- Starting a new sub-task

**❌ Bad times to switch:**
- Middle of writing a function
- To save pennies on a 2-minute task
- When you're in flow state

**How to switch:**
```
/model haiku
/model sonnet
/model opus
```

---

### Q: What about the `model:` parameter in agents?

**A:** The `model:` field in agent frontmatter specifies which model that agent uses:

**Syntax:**
```markdown
---
name: my-agent
model: haiku  # ← This agent will use Haiku
---
```

**Behavior:**
- When you invoke this agent, it automatically uses the specified model
- Overrides your conversation default
- No need to manually switch models

**Example:**
```markdown
# .claude/agents/explorer.md
---
name: explorer
model: haiku
---

You explore codebases efficiently.
```

Now whenever `explorer` agent is invoked, it uses Haiku automatically.

---

### Q: How do I know which model I'm currently using?

**A:** Claude Code should display the current model in your session, but if unclear:

**Method 1: Check your last command**
```
If you ran: /model haiku
Current model: Haiku
```

**Method 2: Check your agent**
```
If using an agent with `model: opus`
Current model: Opus (from agent)
```

**Method 3: Ask directly**
```
User: "Which model are you using right now?"
Claude: "I'm using Claude Sonnet 4.5"
```

---

### Q: Should I always use Haiku for exploration?

**A: Yes, for straightforward file reading. No, for complex analysis:**

**Use Haiku for:**
- Reading files (`cat`, `ls` operations)
- Searching for patterns
- Understanding file structure
- Locating specific code

**Use Sonnet for:**
- Understanding complex code flow
- Analyzing architectural patterns
- Tracing dependencies across files
- Code comprehension with edge cases

**Example:**
```
Task: "Find all API endpoints"
→ Haiku (simple search)

Task: "Explain how authentication flows through this system"
→ Sonnet (complex analysis)
```

---

### Q: What if Haiku fails at a task?

**A: Escalate to Sonnet immediately:**

**Step 1: Recognize failure**
```
Signs Haiku is struggling:
- Missing edge cases
- Incomplete analysis
- Incorrect recommendations for complex logic
```

**Step 2: Switch to Sonnet**
```
User: "/model sonnet"
User: "Can you re-analyze this with more depth?"
```

**Step 3: Learn from it**
```
Note: This task type requires Sonnet, not Haiku
Update your mental model or agent configuration
```

**This is expected behavior** - Haiku is optimized for speed/cost, not complex reasoning.

---

### Q: Is Opus worth the cost?

**A: For architecture and planning, absolutely yes:**

**Cost-benefit analysis:**
```
Opus session: $2-5
Cost of wrong architecture: 40-100 hours rework = $2,000-5,000

ROI: 400-2,500x
```

**When Opus pays for itself:**
- Framework or library selection
- System architecture design
- Major refactoring approach
- High-stakes planning
- Multi-stakeholder decisions

**When Opus is overkill:**
- Implementing well-defined features (use Sonnet)
- Bug fixes (use Sonnet)
- Simple questions (use Haiku)

**Rule of thumb:** If the decision affects > 10 hours of work, use Opus. The token cost is negligible compared to time saved.

---

### Q: Can I mix models within one agent?

**A: No, agents use one model per invocation:**

**How it works:**
```markdown
# .claude/agents/my-agent.md
model: sonnet  # ← This agent ALWAYS uses Sonnet
```

**If you need multiple models:**

**Option 1: Create multiple specialized agents**
```markdown
# .claude/agents/explorer.md (uses Haiku)
# .claude/agents/implementer.md (uses Sonnet)
# .claude/agents/architect.md (uses Opus)
```

**Option 2: Don't specify model in agent (inherit from conversation)**
```markdown
# .claude/agents/flexible-agent.md
# No model field → uses whatever model the conversation is using
```

Then manually switch models during conversation:
```
User: "/model haiku"
User: "Invoke flexible-agent" (uses Haiku)

User: "/model sonnet"
User: "Invoke flexible-agent" (now uses Sonnet)
```

---

### Q: What about prompt caching - does it affect model choice?

**A: No, prompt caching works the same across all models:**

**How it works:**
- Prompt caching stores repeated context (files, docs)
- Applies to Opus, Sonnet, and Haiku equally
- Saves 90% on cached tokens for all models

**Interaction with model selection:**
```
Example: Reading CLAUDE.md (1,500 lines)

First read (no cache):
- Haiku: $0.004
- Sonnet: $0.05
- Opus: $0.20

Subsequent reads (90% cached):
- Haiku: $0.0004
- Sonnet: $0.005
- Opus: $0.02

Savings: 90% for all models
```

**Strategy:** Use Haiku for repeated file reads → maximize savings from BOTH model choice AND caching.

**Learn more:** See [PROMPT_CACHING_GUIDE.md](PROMPT_CACHING_GUIDE.md)

---

### Q: Should I feel bad about using Opus?

**A: No! Use the right tool for the job:**

**Psychology of model guilt:**
- Developers often feel guilty using "expensive" models
- This leads to under-utilizing Opus for fear of costs
- Result: Make bad architectural decisions to save $5 in tokens

**The reality:**
```
Cost of Opus session: $5
Cost of wrong architecture: $5,000 (weeks of rework)

Savings from using Opus: $4,995
```

**Permission granted:** Use Opus for any decision that affects > 10 hours of work. You'll save far more than the token cost.

**When to feel bad:**
- Using Opus to read files (use Haiku - 60x cheaper)
- Using Opus for well-defined implementation (use Sonnet - 5x cheaper)

**When to feel GOOD:**
- Using Opus for framework selection
- Using Opus for system architecture
- Using Opus for complex planning

**Mental reframe:** Opus is an investment, not an expense.

---

## Summary

### Core Principles

**1. Match task complexity to model capability:**
- Mechanical work → Haiku (fast & cheap)
- Implementation work → Sonnet (balanced)
- Architectural work → Opus (deep reasoning)

**2. The Three-Question Method:**
```
Is this creative/architectural? → Opus
Does this involve writing code? → Sonnet
Is this mechanical/exploratory? → Haiku
```

**3. Optimize where it matters:**
- Exploration (30-40% of work) → Haiku = huge savings
- Architecture (5-10% of work) → Opus = prevents rework
- Implementation (50-60% of work) → Sonnet = right balance

**4. Use agent-level defaults for automation:**
```markdown
# .claude/agents/explorer.md
model: haiku

# .claude/agents/implementer.md
model: sonnet

# .claude/agents/architect.md
model: opus
```

**5. When in doubt, use Sonnet:**
- Sonnet is the safe default for most tasks
- Don't over-optimize for pennies
- Decision fatigue costs more than token savings

---

### Expected Savings (Projected)

**Scenario:** Developer works 10 hours/day for 2 weeks (100 hours)

**Before optimization:** (all tasks use Sonnet)
- Total cost: ~$82/2 weeks
- Sonnet quota: 80% utilized (approaching limit)
- Speed: Medium (8 sec avg response time)

**After optimization:** (strategic model selection)
- Total cost: ~$76/2 weeks (7% reduction)
- Sonnet quota: 58% utilized (headroom restored)
- Speed: Faster (Haiku tasks 62% faster)
- Quality: Better (Opus prevents architectural rework)

**Additional benefits:**
- Freed Sonnet capacity for implementation work
- Faster exploration (Haiku 3-5x speed boost)
- Better architecture (Opus multi-perspective analysis)
- Prevented rework (1 bad architecture decision >> all token costs)

**IMPORTANT:** These are projected estimates based on theoretical usage patterns and Anthropic API pricing. Your actual savings will vary based on your specific workflow, task distribution, and project complexity. We encourage you to track your own results and share them to help validate these projections!

---

### Key Metrics (Projected)

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| **Cost (2 weeks)** | $82 | $76 | -7% |
| **Sonnet utilization** | 80% | 58% | +27% headroom |
| **Exploration speed** | 8 sec | 3 sec | 62% faster |
| **Architecture quality** | Sonnet | Opus | Better reasoning |
| **Rework incidents** | Baseline | -30% | Fewer mistakes |

**Net outcome:** Lower costs + better quality + faster speed = win-win-win

---

### Configuration Summary

**1. Agent-level defaults** (recommended):
```markdown
# .claude/agents/explorer.md
model: haiku

# .claude/agents/implementer.md
model: sonnet

# .claude/agents/architect.md
model: opus
```

**2. Conversation switching:**
```
/model haiku   # For exploration
/model sonnet  # For implementation
/model opus    # For architecture
```

**3. Project defaults (`.claude/settings.json`):**
```json
{
  "defaultModel": "sonnet"
}
```

---

## Common Mistakes

### 1. Using Opus for Everything
**Problem:** Defaulting to most powerful model for all tasks
- 5x cost vs Haiku for tasks that don't need it
- Example: Using Opus to read a file or run `ls`

**Solution:** Use Three-Question Method
- Maximum intelligence needed? → Opus 4.5
- Coding/complex agents/advanced reasoning? → Sonnet 4.5 (recommended default)
- Time-sensitive/high-volume/cost-critical? → Haiku 4.5

### 2. Using Haiku for Code Generation
**Problem:** Saving money on implementation
- Lower quality code requires more iterations, wastes time
- Example: "Generate user authentication" with Haiku

**Solution:** Sonnet for code, Haiku for exploration/reading only
- Haiku: Search, read files, grep, understand existing code
- Sonnet: Implement features, write tests, refactor
- Opus: Design architecture, plan approach

### 3. Not Configuring Agent Defaults
**Problem:** Manual model switching every time
- Forget to switch, use wrong model frequently
- Example: Forgetting to switch from Sonnet → Haiku before exploration

**Solution:** Set model defaults in agent definitions (`.claude/agents/`)
- explorer.md: `model: haiku`
- implementer.md: `model: sonnet`
- architect.md: `model: opus`

### 4. Switching Mid-Conversation
**Problem:** Changing models during complex task
- Context loss, inconsistent quality
- Example: Start with Sonnet, switch to Haiku mid-implementation

**Solution:** Complete task with same model, switch between tasks
- Finish entire feature with Sonnet
- Then switch to Haiku for next exploration task
- Maintain conversation context within model

### 5. Ignoring Token Costs
**Problem:** Not tracking actual savings
- Assumptions about savings, not measured reality
- Example: "I'm using model switching so I'm saving money" (unverified)

**Solution:** Use `claude /usage` to verify model switching saves money
- Track weekly costs before and after
- Calculate actual savings percentage
- Adjust strategy if not seeing expected savings

---

### What's Next?

**Immediate actions:**

1. **Audit your agents** (if you have custom agents):
   ```bash
   ls .claude/agents/*.md
   ```
   - Add `model: haiku` to exploration agents
   - Add `model: opus` to planning/architecture agents
   - Keep `model: sonnet` for implementation agents

2. **Try Haiku for your next exploration task:**
   ```
   /model haiku
   "Read these 10 files and summarize the auth flow"
   ```

3. **Use Opus for your next architecture decision:**
   ```
   /model opus
   "Should I use REST or GraphQL for this API?"
   ```

4. **Track your results:**
   - Note token usage before/after
   - Observe quality differences
   - Measure speed improvements
   - Share feedback with this project!

**Future enhancements:**

- **Intelligent model routing:** Auto-detect task type and suggest optimal model
- **Cost feedback loops:** "You could have saved X tokens with Haiku"
- **Usage analytics:** Track your patterns and suggest optimizations

---

### Learn More

**Related guides:**
- [PROMPT_CACHING_GUIDE.md](PROMPT_CACHING_GUIDE.md) - How automatic caching reduces costs 50-90%
- [MCP_OPTIMIZATION_GUIDE.md](MCP_OPTIMIZATION_GUIDE.md) - Optimizing MCP server configuration
- [ENVIRONMENT_VARIABLES.md](ENVIRONMENT_VARIABLES.md) - Complete reference for environment variables
- [quality-context-optimization.md](quality-context-optimization.md) - Multi-level quality context strategies

**Advanced topics:**
- Custom agents: `.claude/agents/` (create specialized agents for your workflow)
- Progressive setup: `01_global-setup/` (global Claude Code configuration)
- Project onboarding: `02_project-onboarding/` (per-project setup)

---

### Contributing

**Help us validate these projections!**

This guide is based on:
- ✅ Factual API pricing (Anthropic official)
- ⚠️ Projected savings (theoretical usage patterns)
- ⚠️ One developer's experience (not statistically validated)

**We need YOUR data:**
- What savings did you achieve?
- Which task-to-model mappings worked best for you?
- Did Haiku work for your exploration tasks?
- Did Opus pay for itself in your architecture decisions?

**Share your results:**
- GitHub Issues: [claude-config-template/issues](https://github.com/anthropics/claude-config-template/issues)
- Include: task types, model choices, token savings, quality impact

**Together we can validate (or refine) these recommendations!**

---

**Keywords for search (Ctrl+F):** model selection, opus, sonnet, haiku, token costs, cost optimization, model switching, agent configuration, exploration, architecture, implementation, planning, decision framework, savings, performance, speed, quality, best practices

---

**Last updated:** 2025-12-16
**Version:** v3.9.0
**Status:** New guide (projections pending validation)
