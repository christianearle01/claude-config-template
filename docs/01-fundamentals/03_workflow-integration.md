# Workflow Integration Guide

**The Big Picture:** How templates, commands, skills, and agents work together in Claude Code

**Time to read:** 15 minutes
**Purpose:** Understand the complete Claude Code ecosystem and how each piece connects

---

## Why This Matters

**Without understanding workflow integration:**
- Use tools in isolation (missing 40-50% of their power through combination)
- Don't know which tool to reach for when ("Should I use a skill or agent?")
- Miss optimization opportunities (tools working together = greater than sum of parts)
- Duplicate effort (manually doing what tools can automate)

**With workflow integration knowledge:**
- Know exactly which tool fits each situation
- Leverage tool combinations for 2-3× productivity gains
- Understand the "happy path" from idea → shipped feature
- Avoid common workflow anti-patterns

**Time investment:** 15 minutes to understand the system
**Benefit:** 40-50% productivity increase through optimal tool usage

---

## The 4 Layers of Claude Code Optimization

Think of Claude Code as a 4-layer stack, where each layer builds on the previous:

```
Layer 4: AGENTS (Complex, multi-step tasks)
         ↑ calls/uses
Layer 3: SKILLS (Domain-specific automation)
         ↑ calls/uses
Layer 2: SLASH COMMANDS (Quick operations)
         ↑ reads
Layer 1: PROJECT CONTEXT (CLAUDE.md, settings.json)
```

### Layer 1: Project Context (Foundation)

**What:** Persistent information about your project

**Components:**
- `CLAUDE.md` - Business purpose, external APIs, coding conventions
- `.claude/settings.json` - Project-specific configuration
- `coding-standards.md` - Team coding patterns

**When to use:** Set up once per project, reference automatically

**Token savings:** 95% reduction on context queries (2,000-10,000 → 200-500 tokens)

---

### Layer 2: Slash Commands (Quick Operations)

**What:** Fast, single-purpose commands for common tasks

**Examples:**
- `/test` - Run test suite
- `/build` - Build and report errors
- `/review` - Code review
- `/model haiku` - Switch to cheaper model

**When to use:** Repetitive tasks you do multiple times per day

**Speed:** Instant (no exploration needed)

---

### Layer 3: Skills (Domain Automation)

**What:** Auto-activating helpers for specific domains

**Examples:**
- `testing-workflow` - Analyzes test results, suggests fixes
- `api-debugging` - Diagnoses API errors
- `component-finder` - Locates React/Vue/Angular components
- `commit-readiness-checker` - Validates release criteria

**When to use:** Domain-specific questions ("Where is the login component?" → component-finder activates)

**Benefit:** 30-40% faster than manual exploration

---

### Layer 4: Agents (Complex Tasks)

**What:** Specialized sub-agents for multi-step workflows

**Examples:**
- `@project-planner` - Architect new projects (25-30 min)
- `@prompt-polisher` - Transform vague → specific prompts
- `@initializer` - Break projects into features with confidence scores
- `@coder` - Implement features with TDD
- `@quality-reviewer` - Security + testing + standards (parallel)

**When to use:** Complex, multi-step tasks requiring specialized expertise

**Power:** Handles 10-20 step workflows that would take hours manually

---

## How Layers Work Together

### Example: Adding a New Feature

```
1. YOU: "Add user authentication"
   → Too vague for good results

2. @prompt-polisher (LAYER 4: Agent)
   → Transforms vague request into architected brief
   → Output: Specific requirements, tech stack, steps

3. CLAUDE.md (LAYER 1: Context)
   → Agent reads your project's tech stack
   → Knows you're using React + Express + PostgreSQL

4. @initializer (LAYER 4: Agent)
   → Breaks "auth" into features:
     - feat-001: Login (confidence: 0.85)
     - feat-002: Registration (confidence: 0.88)
     - feat-003: Password Reset (confidence: 0.72)

5. @coder (LAYER 4: Agent)
   → Implements feat-001 with TDD
   → Reads CLAUDE.md for coding conventions (LAYER 1)

6. /test (LAYER 2: Command)
   → Run tests after implementation
   → testing-workflow skill (LAYER 3) analyzes results

7. @quality-reviewer (LAYER 4: Agent)
   → Runs security scanner, test generator, standards enforcer
   → All in parallel (57% faster)

8. commit-readiness-checker (LAYER 3: Skill)
   → Validates: version bumped? changelog updated? docs synced?
   → Drafts commit message

9. YOU: Create commit (Layer 2 implicit)
   → Git approval workflow triggers
   → Shows message, waits for approval
```

**Result:** Vague idea → Shipped feature with tests, security checks, and quality standards. Each layer played its role.

---

## Workflow #1: New Project Setup

**Scenario:** Starting a fresh project with Claude Code

**Step-by-step with layers:**

```
┌─────────────────────────────────────────────────┐
│  Phase 1: PROJECT PLANNING                      │
└─────────────────────────────────────────────────┘

1. Choose Your Persona (docs/00-start-here/personas/)
   → LAYER 1: Decide your learning path
   → Time: 2 minutes

2. [OPTIONAL] Use @project-planner Agent
   → LAYER 4: Get tech stack recommendations
   → Creates CLAUDE.md draft
   → Time: 25-30 minutes

┌─────────────────────────────────────────────────┐
│  Phase 2: PROJECT SETUP                         │
└─────────────────────────────────────────────────┘

3. Copy Configuration
   → LAYER 1: Copy .claude/ directory
   → Copy CLAUDE.md template
   → Time: 5 minutes

4. Document Business Context
   → LAYER 1: Fill in CLAUDE.md
   → What does this app DO? (business purpose)
   → Why each external API?
   → Time: 15 minutes

┌─────────────────────────────────────────────────┐
│  Phase 3: DEVELOPMENT LOOP                      │
└─────────────────────────────────────────────────┘

5. [OPTIONAL] Break into Features
   → LAYER 4: @initializer agent
   → Creates features.json with confidence scores
   → Time: 10 minutes

6. Implement Feature
   → LAYER 4: @coder agent (TDD workflow)
   → Reads CLAUDE.md for conventions (LAYER 1)
   → Time: Varies per feature

7. Run Tests
   → LAYER 2: /test command
   → LAYER 3: testing-workflow skill analyzes results
   → Time: 30 seconds

8. Code Review
   → LAYER 2: /review command
   → Checks against CLAUDE.md standards (LAYER 1)
   → Time: 1-2 minutes

┌─────────────────────────────────────────────────┐
│  Phase 4: QUALITY & COMMIT                      │
└─────────────────────────────────────────────────┘

9. Quality Check
   → LAYER 4: @quality-reviewer agent
   → Security + tests + standards (parallel)
   → Time: 15-30 seconds

10. Verify Commit Readiness
    → LAYER 3: commit-readiness-checker skill
    → Validates version, changelog, docs
    → Time: 5 seconds

11. Create Commit
    → LAYER 2: Git approval workflow
    → Shows message, waits for approval
    → Time: 30 seconds
```

**Total time:** 15-40 minutes per feature (varies by complexity)

---

## Workflow #2: Joining an Existing Project

**Scenario:** You're new to a project, need to get productive fast

```
1. Onboard Project (LAYER 1)
   → Copy .claude/ configuration
   → Create CLAUDE.md (document business purpose)
   → Time: 30-45 minutes
   → Guide: 02_project-onboarding/01_must-have/01_onboarding-guide.md

2. Explore Codebase (LAYER 3)
   → Ask: "Where is the authentication code?"
   → component-finder skill activates automatically
   → Time: 30 seconds (vs 10-15 min manual search)

3. Understand Feature (LAYER 2 + 3)
   → Ask: "How does login work in this project?"
   → Claude reads CLAUDE.md (LAYER 1)
   → Explains using project context
   → Time: 2 minutes

4. Make Changes (LAYER 4)
   → Use @coder agent for TDD workflow
   → Follows coding conventions from CLAUDE.md (LAYER 1)
   → Time: Varies

5. Validate Changes (LAYER 2 + 4)
   → /test (LAYER 2)
   → @quality-reviewer (LAYER 4)
   → Time: 1-2 minutes
```

---

## Workflow #3: Debugging an Issue

**Scenario:** Production bug needs fixing

```
1. Understand the Bug (LAYER 3)
   → Describe error: "API returns 500 on /users endpoint"
   → api-debugging skill activates
   → Provides diagnostic checklist
   → Time: 30 seconds

2. Locate the Code (LAYER 3)
   → Ask: "Where is the /users endpoint?"
   → component-finder skill locates it
   → Time: 10 seconds

3. Analyze with Context (LAYER 1)
   → Claude reads CLAUDE.md
   → Understands your API patterns
   → Suggests fix based on your conventions
   → Time: 1 minute

4. Implement Fix (LAYER 4)
   → @coder agent with TDD
   → Writes failing test first
   → Implements fix
   → Time: 5-10 minutes

5. Verify Fix (LAYER 2 + 4)
   → /test (run full suite)
   → @quality-reviewer (security check)
   → Time: 1 minute

6. Deploy (LAYER 3)
   → commit-readiness-checker validates
   → Git approval workflow
   → Time: 1 minute
```

**Total time:** 10-15 minutes (bug found → fixed → tested → committed)

---

## When to Use Which Layer

### Use Layer 1 (CLAUDE.md) when:
- ✅ Setting up a new project
- ✅ Information applies to ALL conversations
- ✅ Business context, coding conventions, API purposes
- ❌ NOT for: File structure (Claude reads code), dependencies (Claude reads package.json)

### Use Layer 2 (Commands) when:
- ✅ Repetitive tasks (test, build, review)
- ✅ Quick operations (model switching, usage check)
- ✅ You do this multiple times per day
- ❌ NOT for: One-time tasks, complex multi-step workflows

### Use Layer 3 (Skills) when:
- ✅ Domain-specific questions (Where is X? How do tests work?)
- ✅ Auto-activation preferred (skills trigger automatically)
- ✅ 30-second to 2-minute tasks
- ❌ NOT for: Complex multi-step tasks (use agents)

### Use Layer 4 (Agents) when:
- ✅ Complex, multi-step workflows (project planning, feature implementation)
- ✅ Specialized expertise needed (security review, TDD, architecture)
- ✅ 10-30 minute tasks
- ❌ NOT for: Simple questions (overkill), repetitive operations (use commands)

---

## Common Workflow Anti-Patterns

### ❌ Anti-Pattern #1: Using Agents for Simple Tasks

**Problem:** Launching @coder agent to change one line

**Example:**
```
You: "@coder change the page title to 'Dashboard'"
Agent: *launches full TDD workflow, reads files, plans, implements*
Cost: 2,000 tokens, 2 minutes
```

**✅ Correct Approach:**
```
You: "Change line 42 of index.html: <title> to 'Dashboard'"
Claude: *edits one line*
Cost: 200 tokens, 10 seconds
```

**Pattern:** Save agents for multi-step tasks. Simple edits don't need agents.

---

### ❌ Anti-Pattern #2: Not Using CLAUDE.md

**Problem:** Re-explaining context every session

**Example:**
```
Session 1:
You: "This is a React app with Express backend and PostgreSQL"
Claude: [does work]

Session 2 (next day):
You: "This is a React app with..." [repeat context]
Cost: 500 tokens per session explaining the same thing
```

**✅ Correct Approach:**
```
CLAUDE.md:
## Tech Stack
- Frontend: React 18
- Backend: Express.js
- Database: PostgreSQL 14

Session 1: Claude reads CLAUDE.md automatically
Session 2: Claude reads CLAUDE.md automatically
Cost: 100 tokens per session (80% savings)
```

**Pattern:** Write it once in CLAUDE.md, benefit forever.

---

### ❌ Anti-Pattern #3: Manual Work That Skills Automate

**Problem:** Manually searching for components

**Example:**
```
You: "Can you read through all the files in src/components/ and find where the login form is?"
Claude: *reads 50 files*
Cost: 5,000 tokens, 5 minutes
```

**✅ Correct Approach:**
```
You: "Where is the login form component?"
component-finder skill: *activates automatically*
Claude: "Found at src/components/Auth/LoginForm.tsx"
Cost: 300 tokens, 10 seconds
```

**Pattern:** Ask natural questions. Let skills auto-activate.

---

### ❌ Anti-Pattern #4: Wrong Model for Task

**Problem:** Using Sonnet for exploration

**Example:**
```
You: "List all the API endpoints in this project"
Claude (Sonnet): *explores, lists endpoints*
Cost: $3 per million tokens
```

**✅ Correct Approach:**
```
You: "/model haiku"
You: "List all the API endpoints in this project"
Claude (Haiku): *explores, lists endpoints*
Cost: $0.25 per million tokens (92% cheaper)
```

**Pattern:** Exploration = Haiku. Implementation = Sonnet. Architecture = Opus.

---

## Tool Combinations (Power Moves)

### Combo #1: @prompt-polisher → @project-planner

**When:** Starting a new project with vague idea

```
You: "I want to build a task management app"

1. @prompt-polisher transforms vague → specific
   → Output: Target users, core features, constraints

2. @project-planner takes specific brief
   → Output: Tech stack recommendations, CLAUDE.md draft, next steps

Result: 30 minutes → Complete project plan with rationale
```

---

### Combo #2: @initializer → @coder → @quality-reviewer

**When:** Implementing a planned project

```
1. @initializer reads project plan
   → Output: features.json (10 features with confidence scores)

2. @coder implements feat-001 (highest confidence)
   → Uses TDD workflow
   → Reads CLAUDE.md for conventions

3. @quality-reviewer validates feat-001
   → Security + tests + standards (parallel)
   → Output: Issues found + fixes suggested

Result: Systematic feature development with quality gates
```

---

### Combo #3: /test → testing-workflow skill → @coder

**When:** Tests are failing, need fixes

```
1. /test command runs suite
   → Output: 3 tests failing

2. testing-workflow skill analyzes failures
   → Categorizes: logic errors, missing mocks, etc.
   → Suggests fixes for each

3. @coder implements fixes
   → Uses TDD workflow
   → Re-runs tests until passing

Result: Failing tests → Passing tests with proper fixes
```

---

## Next Steps

### Master Each Layer Progressively

**Week 1: Layer 1 (Context)**
→ Set up CLAUDE.md for 1-2 projects
→ Experience 95% context query savings

**Week 2: Layer 2 (Commands)**
→ Use /test, /build, /review daily
→ Create custom commands for your workflow

**Week 3: Layer 3 (Skills)**
→ Explore 18 available skills
→ Let them auto-activate, observe benefits

**Week 4: Layer 4 (Agents)**
→ Use @project-planner for new project
→ Use @coder for feature implementation
→ Use @quality-reviewer before commits

**Result:** Full workflow mastery in 1 month

---

## Related Documentation

**Layer 1 (Context):**
- [Project Onboarding Guide](../../02_project-onboarding/01_must-have/01_onboarding-guide.md)
- [CLAUDE.md Template](../../templates/CLAUDE.md.template)

**Layer 2 (Commands):**
- [Slash Commands Reference](../00-start-here/09_quick-reference.md#slash-commands)
- [Custom Commands Guide](../../.claude/commands/README.md)

**Layer 3 (Skills):**
- [Skills Paradigm](../00-start-here/SKILLS_PARADIGM.md)
- [Available Skills](../../.claude/skills/README.md)

**Layer 4 (Agents):**
- [Agent Documentation](../../.claude/agents/docs/README.md)
- [Custom Agents Guide](../../01_global-setup/02_good-to-have/03_custom-agents.md)

---

## ✅ You've Completed: Workflow Integration

**What you learned:**
- The 4 layers of Claude Code optimization
- How layers work together (context → commands → skills → agents)
- When to use each layer (decision framework)
- Common workflow anti-patterns and how to avoid them
- Power combinations (tool synergy for 2-3× gains)

**Next logical step:**

**Option A: See Visual Workflows (5 min)**
→ [Visual Workflows Guide](../00-start-here/VISUAL_WORKFLOWS.md) - 5 Mermaid diagrams showing flows

**Option B: Master Layer 1 (30 min)**
→ [Project Onboarding](../../02_project-onboarding/01_must-have/01_onboarding-guide.md) - Set up CLAUDE.md

**Option C: Explore Skills (15 min)**
→ [Skills Paradigm](../00-start-here/SKILLS_PARADIGM.md) - Understand auto-activation

**Having trouble?** Ask Claude: "Walk me through the workflow for [your specific task]"

---

**Estimated next step time:** 5-30 minutes (depending on choice)
**Last Updated:** 2025-12-16
