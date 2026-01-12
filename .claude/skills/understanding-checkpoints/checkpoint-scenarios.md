# Understanding Checkpoints - Common Scenarios Quick Reference

**Version:** v5.0.0-alpha.1
**Purpose:** Fast lookup for triggering appropriate checkpoints

---

## Scenario Detection Matrix

### Configuration Gaps

| User Query Pattern | Checkpoint Category | Key Concept | ELI12 Analogy |
|-------------------|---------------------|-------------|---------------|
| "How do I make Claude remember..." | CLAUDE.md | Project memory | Notebook for substitute teacher |
| "Where do I configure..." | settings.json | Tool configuration | Toolbox settings |
| "How do I add an agent..." | Custom agents | Specialized workers | Hiring specialists for tasks |
| "What are skills..." | Skills paradigm | Account-level expertise | Personal skills you carry everywhere |
| "MCP not working..." | MCP servers | External data sources | USB devices for your computer |

### Workflow Confusion

| User Query Pattern | Checkpoint Category | Key Concept | ELI12 Analogy |
|-------------------|---------------------|-------------|---------------|
| "Do I commit first or..." | Git workflow | Version control sequence | Save draft → Edit → Publish blog |
| "When do I use Opus vs Sonnet..." | Model selection | Right tool for job | Sledgehammer vs screwdriver |
| "How do I set up new project..." | Project onboarding | Initialization sequence | Moving into new apartment |
| "What's the learning path..." | Learning journey | Progressive disclosure | Video game level progression |

### Concept Misunderstandings

| User Query Pattern | Checkpoint Category | Key Concept | ELI12 Analogy |
|-------------------|---------------------|-------------|---------------|
| "Why do I need bootup ritual..." | Domain memory | Session persistence | Loading saved game |
| "What's features.json for..." | Structured state | Task management | Shopping list vs mental notes |
| "Why separate agents..." | Specialization | Single responsibility | Chef vs waiter vs manager |
| "What's prompt caching..." | Token optimization | Reusing expensive work | Photocopying vs rewriting |
| "Template inheritance?" | Template system | Composition | Lego blocks vs custom sculpting |

### Error Messages

| Error Pattern | Checkpoint Category | Root Cause | Quick Fix |
|--------------|---------------------|-----------|-----------|
| ".claude/settings.json not found" | Configuration | Missing project setup | Run project onboarding wizard |
| "Agent not found" | Custom agents | Agent not configured | Add agent to .claude/agents/ |
| "Skill not recognized" | Skills | Skill not defined | Create SKILL.md in .claude/skills/ |
| "Permission denied" | Sandbox | Security restriction | Check .claude/settings.json allowlist |
| "MCP server failed" | MCP integration | Server not running/configured | Check MCP server setup |

---

## Quick Checkpoint Triggers

### Trigger: User Asks About Same Thing Twice

**Detection:**
```
Session history shows:
  [10:30] User: "How do I use CLAUDE.md?"
  [10:45] User: "Where do I put project context?"
```

**Response:**
```
🛑 Understanding Checkpoint: CLAUDE.md

I notice you've asked about this twice. Let me make sure this concept clicks
before we continue - it's foundational to everything else.

[Execute CLAUDE.md checkpoint with full protocol]
```

### Trigger: User Says "I Don't Understand"

**Detection:**
```
User message contains: "I don't understand", "I'm confused", "What do you mean", "Can you explain"
```

**Response:**
```
🛑 Understanding Checkpoint: [Topic They're Confused About]

Let me break this down with a concrete analogy.

[Execute checkpoint with emphasis on ELI12 analogy]
```

### Trigger: User Attempts Action Requiring Setup

**Detection:**
```
User: "Add authentication to my app"
But: No CLAUDE.md exists (no project context)
```

**Response:**
```
🛑 Understanding Checkpoint: Project Context

Before we add features, I need to understand your project.

Let me explain WHY project context matters:

[Execute CLAUDE.md checkpoint]
[After verification: Help create CLAUDE.md, THEN add authentication]
```

### Trigger: User Hits Error Message

**Detection:**
```
Tool execution returns: "Error: .claude/settings.json not found"
```

**Response:**
```
🛑 Understanding Checkpoint: Claude Code Project Configuration

You hit an error because this project isn't set up yet.

Let me explain WHY Claude Code needs per-project configuration:

[Execute project setup checkpoint]
[After verification: Run project onboarding wizard]
```

---

## Checkpoint Flow Shortcuts

### Minimal Checkpoint (Quick Concept)

Use when: User needs quick clarification, not deep understanding

```
💡 Quick Understanding Moment: [Concept]

Think of it like: [One-sentence analogy]

That's why [explanation in 1-2 sentences].

Does that make sense? (yes/no)
```

### Standard Checkpoint (Core Concept)

Use when: User hits important wall, needs full understanding

```
🛑 Understanding Checkpoint: [Concept]

Analogy: [ELI12 paragraph]
How it works: [Intermediate states]
Traditional vs Claude: [Comparison]

Verification: [Explain back / Predict / Apply]
```

### Deep Checkpoint (Architecture Decision)

Use when: User making high-stakes decision, needs trade-off analysis

```
🛑 Understanding Checkpoint: Architecture Decision

You're at a fork in the road. Let me show you both paths:

Option A: [Pros/Cons/Best when]
Option B: [Pros/Cons/Best when]

Traditional approach: [What most do]
Claude-assisted approach: [What changes]

Verification: Given YOUR context, which makes sense and why?
```

---

## Verification Response Patterns

### User Provides Weak Understanding

**Pattern:** Generic explanation, vague language, no connection to their problem

**Example:**
```
User: "CLAUDE.md makes things easier by helping Claude remember stuff."
```

**Response:**
```
That's partially correct, but let me clarify the SPECIFIC mechanism:

CLAUDE.md isn't just "helpful" - it's a TOKEN OPTIMIZATION strategy.

Here's the precise mechanism:
[Re-explain with specifics]

Try again: What EXACTLY does CLAUDE.md do to save tokens?
```

### User Provides Good Understanding

**Pattern:** Correct mechanism, connects to their problem, uses specific terms

**Example:**
```
User: "CLAUDE.md is read once at session start, so I don't re-explain my
project context every time. This saves the 500+ tokens I'd otherwise spend
on re-introducing my tech stack and project goals."
```

**Response:**
```
✅ Exactly! You've got it.

Key insight: Read ONCE per session (cheap) vs re-explain EVERY query (expensive).

Now let's create YOUR CLAUDE.md. What's your project about?
```

### User Provides Expert Understanding

**Pattern:** Mechanism + trade-offs + edge cases + when NOT to use

**Example:**
```
User: "CLAUDE.md is a persistent context file that's cached across queries
within a session. It saves tokens on session startup but increases prompt
length, so you need to balance comprehensiveness vs bloat. For small scripts,
you might skip it. For large projects with complex context, it's essential."
```

**Response:**
```
✅ Outstanding! That's expert-level understanding.

You even identified the key trade-off: comprehensive vs bloat.
That awareness will help you write EXCELLENT CLAUDE.md files.

You're ready to proceed without more checkpoints on this concept.
```

---

## Problem-First Context Integration

When `.claude/.problem-first-setup` exists, read it and adapt checkpoints:

### File Contents
```bash
setup_date=2025-01-13
user_problem=Fix SQL injection in my API
problem_category=bug-fix
first_session=true
```

### Adaptations

**Tailored Analogies:**
- Problem: "Fix SQL injection"
- Checkpoint: CLAUDE.md
- Standard analogy: "Notebook for substitute teacher"
- Tailored analogy: "CLAUDE.md is like a bug report template that has all the reproduction steps and project context, so Claude doesn't have to ask 'What framework?' 'What database?' every time you report a security issue."

**Checkpoint Frequency:**
- `first_session=true`: More frequent checkpoints (user is new)
- `first_session=false`: Standard frequency (user has baseline knowledge)

**Problem-Specific Examples:**
- Problem category: bug-fix
- When explaining: Use debugging examples instead of feature-building examples
- When showing code: Show security-focused code instead of generic code

---

## Checkpoint Pacing

### Session Start (First 10 minutes)

**Aggressive Checkpointing:**
- Trigger on FIRST confusion signal (don't wait for second)
- Build foundation early (prevents compounding confusion later)
- Verify thoroughly (ensure user starts with correct mental models)

### Mid-Session (10-30 minutes)

**Standard Checkpointing:**
- Trigger on repeated confusion or errors
- Allow user to work, but catch conceptual gaps
- Balance flow vs learning

### Late Session (30+ minutes)

**Minimal Checkpointing:**
- User has momentum, don't break flow
- Only trigger for NEW concepts or critical errors
- Quick checkpoints only (💡 format, not 🛑 format)

---

## Integration Examples

### With Personalization Engine

```
User completes CLAUDE.md checkpoint successfully.

→ Store in personalization-engine:
  - Concept: CLAUDE.md
  - Understanding Level: 2 (Functional)
  - Pass Date: 2025-01-13
  - Notes: Understood token optimization, weak on structure

→ Next session:
  - Don't re-checkpoint CLAUDE.md basics
  - Can checkpoint CLAUDE.md advanced (structure, optimization)
```

### With Projects Registry

```
Project: E-commerce app (Next.js + Stripe)

User hits model selection checkpoint.

→ Tailor analogy to e-commerce:
  "Choosing Opus vs Sonnet is like choosing same-day delivery vs standard shipping.

   Opus (same-day): Expensive, fast, use for critical architecture (payment flow)
   Sonnet (standard): Balanced, use for most features (product pages)
   Haiku (bulk): Cheap, fast, use for exploration (reading product data)"
```

### With Quality Reviewer

```
Quality reviewer detects: User about to commit code with SQL injection

→ Trigger security checkpoint BEFORE commit:

🛑 Understanding Checkpoint: Security Vulnerability

I detected a security issue in your code before committing.

Let me explain WHY this is dangerous:

[Execute security checkpoint with vulnerability details]
[After verification: Fix vulnerability, THEN commit]
```

---

## Checkpoint Success Indicators

### Good Signs (Checkpoints Working)

- ✅ User passes verification on first attempt (80%+ of time)
- ✅ User doesn't hit same wall twice in session
- ✅ User starts asking DEEPER questions (shows building knowledge)
- ✅ User completes tasks faster in second half of session
- ✅ User says "Ah!" or "That makes sense!" during checkpoint

### Warning Signs (Checkpoints Not Working)

- ⚠️ User fails verification multiple times (concept too complex?)
- ⚠️ User hits same wall repeatedly (checkpoint didn't stick?)
- ⚠️ User says "Just tell me what to do" (resisting understanding?)
- ⚠️ User's questions stay surface-level (not building depth?)
- ⚠️ Checkpoint frequency increases over time (should decrease as user learns)

**If warning signs appear:**
1. Simplify analogies (go even more basic)
2. Show more examples (less theory, more practice)
3. Check if user is in "urgent mode" (might need quick solutions first, understanding later)

---

## Special Scenarios

### Scenario: User in Urgent Mode

**Detection:**
```
User: "I need this working in 10 minutes for a demo"
```

**Adaptation:**
```
💡 Quick Solution Mode

I see you're under time pressure. Here's the quick fix:

[Provide solution without checkpoint]

⏰ After your demo:
  I recommend taking 5 minutes to understand WHY this works,
  so you can handle similar issues independently next time.

  Type "checkpoint [concept]" when you're ready.
```

**Rationale:** Respect urgent needs, but offer checkpoint for later. Don't force learning when user has legitimate time pressure.

### Scenario: User Already Expert

**Detection:**
```
User: "I need to configure prompt caching with 5-minute TTL for my
      high-frequency queries, but preserve default TTL for background jobs."
```

**Adaptation:**
```
[No checkpoint needed - user demonstrates expert understanding]

Proceed directly with solution:
  "Here's how to configure differential TTLs..."
```

**Rationale:** Don't checkpoint concepts user already understands. Detect expertise through language precision and edge case awareness.

### Scenario: User Explicitly Requests Understanding

**Detection:**
```
User: "Can you explain how this works?" or "I want to understand why..."
```

**Adaptation:**
```
✅ Understanding Request Detected

Let me explain the mechanism:

[Execute checkpoint even if no wall hit]
[User is ASKING for learning - give it to them]
```

**Rationale:** Honor explicit learning requests. These are "pull" not "push" checkpoints.

---

## Checkpoint Analytics (Track for v5.0.0 Beta)

### Metrics to Collect

**Per Checkpoint:**
- Concept: [What was taught]
- Trigger Type: [Error / Repeated / Confusion / Request]
- Pass/Fail: [User verification result]
- Attempts: [How many verification attempts needed]
- Time: [How long checkpoint took]

**Per Session:**
- Total Checkpoints: [Count]
- Pass Rate: [Percentage]
- Concepts Learned: [List]
- Repeat Walls: [Concepts user hit twice]

**Per User (requires personalization-engine):**
- Checkpoint History: [All passed checkpoints]
- Struggle Areas: [Concepts with failed verifications]
- Expertise Level: [Beginner / Intermediate / Expert per concept]

---

## Version History

- **v5.0.0-alpha.1 (2025-01-13):** Initial scenarios guide
  - Detection matrix for common scenarios
  - Quick checkpoint triggers
  - Verification response patterns
  - Problem-first integration examples
  - Checkpoint pacing guidelines
  - Integration examples with other skills

---

**Status:** Active in v5.0.0-alpha.1
**Last Updated:** 2025-01-13
