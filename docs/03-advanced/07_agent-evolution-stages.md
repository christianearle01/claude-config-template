# Agent Evolution Stages - From Zero to Orchestration

**Understanding Your Journey Through AI-Assisted Development**

## Overview

Steve Yegge's "Welcome to Gas Town" describes the natural evolution developers undergo as they adopt AI coding agents. This guide maps those seven stages to claude-config-template features, helping you understand where you are and where you might go next.

**Key insight:** These stages aren't a ladder you must climb. They're a menu of options. Most developers will find their optimal stage and stay there—and that's completely fine.

**Template's position:** Stage 5 (Multi-Agent CLI) - the sweet spot for educational projects and small teams.

**Sources:**
- [Welcome to Gas Town](https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04) - Steve Yegge, Jan 2026
- [Hacker News Discussion](https://news.ycombinator.com/item?id=46458936)

---

## The Seven Stages

### Stage 1: Zero or Near-Zero AI Use

**Psychology:** Fear, resistance, skepticism
**Behavior:** "I'll try it someday" or "AI can't write real code"
**Context:** Learning traditional development, comfortable with existing tools

**Template Support:**
- `docs/00-start-here/01_entry-points.md` - Start here when ready
- `docs/00-start-here/personas/` - Find your entry point
- `docs/00-start-here/02_quick-win.md` - 5-minute success

**When to progress:** When curiosity outweighs fear, or when you see colleagues succeeding with AI tools

**Should you progress?** Only when you're ready. Forced adoption rarely works. Wait for genuine interest.

---

### Stage 2: Coding Agents in IDE (with permissions)

**Psychology:** Controlled experimentation, permission-seeking
**Behavior:** Accept/reject suggestions carefully, verify everything
**Context:** Building trust, learning what AI is good/bad at

**Template Support:**
- `01_global-setup/01_must-have/` - Essential Claude Code setup
- `docs/01-fundamentals/05_anti-patterns.md` - What NOT to do (critical reading)
- `docs/01-fundamentals/07_prompting-fundamentals.md` - How to communicate effectively

**Key learning:** Understand AI's strengths (boilerplate, patterns, common tasks) and weaknesses (novel algorithms, security, business logic)

**When to progress:** When you stop reviewing every suggestion character-by-character and start trusting patterns

**Should you progress?** Yes, when ready. Stage 2 is training wheels—helpful, but limiting.

---

### Stage 3: YOLO Mode

**Psychology:** Trust building complete, confidence emerging
**Behavior:** Accept suggestions rapidly, occasional "whoops" moments
**Context:** Productivity spike, learning to recover from mistakes

**Template Support:**
- `01_global-setup/02_good-to-have/` - Token optimization, prompt caching
- `docs/02-optimization/` - Cost reduction strategies
- `docs/01-fundamentals/06_coding-principles-handbook.md` - Maintain code quality

**Danger zone:** "YOLO mode" can lead to technical debt if you're not careful. Balance speed with understanding.

**When to progress:** When you realize IDE agents are limiting (can't do multi-file refactors, complex planning)

**Should you progress?** Maybe. Many developers thrive at Stage 3. Progress only if you need capabilities IDE agents can't provide.

---

### Stage 4: Single CLI Agent

**Psychology:** Competence emerging, pattern recognition
**Behavior:** One agent at a time, focused tasks, learning bootup rituals
**Context:** Deeper integration, agent becomes a team member

**Template Support:**
- `.claude/agents/coder.md` - Atomic feature execution
- `docs/03-advanced/01_bootup-ritual-guide.md` - Session initialization
- `features.json` template - Structured task management
- `docs/01-fundamentals/08_prompt-patterns.md` - Reusable prompt templates

**Breakthrough moment:** Realizing an agent can handle entire features end-to-end (design → code → test)

**When to progress:** When one agent feels limiting—you want parallel work on multiple features

**Should you progress?** Only if you need parallelism. Single-agent focus is powerful—don't underestimate it.

---

### Stage 5: Multi-Agent CLI (3-5 parallel)

**Psychology:** Managing multiple contexts, coordination awareness
**Behavior:** 3-5 agents in parallel, manual coordination, features.json for shared state
**Context:** Small team simulation, specialized agents for specialized tasks

**Template Support (YOU ARE HERE):**
- `.claude/agents/initializer.md` - Project planning, features.json creation
- `.claude/agents/coder.md` - Implementation (atomic, bootup ritual)
- `.claude/agents/quality-reviewer.md` - Security, testing, standards
- `.claude/agents/project-planner.md` - Architecture decisions
- `features.json` - Shared memory across agents
- Bootup ritual - Context recovery without orchestration
- Work-claiming pattern (v4.26.0) - Coordination without automation

**Why this is the template's sweet spot:**
- **Transparent state:** features.json visible, auditable, version-controlled
- **Educational value:** You learn agent coordination patterns manually
- **Manageable complexity:** 3-5 agents = high value, low overhead
- **No premature abstraction:** Orchestration not needed yet

**Cognitive load management:**
- Use `features.json` as single source of truth
- Bootup ritual prevents context loss
- Agent roles clear (initializer = planning, coder = implementation, quality-reviewer = validation)
- Work-claiming prevents duplicate work

**When to progress:** When you're regularly managing 10+ agents and coordination overhead exceeds agent work time

**Should you progress?** Probably not. Stage 5 is optimal for most developers. See [Orchestration Decision Framework](08_orchestration-decision-framework.md) before progressing.

---

### Stage 6: CLI Multi-Agent (10+, hand-managed)

**Psychology:** Cognitive wall without orchestration, "losing track" anxiety
**Behavior:** 10+ agents manually coordinated, high mental overhead, seeking automation
**Context:** Large projects, production systems, team-scale complexity

**Template Support:**
- [Orchestration Decision Framework](08_orchestration-decision-framework.md) - Do I need orchestration?
- `.claude/skills/external-perspectives/SKILL.md` - Pattern 10 (Gas Town comparison)
- Integration guides (future) - How to use template + orchestration tools

**Warning signs you've hit the wall:**
- Losing track of which agent is doing what
- Coordination time > actual work time
- Context window limits across ALL agents
- Manual handoffs happening 20+ times per session

**When to progress:** When orchestration benefits (automated coordination) outweigh learning value of manual coordination

**Should you progress?** Yes, if you're genuinely at this stage. No, if you're "future-proofing." YAGNI applies.

---

### Stage 7: Orchestrated Agent Fleets

**Psychology:** Cognitive offloading to system, trust in automation
**Behavior:** Orchestrator manages 10+ agents, you guide high-level goals
**Context:** Production systems, large teams, mature agent patterns

**Orchestration Tools:**
- **Gas Town** (Steve Yegge) - 7 worker roles, GUPP principle, Beads
- **Others** (emerging) - Kubernetes for agents, custom orchestration

**Template Support:**
- Integration guides showing template + Gas Town working together
- features.json schema compatible with orchestrators
- Agent role patterns validate against orchestration frameworks
- Graduation path: Take what you learned at Stage 5 and automate it

**Template is NOT an orchestrator:**
- Template teaches patterns (educational)
- Gas Town executes patterns (production)
- Different tools, complementary purposes

**Graduation ceremony:** You've outgrown the template. Congratulations! Use what you learned here to master orchestration tools.

**Should you "progress"?** This isn't progression—it's graduation to different tools for different needs.

---

## Self-Assessment Quiz

### Where Am I Right Now?

Answer these 10 questions honestly:

1. **How many AI coding agents do you use regularly?**
   - A) None or rarely (Stage 1)
   - B) IDE suggestions only (Stage 2-3)
   - C) 1 CLI agent (Stage 4)
   - D) 2-5 CLI agents (Stage 5)
   - E) 5-10 CLI agents (Stage 6)
   - F) 10+ orchestrated agents (Stage 7)

2. **How do you feel when AI suggests code?**
   - A) Skeptical, verify everything (Stage 2)
   - B) Mostly trusting (Stage 3)
   - C) Confident in patterns (Stage 4-5)
   - D) Delegating entire features (Stage 5-6)
   - E) Setting goals, agents execute (Stage 7)

3. **What's your biggest bottleneck?**
   - A) Learning to trust AI (Stage 1-2)
   - B) Speed of IDE suggestions (Stage 3)
   - C) Single-tasking limitation (Stage 4)
   - D) Manual agent coordination (Stage 5-6)
   - E) Orchestration tuning (Stage 7)

4. **How do you manage context across sessions?**
   - A) Memory/notes (Stage 1-3)
   - B) Bootup ritual, features.json (Stage 4-5)
   - C) Manual tracking across many agents (Stage 6)
   - D) Orchestrator manages it (Stage 7)

5. **What percentage of your work is AI-assisted?**
   - A) 0-20% (Stage 1-2)
   - B) 20-50% (Stage 3)
   - C) 50-75% (Stage 4-5)
   - D) 75-90% (Stage 6-7)

6. **How often do you hit context window limits?**
   - A) Never (Stage 1-3)
   - B) Occasionally, bootup ritual solves it (Stage 4-5)
   - C) Frequently, across multiple agents (Stage 6)
   - D) Orchestrator handles it (Stage 7)

7. **What's your agent coordination method?**
   - A) No coordination needed (Stage 1-4)
   - B) Manual via features.json (Stage 5)
   - C) Manual across 10+ agents (Stage 6)
   - D) Automated orchestration (Stage 7)

8. **How many projects use AI agents?**
   - A) 0-1 (Stage 1-4)
   - B) 2-3 (Stage 5)
   - C) 4-10 (Stage 6)
   - D) 10+ with orchestration (Stage 7)

9. **What's your team size?**
   - A) Solo (Stage 1-5)
   - B) 2-5 people (Stage 5-6)
   - C) 6-20 people (Stage 6-7)
   - D) 20+ people (Stage 7)

10. **What drives your next evolution?**
    - A) Curiosity (Stage 1-3)
    - B) Capability limits (Stage 4-5)
    - C) Coordination overhead (Stage 6)
    - D) Production requirements (Stage 7)

### Scoring

**Mostly A's:** Stage 1-2 (Getting started)
**Mostly B's:** Stage 3-4 (Building confidence)
**Mostly C's:** Stage 5 (Template sweet spot)
**Mostly D's:** Stage 6 (Orchestration candidate)
**Mostly E/F's:** Stage 7 (Graduate to orchestration tools)

---

## When to Progress (and When Not To)

### The YAGNI Principle for Stages

**YAGNI = "You Aren't Gonna Need It"**

Each stage adds complexity. Only progress when current stage genuinely limits you.

### Red Flags (DON'T Progress)

**1. "Future-proofing"**
- ❌ "I might need orchestration someday"
- ✅ "I need orchestration NOW because I'm managing 12 agents daily"

**2. "Keeping up with the industry"**
- ❌ "Yegge says Stage 7 is here, I should use it"
- ✅ "My current stage solves my actual problems"

**3. "It sounds cool"**
- ❌ "Orchestration sounds impressive"
- ✅ "Orchestration solves my specific pain point (coordination overhead)"

**4. "Everyone else is doing it"**
- ❌ "My colleague uses 15 agents, I should too"
- ✅ "I've measured my needs and 3 agents is optimal"

### Green Lights (DO Progress)

**1. Current stage genuinely limits you**
- ✅ IDE agent can't do multi-file refactors (Stage 2 → Stage 3-4)
- ✅ Single agent can't parallelize work (Stage 4 → Stage 5)
- ✅ 10+ agents overwhelming manual coordination (Stage 5 → Stage 6-7)

**2. You've mastered current stage**
- ✅ Understand patterns deeply (not just using them)
- ✅ Can teach others at your current stage
- ✅ Hit ceiling of current capabilities

**3. Clear ROI calculation**
- ✅ Time saved > time investment learning next stage
- ✅ Quality improves measurably
- ✅ Complexity budget allows increase

### The Jake Nations Test

Before progressing, ask:

1. **Will this make me smarter or just faster?**
   - If faster only → reconsider
   - If smarter → proceed

2. **Will this be simple or just easy?**
   - If easy (frictionless) → might bypass learning
   - If simple (one-fold) → proceed

3. **Will I understand the code this generates?**
   - If no → add learning checkpoints first
   - If yes → proceed

4. **Am I preserving complexity or creating clarity?**
   - If preserving complexity → don't progress yet
   - If creating clarity → proceed

**Source:** "The Infinite Software Crisis" - Jake Nations (Netflix)

---

## Understanding Over Speed

### The Template's Philosophy

**Stage 5 is optimal for learning because:**

1. **Transparent State**
   - features.json visible (not hidden in orchestrator)
   - Bootup ritual explicit (you see the pattern)
   - Agent coordination manual (you understand the flow)

2. **Right Level of Complexity**
   - 3-5 agents = manageable, not overwhelming
   - Patterns clear (initializer → coder → quality-reviewer)
   - Enough complexity to learn, not enough to drown

3. **Educational Value**
   - You learn WHAT orchestration solves by doing it manually first
   - When you graduate to Gas Town, you'll understand WHY it works
   - Premature orchestration = missed learning opportunity

### When Automation Hurts Learning

**Example: Bootup Ritual**

**Manual (Stage 4-5):**
```markdown
1. Read features.json
2. Check git status
3. Review last session's progress
4. Identify next feature
5. Claim feature in features.json
```

**Automated (Stage 7):**
```
Orchestrator: "Here's your next task"
```

**What you learn manually:**
- Project state management
- Context recovery patterns
- Feature dependencies
- Progress tracking

**What automation hides:**
- How state is reconstructed
- Why certain features depend on others
- How to debug when things go wrong

**When to automate:** After you've done it manually 20+ times and understand every step.

---

## Complexity Budget

### Every Stage Has a Cost

| Stage | Cognitive Load | Setup Time | Maintenance | Learning Curve |
|-------|----------------|------------|-------------|----------------|
| 1 | Low | 0 min | 0 | Traditional dev |
| 2 | Low-Medium | 5 min | 5 min/week | IDE setup |
| 3 | Medium | 10 min | 10 min/week | Trust calibration |
| 4 | Medium | 30 min | 15 min/week | Bootup rituals |
| 5 | Medium-High | 60 min | 30 min/week | Multi-agent coordination |
| 6 | High | 90 min | 60 min/week | Manual orchestration |
| 7 | Medium | 2-4 hours | Varies | Orchestration tuning |

**Observation:** Stage 7 reduces cognitive load (automation) but increases setup complexity (learning orchestrator).

**Template's position:** Stage 5 offers best learning ROI—medium cognitive load, medium setup, high educational value.

---

## Your Optimal Stage

### It's NOT Always Forward

**Stage 3 might be your optimal stage if:**
- Solo developer on small projects
- High trust in AI quality
- IDE integration sufficient

**Stage 4 might be your optimal stage if:**
- Focused, single-task workflow
- Deep work sessions
- Prefer simplicity over parallelism

**Stage 5 (template) might be your optimal stage if:**
- Educational projects
- Small teams (1-5 people)
- Transparency valued over automation
- Learning agent patterns

**Stage 6-7 might be your optimal stage if:**
- Production systems
- Large teams (10+ people)
- High agent count justified by ROI
- Mature patterns ready to automate

### Permission to Stay

**You don't need to progress.** Each stage is valuable. The "best" stage is the one that:
- Solves your current problems
- Fits your working style
- Provides value > complexity cost
- Aligns with your learning goals

---

## Common Progression Patterns

### Pattern 1: The Slow Climber
1 → 2 (6 months) → 3 (3 months) → 4 (6 months) → **stays at 4**

**Profile:** Solo developer, values simplicity, focused workflow
**Outcome:** Happy at Stage 4, no need to progress

### Pattern 2: The Fast Adopter
1 → 3 (2 weeks) → 4 (1 month) → 5 (2 months) → **stays at 5**

**Profile:** Early adopter, template user, small team lead
**Outcome:** Stage 5 optimal, understands orchestration but doesn't need it

### Pattern 3: The Orchestration Graduate
1 → 3 (1 month) → 4 (2 months) → 5 (3 months) → 6 (2 months) → 7 (1 month)

**Profile:** Production systems, large team, agent patterns mastered
**Outcome:** Graduated to Gas Town, template served as educational bridge

### Pattern 4: The Backtracker
1 → 3 → 5 → **back to 4**

**Profile:** Over-reached to Stage 5, realized single-agent simpler for their needs
**Outcome:** Learned from experiment, found true optimal stage

**Lesson:** Backtracking is success, not failure. It means you're finding your fit.

---

## Template's Role in Your Journey

### Stage 1-3: Not Needed Yet
Template is overkill. Use IDE agents, build trust, learn basics.

### Stage 4: Template Helps
- Bootup ritual guide
- Single-agent patterns (coder.md)
- features.json introduction

### Stage 5: Template Shines ⭐
- Multi-agent coordination
- Transparent state management
- Educational framework
- **This is where the template adds most value**

### Stage 6: Template Guides
- Orchestration decision framework
- When to graduate guidance
- Integration preparation

### Stage 7: Template's Graduation Gift
- features.json schema compatible with orchestrators
- Agent role patterns validate industry approaches
- Educational foundation for mastering Gas Town

---

## Next Steps

**Current Stage 1-2?**
→ Read: [Entry Points](../00-start-here/01_entry-points.md)
→ Try: [Quick Win Guide](../00-start-here/02_quick-win.md)

**Current Stage 3-4?**
→ Read: [Bootup Ritual Guide](01_bootup-ritual-guide.md)
→ Review: [Coder Agent](.claude/agents/coder.md)

**Current Stage 5?**
→ You're at the template's sweet spot!
→ Read: [Quality Workflows Guide](03_quality-workflows-guide.md)
→ Optimize: [Token Management](../02-optimization/)

**Current Stage 6?**
→ Read: [Orchestration Decision Framework](08_orchestration-decision-framework.md)
→ Evaluate: Do you genuinely need orchestration?

**Current Stage 7?**
→ Congratulations! You've graduated.
→ Consider: Integrating template patterns with your orchestrator

---

## Sources & Further Reading

**Primary Sources:**
- [Welcome to Gas Town](https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04) - Steve Yegge, Jan 2026
- [Hacker News Discussion](https://news.ycombinator.com/item?id=46458936)
- [The Infinite Software Crisis](https://www.youtube.com/watch?v=eIoohUmYpGI) - Jake Nations (Netflix)

**Related Template Docs:**
- [Orchestration Decision Framework](08_orchestration-decision-framework.md)
- [External Perspectives - Pattern 10 (Gas Town)](.claude/skills/external-perspectives/SKILL.md)
- [ANTI_PATTERNS Guide](../01-fundamentals/05_anti-patterns.md)

**Industry Context:**
- Steve Yegge's 6 Waves timeline (2022-2026)
- Each wave ~5x productivity improvement
- Template optimizes Wave 4 (coding agents, 2025 H1)
- Gas Town addresses Wave 6 (agent fleets, 2026)

---

## Navigation

← Previous: [Spec-Driven Development](06_spec-driven-development.md)
→ Next: [Orchestration Decision Framework](08_orchestration-decision-framework.md)
↑ Up: [Advanced Topics](README.md)
