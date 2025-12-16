# Mode Selector Skill

## Overview

The Mode Selector Skill provides **proactive intelligence** for development mode selection. It automatically detects when users are uncertain about whether to use Vibe Coding (speed-focused) or Vibe Engineering (quality-focused) approaches, and provides lightweight recommendations without requiring explicit invocation.

**Auto-activation:** This skill activates when detecting specific patterns in user messages that indicate mode uncertainty or quality/speed trade-off questions.

**Companion agent:** For comprehensive analysis with 6-dimension evaluation and detailed reasoning, users can invoke the full `@mode-selector` agent.

---

## When This Skill Auto-Activates

### Pattern Category 1: Quality Uncertainty

**Trigger patterns:**
- "Should I design this first?"
- "How much planning do I need?"
- "Do I need tests for this?"
- "Is this over-engineered?"

**What user is really asking:**
"How much quality investment is appropriate for this context?"

**Skill response:**
Analyze the implicit context (if mentioned) and recommend Vibe Coding (minimal planning) or Vibe Engineering (comprehensive planning) based on risk/longevity signals.

---

### Pattern Category 2: Speed vs Quality Trade-off

**Trigger patterns:**
- "How fast should I build this?"
- "Can I skip [quality practice] for now?"
- "Is this good enough to ship?"
- "Should I refactor or keep going?"

**What user is really asking:**
"Is speed or quality the priority here?"

**Skill response:**
Identify the trade-off dimension (timeline vs risk, prototype vs production) and recommend the appropriate balance.

---

### Pattern Category 3: Transition Points

**Trigger patterns:**
- "This prototype worked, what's next?"
- "How do I make this production-ready?"
- "Should I rewrite or refactor?"
- "When should I add tests?"

**What user is really asking:**
"When do I transition from Vibe Coding → Vibe Engineering?"

**Skill response:**
Recognize transition signal (prototype → production, internal → customer-facing) and provide transition guidance with refactoring checklist reference.

---

### Pattern Category 4: Mode Confusion

**Trigger patterns:**
- "I'm stuck in prototype mode"
- "This is taking too long to build"
- "Why does my code keep breaking?"
- "I keep rewriting everything"

**What user is really asking:**
"Am I in the wrong mode for my context?"

**Skill response:**
Diagnose mode mismatch (using Vibe Coding when should use Vibe Engineering, or vice versa) and recommend mode correction.

---

## Skill Response Template

When auto-activated, this skill responds with:

```
🎯 I noticed you're asking about [quality level/approach/transition].
Let me help you choose the right mode for this task.

Based on what you've described, I recommend: [Vibe Coding | Vibe Engineering | Transition to Vibe Engineering]

[Brief reasoning - 2-3 sentences explaining why this mode fits the context]

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

**Example responses:**

### Example 1: Quality Uncertainty

**User message:** "Should I design this authentication system first or just start coding?"

**Skill response:**
```
🎯 I noticed you're asking about planning vs coding for authentication.
Let me help you choose the right mode for this task.

Based on what you've described, I recommend: **Vibe Engineering**

Authentication is security-critical and will be long-term infrastructure. Even if you're unsure about specific features, investing in upfront design will prevent security vulnerabilities and technical debt. Use @prompt-polisher to clarify requirements, then @project-planner for architecture.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

---

### Example 2: Speed vs Quality Trade-off

**User message:** "Can I skip tests for this internal admin dashboard? We need it by Friday."

**Skill response:**
```
🎯 I noticed you're asking about skipping tests due to timeline pressure.
Let me help you choose the right mode for this task.

Based on what you've described, I recommend: **Vibe Coding (with transition plan)**

For an internal tool with a tight deadline, Vibe Coding is appropriate - build fast, manual testing is fine. However, if this dashboard becomes heavily used (10+ people daily), plan a refactoring sprint to add tests and improve stability.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

---

### Example 3: Transition Point

**User message:** "My prototype has 500 users now. What's next?"

**Skill response:**
```
🎯 I noticed you're at a transition point - prototype to production.
Let me help you choose the right mode for this task.

Based on what you've described, I recommend: **Transition to Vibe Engineering**

With 500 users, you've validated the idea and now need production-quality code. Stop new features and invest 4-6 weeks in: (1) comprehensive tests, (2) security audit, (3) error handling, (4) monitoring/alerting, (5) documentation. Use the refactoring checklist from @mode-selector agent.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

---

### Example 4: Mode Confusion

**User message:** "I keep rewriting this feature from scratch. Why can't I finish?"

**Skill response:**
```
🎯 I noticed you're stuck in a rewrite cycle.
Let me help you diagnose the mode mismatch.

Based on what you've described, I recommend: **Stop and reassess mode**

Constant rewrites suggest either (1) unclear requirements (need Vibe Coding to explore first), or (2) perfectionism (using Vibe Engineering for a prototype). If requirements are uncertain, embrace Vibe Coding - build fast, iterate, learn. If requirements are clear, use @project-planner to create a design you can commit to.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

---

## Decision Framework (Lightweight Version)

When auto-activated, this skill uses a simplified 3-question framework instead of the full 6-dimension analysis:

### Question 1: Is this temporary or permanent?
- **Temporary (< 1 month):** Lean Vibe Coding
- **Permanent (1+ year):** Lean Vibe Engineering
- **Uncertain:** Mixed (start with Vibe Coding, plan transition)

### Question 2: What's the risk if this breaks?
- **Low risk (internal, non-critical):** Lean Vibe Coding
- **High risk (customer-facing, revenue, security):** Lean Vibe Engineering
- **Medium risk:** Mixed (balance quality and speed)

### Question 3: Is the timeline tight or flexible?
- **Tight (hours/days):** Lean Vibe Coding
- **Flexible (weeks/months):** Lean Vibe Engineering
- **Standard (1-2 weeks):** Mixed (depends on other factors)

**Scoring:**
- 3x Vibe Coding signals → **Strong Vibe Coding** recommendation
- 2x Vibe Coding signals → **Lean Vibe Coding** recommendation
- Mixed signals → **Acknowledge trade-off**, suggest starting mode
- 2x Vibe Engineering signals → **Lean Vibe Engineering** recommendation
- 3x Vibe Engineering signals → **Strong Vibe Engineering** recommendation

**Confidence threshold:**
- If signals are contradictory (e.g., temporary but high-risk), acknowledge tension and recommend starting with Vibe Coding, then transitioning to Vibe Engineering.

---

## Integration with @mode-selector Agent

**When to recommend full agent invocation:**

1. **Low confidence** - Contradictory signals (temporary + high-risk, clear requirements + tight timeline)
2. **High stakes** - Business-critical decision (regulatory, revenue, large user base)
3. **Team disagreement** - Need objective analysis to resolve debate
4. **User requests detail** - Wants to understand reasoning deeply

**Handoff message:**
```
For comprehensive analysis with 6-dimension evaluation, detailed examples, and transition guidance, invoke:

@mode-selector I'm about to [describe your task]. What mode should I use?
```

---

## Why This Skill Works (Proactive Intelligence)

### The Problem It Solves

**Without this skill:**
- Users don't realize they're facing a mode selection decision
- Decision anxiety goes unaddressed ("Should I design first?" → paralysis)
- Wrong mode chosen by default (personality bias: always fast OR always slow)
- Missed transition signals (prototype becomes production, no one notices)

**With this skill:**
- **Proactive:** Catches questions before they become problems
- **Lightweight:** Brief recommendation, option for deep dive
- **Educational:** Users learn patterns over time (build intuition)
- **Non-intrusive:** Only activates when relevant (no noise)

### Educational Value

**Skill as training wheels:**

**Stage 1 (Beginner):** User asks mode questions, skill provides answers
- "Should I design this?" → Skill: "Use Vibe Coding for this prototype"
- User learns: "Prototypes don't need design"

**Stage 2 (Intermediate):** User recognizes patterns, skill validates intuition
- "This is a prototype, so Vibe Coding, right?" → Skill: "Correct! Here's why..."
- User learns: Pattern recognition (temporary + low-risk = Vibe Coding)

**Stage 3 (Advanced):** User doesn't need skill, makes decisions independently
- User: [Starts coding prototype without asking]
- Skill: [Silent - user internalized framework]
- User learns: Metacognition (context-appropriate methodology selection)

**Goal:** Over time, users won't need this skill. But until then, it provides proactive guidance.

---

## Examples of Skill Activation

### Scenario 1: User Doesn't Realize They're Facing Mode Decision

**User message:**
"I want to build a quick dashboard to show our team's metrics. Should we use React or Vue? What about state management?"

**Skill activation:**
Detects implicit mode question (technology choices suggest uncertainty about scope/quality)

**Skill response:**
```
🎯 Before diving into technology choices, let's determine the right mode for this dashboard.

Based on what you've described, I recommend: **Vibe Coding**

A quick team dashboard (internal, low-risk) doesn't need perfect technology decisions. Pick the framework you know best (faster development), skip state management libraries (use React hooks or Vue Composition API), and iterate based on team feedback. Focus on getting data on screen fast.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

**Educational moment:** User learns that mode selection precedes technology selection.

---

### Scenario 2: User Expresses Decision Anxiety

**User message:**
"I'm building a payment processing feature and I'm nervous about getting it right. Do I need to plan everything upfront?"

**Skill activation:**
Detects anxiety signal ("nervous about getting it right") + high-risk context (payment processing)

**Skill response:**
```
🎯 I noticed you're feeling anxious about payment processing (understandable - it's high-stakes!).
Let me help you choose the right mode for this task.

Based on what you've described, I recommend: **Vibe Engineering (maximum rigor)**

Payment processing is business-critical, security-sensitive, and high-risk. Your nervousness is appropriate - this absolutely requires comprehensive planning, security review, and extensive testing. Use @prompt-polisher → @project-planner → @coder → @quality-reviewer workflow. Taking time upfront will reduce anxiety and prevent costly mistakes.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

**Educational moment:** User learns that anxiety is a signal to use Vibe Engineering (intuition is correct).

---

### Scenario 3: User at Transition Point But Doesn't Realize It

**User message:**
"Our internal tool is getting popular. 50 people are using it now and they're asking for new features. Should I keep building or take a break?"

**Skill activation:**
Detects transition signal (adoption growing: 50 users, feature requests increasing)

**Skill response:**
```
🎯 I noticed you're at a critical transition point - internal tool becoming essential infrastructure.
Let me help you choose the right mode for this task.

Based on what you've described, I recommend: **Pause features, transition to Vibe Engineering**

50 active users + growing feature requests = this is no longer a prototype. Before adding features, invest 2-3 weeks in: (1) writing tests (prevent regressions), (2) refactoring messy code (make future changes easier), (3) adding error handling (improve reliability), (4) documentation (enable team contributions). This investment will 10x your velocity for all future features.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

**Educational moment:** User learns to recognize transition signals (adoption = time to refactor).

---

## Skill Configuration

**Auto-activation settings:**
- **Trigger confidence threshold:** 0.7 (high confidence required to activate)
- **Max activations per conversation:** 2 (avoid being annoying)
- **Cool-down period:** 5 messages (don't activate too frequently)

**Why conservative activation:**
- Skill should be helpful, not intrusive
- False positives are worse than false negatives (user can invoke agent if needed)
- Goal is to catch clear decision points, not every vague question

---

## Relationship to Other Skills

**Complementary skills:**
- **project-analyzer skill** - Provides project status context for mode decisions
- **personalization-engine skill** - Learns user's mode preferences over time

**Integration example:**
```
project-analyzer: "Your project has 80% test coverage and 1,000 active users"
mode-selector skill: "Detected high adoption + good test coverage = maintain Vibe Engineering mode"
personalization-engine: "User typically prefers Vibe Coding, but data suggests Vibe Engineering is appropriate here"
```

**Result:** Multi-skill coordination provides richer context for mode recommendations.

---

## Success Metrics

**How to measure skill effectiveness:**

**Activation metrics:**
- Activation rate (% of relevant questions caught)
- False positive rate (% of activations that were unhelpful)
- User satisfaction (did recommendation help?)

**Outcome metrics:**
- Reduced decision anxiety (fewer "should I?" questions over time)
- Fewer mode mismatches (less over-engineering + under-engineering)
- Faster mode internalization (users learn patterns, need skill less often)

**Target outcomes:**
- 80%+ relevant question detection (skill catches most mode questions)
- < 10% false positive rate (skill is rarely intrusive)
- 50% reduction in mode questions after 3 months (users learning)

---

## Maintenance and Updates

**When to update this skill:**

1. **New trigger patterns identified** - Users ask mode questions in new ways
2. **False positives occur** - Skill activates when not helpful
3. **False negatives occur** - Skill misses obvious mode questions
4. **Framework evolution** - @mode-selector agent updated with new dimensions

**Update process:**
1. Collect user feedback (when was skill helpful/unhelpful?)
2. Analyze patterns (what questions are we missing?)
3. Update trigger patterns (add/remove/refine)
4. Test with historical conversations (would new patterns catch more cases?)

---

## Summary

**Mode Selector Skill provides proactive mode selection guidance:**

**Auto-activation triggers:**
- Quality uncertainty (16 patterns across 4 categories)
- Speed vs quality trade-offs
- Transition points (prototype → production)
- Mode confusion (stuck in wrong mode)

**Lightweight decision framework:**
- 3 questions (temporary vs permanent, risk level, timeline)
- Simple scoring (Vibe Coding vs Vibe Engineering)
- Brief response (2-3 sentences + recommendation)

**Educational value:**
- Training wheels for mode selection
- Progressive learning (beginner → advanced)
- Goal: Users internalize framework, need skill less over time

**Integration:**
- Lightweight skill (proactive, brief responses)
- Full agent available (@mode-selector for deep analysis)
- Handoff when user needs detailed reasoning

**Why this works:**
- Catches questions before they become problems
- Non-intrusive (activates only when relevant)
- Teaches patterns (builds user intuition)
- Reduces decision anxiety (provides permission to choose)

**Your role as this skill:**
Be the gentle guide that notices when users are uncertain and provides just-in-time clarity. Don't wait for users to ask - proactively recognize mode selection moments and help them choose wisely.
