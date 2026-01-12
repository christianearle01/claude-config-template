# Choose Your Learning Path

**Version:** v5.0.0-alpha.1
**Reading Time:** 3 minutes
**Purpose:** Help you choose between Problem-First (learning-oriented) and Traditional Setup (work-ready)

---

## Two Paths, Same Destination

This template offers two ways to get started with Claude Code. Both paths lead to the same outcome (configured, productive environment), but take different routes.

**Which path is right for you?**

---

## 🔥 Path 1: Problem-First Setup (NEW in v5.0.0)

**Best for:**
- ✅ New to Claude Code or this template
- ✅ Want to learn BY solving real work problems
- ✅ Prefer understanding concepts when you need them
- ✅ Have a specific problem to solve RIGHT NOW

**Philosophy:** "Apply → Hit Wall → Understand → Apply Deeper"

**What Happens:**
1. You tell us your real problem (not a tutorial)
2. We show you a 3-second demo of Claude solving similar problem
3. You start working immediately with minimal config
4. When you hit walls, we deliver just-in-time learning
5. Configuration accumulates naturally as you need it

**Time Investment:**
- Setup: 2 minutes
- First problem solved: 10-30 minutes
- Learning happens: During work, not before

**Example Journey:**
```
Your problem: "Fix SQL injection in my API"
   ↓
Demo: See Claude detect & fix vulnerability (3 seconds)
   ↓
Start working: Claude helps with YOUR code immediately
   ↓
Hit wall: "Where does Claude get project context?"
   ↓
Understanding Checkpoint: Learn about CLAUDE.md (2 min)
   ↓
Continue working: Now you understand why it matters
```

**Trade-offs:**
- ✅ Faster time to first output (< 60 seconds)
- ✅ Learning tied to real problems (better retention)
- ✅ No configuration paralysis
- ⚠️ Checkpoints interrupt work to teach (mandatory learning moments)
- ⚠️ Not ideal if you need uninterrupted work time

**Get Started:**
```bash
./scripts/problem-first-setup.sh
```

---

## 🎯 Path 2: Traditional Setup (Existing - Production Ready)

**Best for:**
- ✅ Already understand Claude Code basics
- ✅ Want to configure everything upfront
- ✅ Need work-ready environment without learning overhead
- ✅ Prefer systematic setup before working

**Philosophy:** "Understand → Configure → Apply"

**What Happens:**
1. Choose your persona (beginner/intermediate/expert)
2. Interactive wizard configures your environment
3. Review and understand all settings
4. Start working with full context

**Time Investment:**
- Setup: 5-28 minutes (persona-dependent)
- Learning: Upfront (before work)
- Work: Uninterrupted (no checkpoints)

**Example Journey:**
```
Choose persona: "Intermediate Developer"
   ↓
Wizard guides setup: CLAUDE.md, agents, settings
   ↓
Review configuration: Understand what everything does
   ↓
Start working: Fully configured, zero interruptions
```

**Trade-offs:**
- ✅ Complete control over configuration
- ✅ No interruptions during work
- ✅ Production-ready from start
- ⚠️ Longer setup time (5-28 min)
- ⚠️ Learning happens before you need it (may not stick)
- ⚠️ Risk of "configuration paralysis" (too many choices upfront)

**Get Started:**
```bash
./scripts/claude-wizard.sh
```

Or for fastest traditional setup:
```
See: docs/00-start-here/03_instant-setup.md (5 minutes)
```

---

## Decision Framework

### Choose Problem-First If:

You answer "YES" to 2+ of these:
- [ ] I'm new to Claude Code or this template
- [ ] I have a specific problem to solve today/this hour
- [ ] I prefer learning concepts when I need them
- [ ] I'm okay with occasional learning interruptions
- [ ] I want to see value before investing setup time

### Choose Traditional Setup If:

You answer "YES" to 2+ of these:
- [ ] I already understand Claude Code basics
- [ ] I prefer systematic configuration upfront
- [ ] I need uninterrupted work time
- [ ] I want full control over all settings
- [ ] I'm setting up for a team (need consistency)

---

## The Philosophical Difference

### Problem-First: Pressure-Driven Learning

**Gabriel Petersson's Methodology:**
> "Pressure from real problems accelerates learning. Start with high-stakes work, learn foundations recursively when you hit walls."

**Key Insight:** Learning delivered DURING problem-solving (when you're stuck) is far more effective than BEFORE problem-solving (when it's hypothetical).

**This is NOT:**
- ❌ "Speed over understanding" (Jake Nations warned against this)
- ❌ "Copy-paste without learning"
- ❌ "Tutorial problems" (fake pressure)

**This IS:**
- ✅ Real work problems (real pressure)
- ✅ Just-in-time understanding (maximum receptivity)
- ✅ Mandatory verification (can't proceed without demonstrating understanding)

### Traditional: Systematic Preparation

**Classic Learning Model:**
> "Understand the system first, then apply it confidently."

**Key Insight:** Comprehensive upfront understanding prevents confusion and wasted effort during execution.

**This is NOT:**
- ❌ "Boring documentation reading"
- ❌ "Configuration for hypothetical futures"
- ❌ "One-size-fits-all"

**This IS:**
- ✅ Persona-based routing (tailored to your level)
- ✅ Interactive wizards (guided configuration)
- ✅ Production-ready (team-tested patterns)

---

## Can I Switch Paths Later?

**Yes!** The paths are complementary, not exclusive.

### Problem-First → Traditional

After problem-first learning:
- You'll have minimal config + understanding of key concepts
- Run traditional setup wizard to add advanced features
- Your checkpoint-learned knowledge carries over

### Traditional → Problem-First

After traditional setup:
- You can still use problem-first guides as learning resources
- Understanding checkpoints won't trigger (you already know concepts)
- Demos available anytime: `./demos/[category]/demo.sh`

---

## What Both Paths Give You

**Regardless of path chosen, you'll have:**

- ✅ Optimized Claude Code configuration (50-95% token savings)
- ✅ Project-specific CLAUDE.md (persistent memory)
- ✅ Custom agents (specialized workflows)
- ✅ Skills (account-level expertise)
- ✅ MCP integration (external data sources)
- ✅ Quality workflows (security, testing, standards)

**The difference is TIMING:**
- Problem-First: Learn features when you need them
- Traditional: Learn features before you use them

---

## Real User Scenarios

### Scenario 1: Solo Developer, New Project

**Context:** Building personal project, new to Claude Code

**Best Path:** Problem-First
- Start working immediately on your project
- Learn Claude Code features as your project needs them
- Configuration grows with project complexity

### Scenario 2: Team Setup, Production App

**Context:** Onboarding team to Claude Code, existing codebase

**Best Path:** Traditional Setup
- Configure once, share config across team
- Everyone starts with same settings (consistency)
- No learning interruptions during sprints

### Scenario 3: Experienced User, New Template

**Context:** Used Claude Code before, adopting this template

**Best Path:** Traditional Setup (Instant Setup)
- You know Claude Code, just need template patterns
- 5-minute setup, skip persona questions
- Customize as needed

### Scenario 4: Debugging Crisis

**Context:** Production bug, need solution NOW

**Best Path:** Problem-First
- Zero setup time, start working in 60 seconds
- Claude helps with immediate problem
- Learn configuration later when crisis resolved

---

## Still Unsure?

### Try This Quick Test:

**Answer this question:**
> "Do you have a specific code problem you need to solve in the next 2 hours?"

- **YES** → Problem-First Setup (solve that problem while learning)
- **NO** → Traditional Setup (explore and configure systematically)

### Or Flip a Coin:

Both paths are valid. The template is designed to work either way.

**Heads:** Problem-First (embrace the chaos, learn by doing)
**Tails:** Traditional (systematic preparation, confident execution)

---

## Next Steps

### Ready for Problem-First?
```bash
cd /path/to/your/project
/path/to/claude-config-template/scripts/problem-first-setup.sh
```

**Then:** Tell us your problem, watch demo, start solving

### Ready for Traditional?
```bash
cd /path/to/your/project
/path/to/claude-config-template/scripts/claude-wizard.sh
```

**Or:** Read Instant Setup guide for fastest traditional path
- See: `docs/00-start-here/03_instant-setup.md`

---

## Questions?

**"Can I try Problem-First as a demo without committing?"**
- Yes! Run `problem-first-setup.sh` in a test directory
- No permanent changes to your system
- Exit anytime during wizard

**"I chose wrong path, can I start over?"**
- Yes! Both paths are non-destructive
- Just delete `.claude/` directory and start again
- Or run second wizard to add features

**"Can I mix-and-match features from both paths?"**
- Absolutely! Use what works for you
- Both paths create compatible configurations
- Customize freely after setup

---

## Philosophy Resources

**If you want to understand the "why" behind Problem-First:**
- Gabriel Petersson's methodology: `.claude/plans/typed-fluttering-willow.md`
- Jake Nations Test (Understanding Over Speed): `docs/00-start-here/05_anti-patterns.md`
- Proactive Paradigm: `docs/00-start-here/10_proactive-paradigm.md`

**If you want to understand traditional patterns:**
- Learning Journey: `docs/README.md`
- Personas Guide: `docs/00-start-here/personas/README.md`
- Setup Context: `.claude/SETUP_CONTEXT.md`

---

## The Bottom Line

**Problem-First:**
- Fast start, learn during work, checkpoints mandatory
- Best for: New users, urgent problems, learning-oriented

**Traditional:**
- Systematic setup, learn before work, no interruptions
- Best for: Experienced users, team setups, work-oriented

**Both paths are valid. Choose based on your current needs, not future hypotheticals.**

---

**Navigation:**
- **Up:** `docs/00-start-here/01_entry-points.md` (Main navigation hub)
- **Problem-First Next:** `01_how-claude-solves-problems.md` (See Claude in action)
- **Traditional Next:** `docs/00-start-here/03_instant-setup.md` (5-minute setup)

---

**Version:** v5.0.0-alpha.1
**Last Updated:** 2025-01-13
**Path:** `docs/00-start-here/problem-first/00_choose-your-learning-path.md`
