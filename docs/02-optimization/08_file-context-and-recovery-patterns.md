# File-Context Memory & Recovery Pattern Learning

**Version:** 4.24.0
**Last Updated:** 2025-12-22

This guide explains how Claude Code remembers context-specific preferences and learns from your problem-solving patterns.

---

## Table of Contents

1. [Overview](#overview)
2. [File-Context Memory](#file-context-memory)
3. [Recovery Pattern Learning](#recovery-pattern-learning)
4. [Integration with v4.23.0](#integration-with-v4230)
5. [Examples](#examples)
6. [Commands](#commands)
7. [Privacy & Data](#privacy--data)
8. [Troubleshooting](#troubleshooting)

---

## Overview

### The Evolution

**v3.8.0 (Personalization Engine):** Learn preferences globally
**v4.23.0 (Implicit Signals):** Learn from behavior, not just actions (2-3x faster)
**v4.24.0 (Context + Recovery):** Learn WHERE and HOW you solve problems

### Two New Capabilities

1. **File-Context Memory:** Different files, different preferences
   - CLAUDE.md gets sentence-case headers
   - README.md gets title-case headers
   - System remembers which is which

2. **Recovery Pattern Learning:** Remember solutions that worked after struggle
   - Track: Try A (fails) → Try B (fails) → Try C (works!)
   - Next time: Suggest C immediately
   - Confidence: 95% (proven through trial-and-error)

### Why This Matters

**Problem without context:**
```
You: Edit CLAUDE.md with sentence-case headers for 3 months
You: Edit README.md with title-case headers for 1 day
You: Go back to CLAUDE.md
System: Suggests title-case (most recent, wrong for this file!)
```

**With file-context (v4.24.0):**
```
You: Edit CLAUDE.md
System: "Loading CLAUDE.md preferences: sentence-case headers (95% acceptance, 47 samples)"
System: Suggests sentence-case (correct for this file!)
```

---

## File-Context Memory

### The Problem

**Global preferences don't respect context:**

| Scenario | Global Preference Problem |
|----------|--------------------------|
| Different files | CLAUDE.md (sentence-case) vs README.md (title-case) → confused system |
| Different directories | `/docs/` (formal) vs `/examples/` (casual) → wrong tone |
| Different file types | `.ts` (strict types) vs `.js` (loose types) → mismatched suggestions |

**Result:** System "forgets" file-specific patterns, makes wrong suggestions.

### The Solution: Context Tagging

Tag every preference with the file/pattern where it was learned.

**Four Context Levels:**

| Level | Pattern | Specificity | Example |
|-------|---------|-------------|---------|
| **Exact File** | Full path | Highest | `CLAUDE.md` → sentence-case |
| **Glob Pattern** | Wildcard match | High | `docs/**/*.md` → formal tone |
| **File Type** | Extension | Medium | `*.ts` → strict TypeScript |
| **Directory** | Path prefix | Low | `/examples/` → casual tone |

**Matching Priority:**

```
1. Exact file path (CLAUDE.md)          ← Most specific
2. Specific glob (docs/**/*.md)
3. General file type (*.md)
4. Directory (/docs/)
5. Global preference                    ← Fallback
```

### How It Works

**On File Edit:**

```
1. User opens file: CLAUDE.md
2. System checks: Do I have preferences for "CLAUDE.md"?
3. System loads:
   - Exact match: CLAUDE.md → sentence-case headers (95%)
   - Inherited from *.md → no-line-length-limit (80%)
   - Inherited from docs/ → emoji-in-headers-only (90%)
4. Apply these preferences to suggestions
```

**On Learning:**

```
1. User accepts suggestion in CLAUDE.md
2. System updates:
   - Global preference: sentence-case headers (general)
   - File-context: CLAUDE.md → sentence-case headers (specific)
3. Both stored for different contexts
```

### Storage Format

**In `~/.claude/user-preferences.json`:**

```json
{
  "fileContextPreferences": {
    "CLAUDE.md": {
      "header-style": {
        "preference": "sentence-case",
        "acceptanceRate": 0.95,
        "samples": 47,
        "lastUsed": "2025-12-22T14:30:00Z"
      },
      "line-length": {
        "preference": "no-limit",
        "acceptanceRate": 0.88,
        "samples": 23
      }
    },
    "*.md": {
      "line-length": {
        "preference": "no-limit",
        "acceptanceRate": 0.80,
        "samples": 156
      }
    },
    "docs/**/*.md": {
      "emoji-usage": {
        "preference": "section-headers-only",
        "acceptanceRate": 0.90,
        "samples": 34
      },
      "tone": {
        "preference": "formal-educational",
        "acceptanceRate": 0.85,
        "samples": 28
      }
    },
    "/examples/": {
      "tone": {
        "preference": "casual-practical",
        "acceptanceRate": 0.92,
        "samples": 15
      }
    }
  }
}
```

### Conflict Resolution

**What happens when file-context conflicts with global?**

**File-context always wins** (more specific = higher priority)

**Example:**

```
Global preference: title-case headers (60% acceptance)
CLAUDE.md preference: sentence-case headers (95% acceptance)

When editing CLAUDE.md:
→ Use sentence-case (file-specific wins)
→ Show: "Using CLAUDE.md preference (sentence-case, 95%) instead of global (title-case, 60%)"
```

**Why:** 95% in specific context > 60% globally

### Inheritance

**Patterns inherit from more general patterns:**

```
Editing: docs/01-fundamentals/02_quick-start.md

Loaded preferences (in priority order):
1. Exact: docs/01-fundamentals/02_quick-start.md (none found)
2. Specific: docs/**/*.md → formal tone (90%)
3. General: *.md → no line limit (80%)
4. Directory: /docs/ → emoji in headers (85%)
5. Global: (fallback)

Result: Combines formal tone + no line limit + emoji in headers
```

---

## Recovery Pattern Learning

### The Problem

**Valuable solutions are forgotten:**

```
Monday: TypeScript import error
        You try: relative paths (fails)
        You try: namespace imports (fails)
        You try: default import with type (works!)
        Time: 20 minutes

Friday: Same TypeScript import error
        System: No memory of Monday's solution
        You: Repeat the same 20-minute trial-and-error
```

**Result:** Hard-won knowledge lost, effort wasted.

### The Solution: Track Recovery Sequences

**Pattern:** Fail → Fail → Success = Remember the winner

**What gets recorded:**

| Element | What | Why |
|---------|------|-----|
| **Task** | "fix-typescript-import-error" | Identify similar problems |
| **Failed Approaches** | ["relative-path", "namespace"] | Avoid these next time |
| **Successful Approach** | "default-import-with-type" | Use this next time |
| **Confidence** | 95% | Proven through struggle |
| **Context** | TypeScript, import errors | When to apply |

### Detection Logic

**1. Failure Detection:**

System detects failure when:
- Tests fail after code generation
- Build errors occur
- User says: "that didn't work", "still broken", "try again"
- User immediately edits code (correction signal from v4.23.0)

**2. Attempt Tracking:**

Track attempts when:
- Same task attempted multiple times within 30 minutes
- Different approaches each time
- Clear progression: A → B → C

**3. Success Detection:**

System detects success when:
- Tests pass after previous failures
- Build succeeds after errors
- User says: "that worked!", "fixed!", "perfect!"
- No further edits for 5+ minutes (silent success)

**4. Pattern Recording:**

Store recovery pattern:
```json
{
  "recoveryPatterns": {
    "fix-typescript-import-error": {
      "context": {
        "errorType": "typescript-import",
        "attempts": 3,
        "failedApproaches": [
          "relative-path-import",
          "namespace-import"
        ],
        "successfulApproach": "default-import-with-type",
        "confidence": "high"
      },
      "metadata": {
        "firstAttempt": "2025-12-22T10:00:00Z",
        "resolved": "2025-12-22T10:20:00Z",
        "timeTaken": "20 minutes",
        "fileType": "typescript",
        "successRate": 1.0,
        "timesApplied": 5
      }
    }
  }
}
```

### Proactive Suggestions

**Next time similar task is detected:**

```markdown
## 🎯 Recovery Pattern Detected

**Task:** Fixing TypeScript import error
**I remember:** You solved this before (took 20 minutes, 3 attempts)

**What didn't work:**
1. ❌ relative-path-import (failed)
2. ❌ namespace-import (failed)

**What worked:**
✅ **default-import-with-type** (success!)

**Apply proven solution?**
This worked 5 times before with 100% success rate.

[Apply] [Show me why] [Try different approach]
```

### Confidence Scoring

Recovery patterns have **higher confidence** than regular learnings:

| Learning Type | Confidence | Reason |
|--------------|------------|--------|
| **Regular accept** | 75% | Single positive signal |
| **Strong positive** | 85% | Enthusiastic feedback (v4.23.0) |
| **Recovery pattern** | 95% | Proven through struggle |

**Why higher confidence?**

- **Validated:** Multiple approaches tested, this one won
- **Costly:** User invested time (5-20 minutes typical)
- **Comparative:** Success proven against failures
- **Memorable:** Struggle → success creates strong association

### Psychology: Why Recovery Patterns Work

**From educational research:**

- **Desirable difficulties:** Struggling before success = stronger memory
- **Comparative learning:** Seeing what doesn't work clarifies what does
- **Invested effort:** Time spent = higher value perceived
- **Emotional valence:** Frustration → relief = memorable event

**Result:** Solutions found through trial-and-error stick better than immediate successes.

---

## Integration with v4.23.0

### Combined Features

v4.24.0 builds on v4.23.0 implicit learning signals:

| v4.23.0 Feature | v4.24.0 Enhancement |
|-----------------|---------------------|
| **Keyword detection** | Now tagged with file context |
| **Correction signals** | Can trigger recovery pattern detection |
| **Acceptance rate** | Stored per file context AND globally |

### Example: Full Learning Pipeline

**Scenario:** Fixing TypeScript error in `src/auth.ts`

**Attempt 1:** (10:00 AM)
```
AI suggests: relative path import
User edits immediately (correction signal, v4.23.0)
System: Records failure + correction
File context: src/auth.ts
```

**Attempt 2:** (10:05 AM)
```
AI suggests: namespace import
Build fails
User says: "still broken" (implicit signal, v4.23.0)
System: Records second failure
```

**Attempt 3:** (10:15 AM)
```
AI suggests: default import with type
Build succeeds
User says: "Perfect! That's exactly what I wanted!" (strong positive, v4.23.0)
System: Records success + creates recovery pattern
```

**What gets stored:**

1. **File-context (v4.24.0):**
   ```json
   {
     "src/auth.ts": {
       "import-style": {
         "preference": "default-with-type",
         "acceptanceRate": 1.0,
         "samples": 1
       }
     }
   }
   ```

2. **Recovery pattern (v4.24.0):**
   ```json
   {
     "typescript-import-error": {
       "failedApproaches": ["relative-path", "namespace"],
       "successfulApproach": "default-with-type",
       "confidence": 0.95
     }
   }
   ```

3. **Implicit signal (v4.23.0):**
   - Strong positive keyword: "Perfect! exactly" (2x weight)
   - Acceptance rate boosted to 1.0 immediately

**Next time in src/auth.ts:**
- Loads file-context: default-with-type (100%)
- Checks recovery patterns: typescript-import-error → default-with-type (95%)
- **Triple reinforcement:** file + recovery + implicit = very high confidence

---

## Examples

### Example 1: File-Specific Header Styles

**Setup:**
```
CLAUDE.md: Always use sentence-case headers
README.md: Always use title-case headers
```

**Learning:**

```
Session 1: Edit CLAUDE.md
You: "Use sentence case for all headers"
AI: Applies sentence-case
You: "Perfect!" (strong positive)

System records:
- Global: sentence-case (85%)
- CLAUDE.md: sentence-case (100%)

Session 2: Edit README.md
You: "Use title case for all headers"
AI: Applies title-case
You: "Exactly!" (strong positive)

System records:
- Global: title-case (75%) ← Recent, but conflicts with CLAUDE.md
- README.md: title-case (100%)
```

**Result:**

```
Editing CLAUDE.md:
→ Loads: CLAUDE.md context (sentence-case, 100%)
→ Ignores: Global preference (title-case, 75%)
→ Uses: sentence-case ✓

Editing README.md:
→ Loads: README.md context (title-case, 100%)
→ Ignores: Global preference
→ Uses: title-case ✓

Editing new-doc.md:
→ No file context found
→ Falls back to: Global (title-case, 75%)
→ Uses: title-case ⚠️ (might be wrong)
```

**Solution:** User can set `*.md` pattern for default.

---

### Example 2: Recovery from Build Errors

**Problem:** New React component won't build

**Attempt 1:** (2:00 PM)
```
AI suggests: Class component with lifecycle methods
Build error: "React.Component is not a constructor"
User: "That didn't work"

System records:
- Task: react-component-error
- Failed: class-component-lifecycle
```

**Attempt 2:** (2:10 PM)
```
AI suggests: Functional component with useState
Build error: "useState is not defined"
User edits: Adds React import
Still fails

System records:
- Failed: functional-component-useState-no-import
```

**Attempt 3:** (2:20 PM)
```
AI suggests: Functional component with proper React import
Build succeeds!
Tests pass!
User: "Awesome, that fixed it!" (enthusiasm + success)

System records:
- Success: functional-component-with-react-import
- Recovery pattern created
- Confidence: 95%
- Time: 20 minutes, 3 attempts
```

**Next time (next day):**

```
Similar error occurs in different component

AI: "🎯 Recovery Pattern Detected

I remember you solved this React component error before.

What didn't work:
1. ❌ class-component-lifecycle
2. ❌ functional-component-useState-no-import

What worked:
✅ functional-component-with-react-import (20 min, 3 attempts)

Apply proven solution?"

User: "Yes" (accepts)
AI: Applies solution
Build succeeds immediately!

Time saved: 20 minutes
```

---

### Example 3: Directory-Level Tone Preferences

**Setup:**
```
/docs/: Formal, educational tone
/examples/: Casual, practical tone
```

**Learning:**

```
Editing docs/fundamentals/setup.md:

User writes formal documentation
System learns over 10 files:
- docs/**/*.md → formal tone (90% acceptance)

Editing examples/quick-demo.js:

User writes casual comments
System learns over 5 files:
- examples/**/*.js → casual tone (95% acceptance)
```

**Result:**

```
New file: docs/advanced/configuration.md
→ Loads: docs/**/*.md → formal tone (90%)
→ Suggests: Formal, educational language ✓

New file: examples/hello-world.ts
→ Loads: examples/**/*.ts → casual tone (95%)
→ Suggests: Casual, practical language ✓
```

---

## Commands

### File-Context Commands

```
"Show file-context preferences for CLAUDE.md"
"What have you learned about this file?"
"Show all file-context preferences"
"Reset file-context for *.md"
"Delete file-context for CLAUDE.md"
"Disable file-context memory"
"Enable file-context memory"
"Show file-context inheritance for this file"
```

### Recovery Pattern Commands

```
"Show recovery patterns"
"What solutions have I found through trial-and-error?"
"How did I solve [task] last time?"
"Show recovery pattern for typescript-import-error"
"Forget recovery pattern for [task]"
"List all recovery patterns"
"Export recovery patterns"
```

### Combined Commands

```
"Show all context for this file"
  → File preferences + recovery patterns + implicit signals

"What do you remember about debugging React errors?"
  → File context + recovery patterns for React

"Reset all learnings for TypeScript files"
  → Clears file context + recovery patterns for *.ts
```

---

## Privacy & Data

### What's Stored

**File-Context Memory:**

| Data | Stored | Purpose |
|------|--------|---------|
| **File path/pattern** | Yes | Match context |
| **Preference type** | Yes | What to apply |
| **Acceptance rate** | Yes | Confidence |
| **Last used timestamp** | Yes | Freshness |
| **File content** | **No** | Never stored |

**Recovery Patterns:**

| Data | Stored | Purpose |
|------|--------|---------|
| **Task description** | Yes | Identify similar tasks |
| **Approach descriptions** | Yes | What was tried |
| **Timestamps** | Yes | When solved |
| **Success/failure** | Yes | What worked |
| **Actual code** | **No** | Never stored |

### Privacy Features

- **Patterns only:** System stores "typescript-import-error", not actual code
- **No content:** File paths stored, file content never touched
- **Local only:** All data in `~/.claude/user-preferences.json` (never synced)
- **User control:** Delete anytime, disable features individually

### Data Retention

- **File-context:** Kept until explicitly deleted or reset
- **Recovery patterns:** Kept until forgotten or success rate drops below 50%
- **Auto-cleanup:** Patterns unused for 90 days are archived

---

## Troubleshooting

### File-Context Not Loading

**Symptoms:** System doesn't remember file-specific preferences

**Check:**
```
"Show file-context preferences for [file]"
"Is file-context memory enabled?"
```

**Common causes:**

1. **File path mismatch:**
   - Stored: `/full/path/to/CLAUDE.md`
   - Current: `./CLAUDE.md`
   - **Fix:** Use consistent paths or glob patterns (`CLAUDE.md` instead of full path)

2. **Pattern not matching:**
   - Stored: `docs/**/*.md`
   - Current file: `documentation/guide.md`
   - **Fix:** Update pattern or create new pattern for `documentation/`

3. **Disabled:**
   - **Fix:** `"Enable file-context memory"`

---

### Recovery Patterns Not Detected

**Symptoms:** System doesn't recognize when you're solving a repeated problem

**Check:**
```
"Show recovery pattern detection status"
"What failures have been recorded recently?"
```

**Common causes:**

1. **Attempts too far apart:**
   - Detection window: 30 minutes
   - **Fix:** Complete attempts within same session

2. **Success not detected:**
   - No explicit feedback ("that worked!")
   - **Fix:** Give verbal feedback or wait 5 minutes for silent success

3. **Not enough attempts:**
   - Minimum: 2 failures + 1 success
   - **Fix:** Natural threshold, keep trying approaches

---

### Wrong Context Applied

**Symptoms:** System uses preferences from wrong file

**Check:**
```
"Show file-context inheritance for this file"
"Why are you suggesting [preference]?"
```

**Example:**

```
User: "Why are you suggesting title-case?"
AI: "Loading context from:
     1. README.md → title-case (100%, exact match)

     You're editing README.md, which has 100% title-case preference."

User: "Oh, I thought I was in CLAUDE.md"
```

**Fix:** Verify which file you're editing

---

## Summary

**v4.24.0 adds context-aware learning:**

1. **File-Context Memory:**
   - Tag preferences with file paths/patterns
   - 4 context levels: exact → glob → type → directory
   - Inheritance from general to specific
   - Conflict resolution: specific wins

2. **Recovery Pattern Learning:**
   - Track fail → fail → success sequences
   - Remember winning solutions
   - 95% confidence (proven through struggle)
   - Proactive suggestions next time

**Combined with v4.23.0:**
- Implicit signals now tagged with file context
- Correction signals trigger recovery patterns
- Triple reinforcement: file + recovery + implicit

**Impact:**
- Solve problems faster (skip failed approaches)
- Context-appropriate suggestions
- Learn from struggle, not just success

**Next: v4.25.0**
- Workflow gap detection
- Adaptive threshold tuning

---

**For more details:**
- [Implicit Learning Signals](07_implicit-learning-signals.md) (v4.23.0)
- [Personalization Guide](06_personalization-guide.md) (Core concepts)
- [Personalization Engine Skill](../../.claude/skills/personalization-engine/SKILL.md) (Technical)
