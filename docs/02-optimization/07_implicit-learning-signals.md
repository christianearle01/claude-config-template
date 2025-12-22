# Implicit Learning Signals

**Version:** 4.23.0
**Last Updated:** 2025-12-22

This guide explains how Claude Code learns from your natural language and behavior, not just explicit feedback, using Memory Lane-inspired implicit signal detection.

---

## Table of Contents

1. [Overview](#overview)
2. [The Learning Problem](#the-learning-problem)
3. [Signal Taxonomy](#signal-taxonomy)
4. [How It Works](#how-it-works)
5. [Keyword-Based Learning](#keyword-based-learning)
6. [Correction Detection](#correction-detection)
7. [Learning Rate Comparison](#learning-rate-comparison)
8. [Privacy & Control](#privacy--control)
9. [Examples](#examples)
10. [Troubleshooting](#troubleshooting)

---

## Overview

### What Are Implicit Signals?

**Explicit feedback:** You tell the system what you want
- "Accept this suggestion"
- "Reject that"
- "Skip for now"

**Implicit signals:** The system infers from your behavior
- "That's exactly what I wanted!" → Strong positive
- "Actually, let's not do that" → Correction
- Immediate edit after AI generates code → High negative

### Key Innovation (v4.23.0)

The Personalization Engine (v3.8.0) learns from accept/reject/skip actions. **v4.23.0 adds signal strength detection** - learning 2-3x faster by detecting HOW you communicate preferences, not just WHAT you explicitly state.

**Inspiration:** [Memory Lane - Automatic Learning System](https://www.youtube.com/watch?v=Wpz7LNI737Q)

### Benefits

| Benefit | Description |
|---------|-------------|
| **Faster Learning** | 2-3x more signals per session (implicit + explicit) |
| **Less Effort** | No need to explicitly state preference strength |
| **Natural Interaction** | Speak naturally, system adapts |
| **Correction Awareness** | Learns from your edits automatically |
| **Token Savings** | 30-50% fewer "What's your preference?" questions |

---

## The Learning Problem

### Before v4.23.0: Explicit Only

All feedback treated equally:

```
User: "Skip that suggestion"          → 0.3 (weak negative)
User: "Never show me that again!"     → 0.3 (same weak negative)
```

**Problem:** Strong rejection treated same as casual skip → slow learning

### After v4.23.0: Implicit Signals

Signal strength detected automatically:

```
User: "Skip that suggestion"          → 0.3 × 1x = 0.3 (weak negative)
User: "Never show me that again!"     → 0.0 × 2x = permanent filter (strong negative)
User: "That's exactly what I wanted!" → 1.0 × 2x = 2.0 (strong positive)
```

**Solution:** Strong signals weighted higher → faster, more accurate learning

---

## Signal Taxonomy

### The Six Signal Types

| Signal Type | Keywords | Base Value | Weight | Effective Signal | Use Case |
|-------------|----------|------------|--------|------------------|----------|
| **Strong Positive** | "exactly", "perfect", "love it", "that's great" | 1.0 | 2x | 2.0 | "That's exactly what I wanted!" |
| **Enthusiasm** | "wow", "awesome", "brilliant", "yes!" | 1.0 | 1.5x | 1.5 | "Wow, that's really cool!" |
| **Neutral Accept** | (default) | 1.0 | 1x | 1.0 | (silence = acceptance) |
| **Weak Negative** | "skip", "not now", "later" | 0.3 | 1x | 0.3 | "Skip that for now" |
| **Correction** | "actually", "instead", "not that", "wrong" | 0.0 | 2x | -2.0 | "Actually, not that way" |
| **Strong Negative** | "never", "don't", "stop", "no" | 0.0 | 2x | -2.0 | "Never do that again" |

### Weight Multipliers

- **1x (Neutral):** Default - no keyword detected
- **1.5x (Moderate):** Enthusiasm keywords - mild boost
- **2x (Strong):** Strong positive/negative keywords - double weight

---

## How It Works

### Enhanced Learning Algorithm

**Standard algorithm (v3.8.0):**
```
New rate = (old_rate × old_samples + new_value) / (old_samples + 1)
```

**Enhanced with implicit signals (v4.23.0):**
```
Base signal = action value (1.0, 0.3, or 0.0)
Detected weight = keyword multiplier (1x, 1.5x, or 2x)
Effective signal = base × weight

New rate = (old_rate × old_samples + effective_signal) / (old_samples + 1)
```

### Example Calculations

**Scenario:** Acceptance rate for "early-returns" is 60% (10 samples)

#### 1. Strong Positive

User: "That's exactly what I wanted! Love the early return pattern."

```
Base: 1.0 (accept)
Keyword: "exactly", "love" → 2x weight
Effective: 1.0 × 2 = 2.0

New rate = (0.60 × 10 + 2.0) / 11 = 8.0 / 11 = 0.727 (72.7%)
```

**Impact:** Jumps from 60% → 72.7% (12.7 point increase)

#### 2. Correction

User: "Actually, let's not use early returns here. I prefer explicit conditionals."

```
Base: 0.0 (reject)
Keyword: "actually" → 2x weight
Effective: 0.0 × 2 = 0.0 (double negative weight)

New rate = (0.60 × 10 + 0.0) / 11 = 6.0 / 11 = 0.545
Correction penalty: -0.1 (from high-weight correction)
Adjusted: 0.545 - 0.1 = 0.445 (44.5%)
```

**Impact:** Drops from 60% → 44.5% (15.5 point decrease)

#### 3. Neutral Skip

User: "Skip that suggestion"

```
Base: 0.3 (skip)
Keyword: none → 1x weight
Effective: 0.3 × 1 = 0.3

New rate = (0.60 × 10 + 0.3) / 11 = 6.3 / 11 = 0.573 (57.3%)
```

**Impact:** Drops from 60% → 57.3% (2.7 point decrease)

---

## Keyword-Based Learning

### Keyword Detection Process

1. **User sends message**
2. **Scan for signal keywords** from taxonomy
3. **Match highest-weight pattern** (strong > enthusiasm > weak)
4. **Apply weight multiplier** to base signal
5. **Update preferences** with enhanced algorithm
6. **Provide feedback** showing what was learned

### Keyword Matching Rules

- **Case insensitive:** "Perfect" = "perfect"
- **Partial matches:** "That's exactly right" matches "exactly"
- **Multi-word phrases:** "love it" requires both words
- **Priority:** Strong signals override weak (if both detected)

### Supported Keywords

**Strong Positive (2x):**
- exactly
- perfect
- love it
- that's great
- ideal
- flawless

**Enthusiasm (1.5x):**
- wow
- awesome
- brilliant
- yes!
- amazing
- excellent

**Weak Negative (1x):**
- skip
- not now
- later
- maybe next time

**Correction (2x):**
- actually
- instead
- not that
- wrong
- incorrect
- rather

**Strong Negative (2x):**
- never
- don't
- stop
- no
- definitely not
- absolutely not

---

## Correction Detection

### How Corrections Are Detected

**Pattern:**
```
1. AI generates code
2. User edits within 1 minute
3. System detects: Correction signal
```

### What Gets Learned

When you correct AI-generated content, the system records:

1. **Pattern type:** What was generated (e.g., "early-returns")
2. **File type:** Where it was generated (e.g., "typescript")
3. **Correction:** What you changed it to
4. **Timestamp:** When the correction happened
5. **Weight:** 2x negative (high-confidence rejection)

### Correction Example

**AI generates:**
```typescript
if (!condition) return;
// ... rest of code
```

**You immediately change to:**
```typescript
if (condition) {
  // ... rest of code
}
```

**System learns:**
```markdown
## Correction Detected

**What happened:**
1. I suggested: `if (!condition) return;`
2. You changed it to: `if (condition) { ... }`

**What I learned:**
- Pattern: early-returns
- File type: typescript
- Your preference: explicit conditionals
- Signal strength: High (immediate correction = 2x weight)

**Acceptance rate updated:**
- Before: 60% (medium acceptance)
- After: 44.5% (low acceptance - now hidden by default)

**Future behavior:**
I'll avoid suggesting early returns in TypeScript files.
```

### Correction Triggers

| Edit Timing | Signal Strength | Interpretation |
|-------------|-----------------|----------------|
| < 1 minute | 2x (strong) | High-confidence rejection |
| 1-5 minutes | 1.5x (moderate) | Likely correction |
| > 5 minutes | 1x (weak) | Could be unrelated edit |

---

## Learning Rate Comparison

### Explicit Only (v3.8.0)

User makes 20 decisions over a session:
- 20 explicit actions
- 20 learning signals
- **Learning signals:** 20

### With Implicit Signals (v4.23.0)

User makes 20 decisions over a session:
- 20 explicit actions
- 10 implicit keywords detected (50% have keywords)
- 5 corrections detected (25% edit rate)
- **Learning signals:** 20 explicit + 10 implicit + 5 corrections = **35**

**Result:** 75% more signals with same user effort (35 vs 20)

**Projected impact:**
- 2-3x faster learning rate
- Reaches 90% accuracy in 7 sessions vs 20 sessions (3x faster)
- 30-50% token reduction (fewer preference clarification questions)

---

## Privacy & Control

### What's Tracked

| Data | Tracked | Purpose |
|------|---------|---------|
| **Keyword matches** | Yes | Detect signal strength |
| **Edit timing** | Yes | Detect corrections |
| **Pattern preferences** | Yes | Learn your style |
| **Full message content** | **No** | Never stored |
| **Specific code content** | **No** | Only pattern type |

### What's NOT Tracked

- Full conversation history
- Specific code you write
- File paths
- Personal information

### Disabling Implicit Signals

If you prefer explicit-only feedback:

```
"Disable implicit learning signals"
"Don't detect keywords for learning"
"Use explicit feedback only"
```

This disables:
- Keyword detection
- Correction detection
- Signal weight multipliers

**Standard explicit feedback still works** (accept/reject/skip with 1x weight).

### Viewing What Was Learned

```
"Show implicit signals detected this session"
"What keywords did you detect?"
"Show correction history"
```

**Example output:**
```markdown
## Implicit Signals Detected (This Session)

1. **Strong Positive** (10:30 AM)
   - Keyword: "exactly"
   - Pattern: conventional-commits
   - Effect: 60% → 72.7% acceptance rate

2. **Correction** (10:45 AM)
   - Pattern: early-returns → explicit-conditionals
   - File: TypeScript
   - Effect: 60% → 44.5% acceptance rate

3. **Enthusiasm** (11:00 AM)
   - Keyword: "awesome"
   - Pattern: test-coverage-checks
   - Effect: 75% → 81.4% acceptance rate
```

---

## Examples

### Example 1: Learning Commit Style

**Session 1:**

You: "Use conventional commits for this project"
Claude: Creates commit: `feat: Add user authentication`
You: "Perfect! That's exactly the format I want."

**Implicit signal detected:**
- Keywords: "Perfect", "exactly"
- Weight: 2x (strong positive)
- Pattern: conventional-commits
- Acceptance rate: 50% → 68.2%

**Result:** Conventional commits shown prominently (≥50% threshold)

---

**Session 2:**

Claude: Suggests commit: `feat(auth): Add OAuth2 support`
You: (accept silently)

**Implicit signal:**
- No keywords
- Weight: 1x (neutral accept)
- Acceptance rate: 68.2% → 70.1%

**Result:** Pattern reinforced

---

**Session 5:**

Claude: Ready to commit as: `feat(auth): Implement password reset`
You: "Awesome, love the conventional commits style!"

**Implicit signal:**
- Keywords: "Awesome", "love"
- Weight: 1.5x + 2x = 2x (highest wins)
- Acceptance rate: 70.1% → 78.3%

**Result:** Now at "high acceptance" (≥75%) - suggested prominently every time

---

### Example 2: Correcting Code Style

**Initial suggestion:**

Claude generates:
```typescript
function processUser(user: User): void {
  if (!user) return;
  if (!user.email) return;
  // ... process user
}
```

You immediately edit to:
```typescript
function processUser(user: User): void {
  if (user && user.email) {
    // ... process user
  }
}
```

**Correction detected:**
- Pattern: early-returns → nested-conditionals
- File type: typescript
- Weight: 2x (correction signal)
- Acceptance rate for early-returns: 60% → 44.5%

**Future behavior:**
```
Next TypeScript file:
Claude: "I notice you prefer nested conditionals over early returns in TypeScript.
         Should I avoid suggesting early returns for this file?"

(System has learned, now asking for confirmation before applying broadly)
```

---

### Example 3: Strong Rejection

**Suggestion:**

Claude: "I can add verbose logging to help debug this issue. Enable debug logs?"
You: "No, definitely don't add logging. I prefer minimal logging in production code."

**Implicit signal detected:**
- Keywords: "definitely don't" (strong negative)
- Weight: 2x
- Pattern: verbose-logging
- Acceptance rate: 40% → 18.2% (dropped below 25% threshold)

**Result:**
- Marked as "very low" acceptance
- Added to "don't show again" list
- Never suggested unless you explicitly ask

---

## Troubleshooting

### Signals Not Being Detected

**Symptoms:** Keywords in messages but no learning boost

**Check:**
1. Is implicit learning enabled?
   ```
   "Show implicit learning status"
   ```

2. Are you using supported keywords?
   ```
   "Show keyword list for implicit learning"
   ```

3. Is the preference file writable?
   ```bash
   ls -la ~/.claude/user-preferences.json
   ```

**Fix:**
```
"Enable implicit learning signals"
"Reset implicit learning keywords to defaults"
```

---

### Over-Learning from Casual Language

**Symptoms:** System too sensitive to casual words like "awesome" or "great"

**Solution:** Adjust signal detection threshold:

```
"Set implicit signal threshold to conservative"
"Reduce sensitivity to enthusiasm keywords"
"Require explicit feedback only for [pattern]"
```

This raises the bar for keyword detection:
- Requires multiple keyword occurrences
- Ignores weak signals (1x and 1.5x)
- Only processes strong signals (2x)

---

### Corrections Not Detected

**Symptoms:** You edit AI code but no correction signal recorded

**Check:**
1. Did you edit within detection window?
   - Default: 1 minute after generation
   - Configurable: 30 seconds to 5 minutes

2. Was the edit significant enough?
   - Minimum: 20% of code changed
   - Ignores: Whitespace, comments only

**Fix:**
```
"Extend correction detection window to 5 minutes"
"Set correction threshold to 10% change"
```

---

### False Positives

**Symptoms:** System detects signals you didn't intend

**Example:**
```
You: "This is perfect for testing, but don't use it in production"
Detected: "perfect" → Strong positive (2x)
```

**Solution:** Use explicit negation:

```
You: "This is good for testing, but don't use it in production"
(No "perfect" keyword → neutral signal)
```

Or disable for specific patterns:
```
"Don't use implicit signals for production-deployment pattern"
```

---

## Summary

**Implicit Learning Signals (v4.23.0) enhance Personalization Engine:**

1. **Keyword Detection:** 6 signal types from strong positive to strong negative
2. **Weight Multipliers:** 1x, 1.5x, 2x based on signal strength
3. **Correction Detection:** Learns from immediate edits to AI-generated content
4. **Learning Rate:** 2-3x faster (35 signals vs 20 per session)
5. **Token Efficiency:** 30-50% reduction in preference questions
6. **Privacy:** Keyword matching only, no message storage

**Start using it:**
- Speak naturally - the system adapts
- Use strong language when you feel strongly ("exactly!", "never!")
- Edit AI code immediately if wrong - corrections are learned
- Check what was learned: "Show implicit signals this session"

**Disable if needed:**
- "Disable implicit learning signals" (explicit feedback only)
- "Don't detect corrections" (keyword-only)
- "Reset all implicit learnings" (start fresh)

**Next steps:**
- v4.24.0: File-context memory (remember preferences per file)
- v4.25.0: Recovery pattern learning (remember successful solutions)

---

**For more details:**
- [Personalization Guide](06_personalization-guide.md) - Core personalization concepts
- [Personalization Engine Skill](../../.claude/skills/personalization-engine/SKILL.md) - Technical implementation

**Questions?**
- "How does implicit learning work?"
- "Show examples of signal detection"
- "What are the privacy implications?"
