# Understanding Checkpoints Skill

**Version:** v5.0.0-alpha.1
**Purpose:** Adaptive learning system that delivers just-in-time understanding
**Type:** Auto-invoked skill (triggers on detection patterns)

---

## Overview

Understanding Checkpoints is an adaptive learning skill that detects when users hit "walls" during problem-solving and delivers targeted understanding at moments of maximum receptivity.

**Core Philosophy:** Learning delivered DURING problem-solving (when needed) is 10x more effective than BEFORE problem-solving (when hypothetical).

---

## Files in This Skill

1. **SKILL.md** - Core skill definition and checkpoint protocol
   - Auto-activation triggers
   - Checkpoint execution protocol
   - Verification system
   - Integration with problem-first setup

2. **checkpoint-scenarios.md** - Quick reference guide
   - Detection matrix for common scenarios
   - Quick checkpoint triggers
   - Verification response patterns
   - Checkpoint pacing guidelines

3. **README.md** - This file (overview)

---

## How It Works

### 1. Detection Phase

Claude monitors for trigger patterns:
- **Error messages** containing config-related keywords
- **Repeated queries** about same concept (2+ times)
- **Configuration blocks** (user tries feature without required setup)
- **Confusion patterns** ("I don't understand", "wait", clarifying questions)
- **Problem-first marker** (`.claude/.problem-first-setup` exists)

### 2. Checkpoint Activation

When trigger detected, Claude:
1. Interrupts current task with checkpoint banner
2. Delivers understanding using three components:
   - ELI12 analogy (build intuition)
   - Intermediate states (show HOW things transform)
   - Traditional vs Claude-assisted comparison (show differences)

### 3. Verification

User must demonstrate understanding before proceeding:
- **Explain back:** "In your own words, why does this work?"
- **Predict outcome:** "If I changed X, what would happen?"
- **Identify when to apply:** "When would you use this vs not use it?"

### 4. Resume

After successful verification, resume original task with new understanding.

---

## Integration with Problem-First Setup

When user completes `problem-first-setup.sh`, a marker file is created:

```bash
# .claude/.problem-first-setup
setup_date=2025-01-13
user_problem=Fix SQL injection in my API
problem_category=bug-fix
first_session=true
```

This enables:
- **Tailored analogies** to user's problem domain
- **Adjusted checkpoint frequency** based on session count
- **Problem-specific examples** during explanations

---

## Usage Examples

### Auto-Activation (Most Common)

```
User: "How do I make Claude remember my project?"
       ↓
Claude detects: Configuration gap (CLAUDE.md needed)
       ↓
🛑 Understanding Checkpoint triggered
       ↓
Explains CLAUDE.md with analogy, mechanism, comparison
       ↓
Verifies user understanding
       ↓
Proceeds to create CLAUDE.md
```

### Manual Invocation (User Requests)

```
User: "Can you explain how prompt caching works?"
       ↓
Claude detects: Explicit learning request
       ↓
✅ Understanding Request Detected
       ↓
Executes checkpoint (no wall needed - user is asking to learn)
```

### Checkpoint Skipping (Expert Detection)

```
User: "I need to configure prompt caching with 5-minute TTL for
      high-frequency queries, but preserve default TTL for background jobs."
       ↓
Claude detects: Expert-level language (no checkpoint needed)
       ↓
Proceeds directly with solution
```

---

## Success Metrics (v5.0.0 Alpha Goals)

**Effectiveness:**
- Target: 80% pass rate on first verification attempt
- Measure: Track user responses, count functional understanding

**Retention:**
- Target: Users don't hit same wall twice in session
- Measure: Track repeat triggers for same concept

**User Experience:**
- Target: "Aha moments" not "interruption annoyance"
- Measure: Qualitative feedback

---

## Configuration

**No configuration needed** - This skill auto-activates based on detection patterns.

**Optional Adjustments:**
- Checkpoint frequency can be tuned via personalization-engine
- Analogy complexity adapts to user's demonstrated understanding level
- Verification difficulty adjusts based on user's pass/fail history

---

## Relationship to Other Components

**Problem-First Setup:**
- Creates `.claude/.problem-first-setup` marker
- Checkpoints read this file to tailor learning

**Personalization Engine:**
- Tracks checkpoint pass/fail history
- Adapts frequency and difficulty
- Remembers which concepts user understands

**Projects Registry:**
- Provides project context for tailored analogies
- Different checkpoint thresholds per project type

**Quality Reviewer:**
- Can trigger security/quality checkpoints before commits
- Prevents bad code from entering codebase

---

## For Developers

### Adding New Checkpoint Scenarios

1. Identify trigger pattern (error message, query pattern, etc.)
2. Create checkpoint template in `checkpoint-scenarios.md`
3. Add to detection matrix
4. Test with sample user queries

### Testing Checkpoints

```bash
# Test checkpoint trigger
User query: "How do I configure X?"
Expected: Checkpoint triggered if X requires setup

# Test verification
User response: [Generic explanation]
Expected: Request clarification

User response: [Specific, correct explanation]
Expected: Pass verification, proceed
```

---

## Version History

- **v5.0.0-alpha.1 (2025-01-13):** Initial implementation
  - Auto-detection system
  - Five trigger patterns
  - Three-component checkpoint protocol
  - Mandatory verification system
  - Problem-first integration

---

## Resources

- **Full Protocol:** See `SKILL.md`
- **Quick Reference:** See `checkpoint-scenarios.md`
- **Philosophy:** See `/Users/christianearle01/.claude/plans/typed-fluttering-willow.md`

---

**Status:** Active in v5.0.0-alpha.1
**Last Updated:** 2025-01-13
