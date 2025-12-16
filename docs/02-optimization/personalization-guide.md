# Personalization Guide

**Version:** 3.9.0
**Last Updated:** 2025-12-15

This guide explains how the Personalization Engine works, how to customize your preferences, and how to get the most from Claude Code's learning capabilities.

---

## Table of Contents

1. [Overview](#overview)
2. [How It Works](#how-it-works)
3. [User Preferences File](#user-preferences-file)
4. [Confidence Thresholds](#confidence-thresholds)
5. [Proactivity Levels](#proactivity-levels)
6. [Learning from Feedback](#learning-from-feedback)
7. [Skill Integration](#skill-integration)
8. [Privacy & Data](#privacy--data)
9. [Common Operations](#common-operations)
10. [Troubleshooting](#troubleshooting)
11. [Best Practices](#best-practices)
12. [Project-Level Preferences](#project-level-preferences-v390) (v3.9.0)

---

## Overview

### The "Tell Me Once" Paradigm

The Personalization Engine enables a fundamental shift in how Claude Code works:

**Before (v3.7.0 and earlier):**
```
Session 1: User skips a suggestion
Session 2: Same suggestion appears again
Session 3: User skips again, frustrated
...repeat forever
```

**After (v3.8.0+):**
```
Session 1: User skips a suggestion
          → System records the skip
Session 2: System checks preferences
          → Suggestion filtered out
Session 3+: User never sees it again
          (unless they ask to reset)
```

### Key Benefits

| Benefit | Description |
|---------|-------------|
| **Persistence** | Decisions remembered across sessions |
| **Learning** | Skills adapt based on your feedback |
| **Personalization** | Suggestions match your coding style |
| **Transparency** | See what the system has learned |
| **Control** | Adjust thresholds and reset anytime |

### Components

1. **User Preferences File** - `~/.claude/user-preferences.json`
2. **Personalization Engine Skill** - Central hub for preference management
3. **Integration Protocol** - How skills read/write preferences
4. **Analytics** - Usage patterns and recommendations

---

## How It Works

### The Learning Loop

```
┌─────────────────────────────────────────────────────────┐
│                    LEARNING LOOP                        │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. SKILL ACTIVATES                                     │
│     │                                                   │
│     ▼                                                   │
│  2. READ PREFERENCES                                    │
│     ├── Load confidence thresholds                      │
│     ├── Load learned preferences                        │
│     └── Filter "don't show again" items                 │
│     │                                                   │
│     ▼                                                   │
│  3. GENERATE SUGGESTIONS                                │
│     ├── Apply confidence scoring                        │
│     └── Filter based on thresholds                      │
│     │                                                   │
│     ▼                                                   │
│  4. USER DECISION                                       │
│     ├── Accept → Increase acceptance rate               │
│     ├── Reject → Decrease acceptance rate               │
│     ├── Skip → Weak negative signal                     │
│     └── Don't show again → Permanent filter             │
│     │                                                   │
│     ▼                                                   │
│  5. WRITE FEEDBACK                                      │
│     ├── Update preferences file                         │
│     ├── Update analytics                                │
│     └── Create backup                                   │
│     │                                                   │
│     └────────────────────────────────────────────────── │
│           (Next skill activation uses updated prefs)    │
└─────────────────────────────────────────────────────────┘
```

### Acceptance Rate Calculation

When you accept, reject, or skip a suggestion, the system updates the acceptance rate:

```
New Rate = (Old Rate × Sample Size + New Value) / (Sample Size + 1)

Values:
- Accept = 1.0
- Reject = 0.0
- Skip = 0.3 (weak negative)
```

**Example:**
- Current rate: 60% (0.60), 10 samples
- You reject a suggestion
- New rate: (0.60 × 10 + 0.0) / 11 = 54.5%

Over time, this causes suggestions you don't like to fade away.

---

## User Preferences File

### Location

```
~/.claude/user-preferences.json
```

This file is:
- **Global** - Applies to all projects
- **Local** - Never synced to cloud
- **Auto-created** - Created on first use
- **Backed up** - Backup created before changes

### Structure Overview

```json
{
  "version": "3.8.0",
  "profile": {
    "experienceLevel": "intermediate",
    "primaryLanguages": ["typescript", "python"],
    "proactivityLevel": "medium"
  },
  "confidenceThresholds": {
    "autoApply": 95,
    "suggestProminently": 75,
    "showAsOptional": 50,
    "hideBelow": 30
  },
  "skillUsageFrequency": { ... },
  "learnedPreferences": { ... },
  "skippedRecommendations": { ... },
  "dontShowAgain": { ... },
  "learningHistory": { ... },
  "analytics": { ... }
}
```

### Key Sections

| Section | Purpose |
|---------|---------|
| `profile` | Your experience level, languages, proactivity |
| `confidenceThresholds` | When to show/hide suggestions |
| `skillUsageFrequency` | Which skills you use most |
| `learnedPreferences` | Accept/reject patterns by category |
| `skippedRecommendations` | Items you've skipped |
| `dontShowAgain` | Permanently dismissed items |
| `learningHistory` | Recent decisions (for analysis) |
| `analytics` | Aggregated usage statistics |

### Template

A template is available at:
```
templates/user-preferences.json.template
```

This includes comments explaining each field. Useful for understanding the schema.

---

## Confidence Thresholds

### The Four Levels

```
100% ─────────────────────────────────────
      │ AUTO-APPLY ZONE                  │
      │ (Dangerous - actions happen      │
      │  without asking)                 │
 95%  ├─────────────────────────────────────  autoApply
      │ PROMINENT SUGGESTION ZONE        │
      │ (Shown first, recommended)       │
 75%  ├─────────────────────────────────────  suggestProminently
      │ OPTIONAL SUGGESTION ZONE         │
      │ (Shown as "consider this")       │
 50%  ├─────────────────────────────────────  showAsOptional
      │ LOW CONFIDENCE ZONE              │
      │ (May or may not be useful)       │
 30%  ├─────────────────────────────────────  hideBelow
      │ HIDDEN ZONE                      │
      │ (Too uncertain to show)          │
  0% ─────────────────────────────────────
```

### Default Values

| Threshold | Default | Purpose |
|-----------|---------|---------|
| autoApply | 95% | Actions applied without asking |
| suggestProminently | 75% | Shown with strong recommendation |
| showAsOptional | 50% | Shown as optional consideration |
| hideBelow | 30% | Hidden (too low confidence) |

### Adjusting Thresholds

**More conservative (fewer surprises):**
```
"Set autoApply threshold to 98%"
"Set hideBelow threshold to 40%"
```

**More permissive (see more suggestions):**
```
"Set autoApply threshold to 90%"
"Set hideBelow threshold to 20%"
```

### When Suggestions Appear

A suggestion with X% confidence will:

| Confidence | With Default Thresholds |
|------------|------------------------|
| 98% | Auto-applied (if autoApply enabled) |
| 85% | Shown prominently |
| 60% | Shown as optional |
| 40% | Shown if proactivity=high |
| 20% | Hidden |

---

## Proactivity Levels

### Three Levels

| Level | Description | Best For |
|-------|-------------|----------|
| **Low** | Minimal interruption | Experienced users, focused work |
| **Medium** | Balanced approach | Most users |
| **High** | Maximum assistance | Learning, exploration |

### How Proactivity Affects Thresholds

| Threshold | Low | Medium | High |
|-----------|-----|--------|------|
| autoApply | 98% | 95% | 90% |
| suggestProminently | 85% | 75% | 60% |
| showAsOptional | 70% | 50% | 40% |
| hideBelow | 50% | 30% | 20% |

### Changing Proactivity

```
"Set my proactivity level to low"
"Set proactivity to high"
"I want fewer suggestions" → Suggests low
"I want more suggestions" → Suggests high
```

---

## Learning from Feedback

### What Gets Learned

| Category | Examples |
|----------|----------|
| **coding-style** | Early returns, verbose logging, null checks |
| **workflow** | Commit style, branch naming, changelog updates |
| **quality** | Security thresholds, test coverage targets |
| **documentation** | JSDoc, README style, changelog format |

### Feedback Types

| Action | Effect | Signal Strength |
|--------|--------|-----------------|
| **Accept** | Increases acceptance rate | Strong positive |
| **Reject** | Decreases acceptance rate | Strong negative |
| **Skip** | Slight decrease | Weak negative |
| **Don't show again** | Permanent filter | Permanent |

### Skip Counter

Skipping the same item multiple times has cumulative effect:

| Skip Count | Effect |
|------------|--------|
| 1 | Noted (slight decrease) |
| 2 | Lower priority |
| 3 | Marked permanent (won't show) |

### Viewing Learned Preferences

```
"Show my learned preferences"
"What have you learned about my coding style?"
"Show preference for early returns"
```

### Resetting Preferences

```
"Reset early-returns preference"     # Reset specific item
"Reset coding-style preferences"     # Reset category
"Reset all preferences"              # Full reset
```

---

## Skill Integration

### How Skills Use Preferences

**On Activation:**
1. Read `~/.claude/user-preferences.json`
2. Load confidence thresholds
3. Load learned preferences for relevant categories
4. Filter out "don't show again" items
5. Apply to suggestion generation

**On User Decision:**
1. Capture action (accept/reject/skip)
2. Calculate new acceptance rate
3. Update preferences file
4. Update analytics

### Skills with Personalization

| Skill | What It Learns |
|-------|----------------|
| standards-enforcer | Coding style preferences |
| security-scanner | Severity threshold preferences |
| test-generator | Coverage preferences, framework choices |
| commit-readiness-checker | Commit style, changelog preferences |
| global-setup-assistant | Skipped recommendations |

### Cross-Skill Learning

Preferences learned in one skill can benefit others:

**Example:**
- standards-enforcer learns you prefer null checks (92% acceptance)
- security-scanner sees this preference
- Security scanner prioritizes null-check-related findings

---

## Privacy & Data

### What's Stored

| Data | Stored | Purpose |
|------|--------|---------|
| Experience level | Yes | Adjust suggestion complexity |
| Primary languages | Yes | Language-specific suggestions |
| Skill usage counts | Yes | Recommend unused skills |
| Accept/reject patterns | Yes | Learn preferences |
| Timestamps | Yes | Trend analysis |
| Code content | **No** | Never stored |
| File paths | **No** | Never stored |
| PII | **No** | Never stored |

### Where It's Stored

```
~/.claude/user-preferences.json     # Main file
~/.claude/user-preferences.json.backup  # Auto-backup
```

### Data Never Leaves Your Machine

- **No cloud sync** - Preferences stay local
- **No telemetry** - No usage data sent anywhere
- **No analytics upload** - All analytics local
- **Full control** - Delete anytime

### Deleting Your Data

```bash
# Delete preferences
rm ~/.claude/user-preferences.json

# Delete backup too
rm ~/.claude/user-preferences.json.backup
```

---

## Common Operations

### Viewing Preferences

```
"Show my preferences"
"What are my confidence thresholds?"
"Show my skill usage analytics"
"What have you learned about me?"
```

### Adjusting Thresholds

```
"Set autoApply threshold to 98%"
"Set hideBelow to 40%"
"Make auto-apply more conservative"
```

### Changing Proactivity

```
"Set proactivity to low"
"I want fewer suggestions"
"Show me all suggestions" → Sets high
```

### Managing Items

```
"Don't show early returns suggestions"
"Reset early-returns preference"
"Show skipped recommendations"
"Reset all skipped items"
```

### Analytics

```
"Show my skill usage"
"Which skills should I try?"
"Analyze my workflow patterns"
```

---

## Troubleshooting

### Preferences Not Persisting

**Symptoms:** Decisions don't seem to stick

**Check:**
1. File exists: `ls ~/.claude/user-preferences.json`
2. Valid JSON: `cat ~/.claude/user-preferences.json | python -m json.tool`
3. Permissions: `ls -la ~/.claude/user-preferences.json`

**Fix:**
```bash
# If corrupted, restore from backup
cp ~/.claude/user-preferences.json.backup ~/.claude/user-preferences.json
```

### Seeing Unexpected Suggestions

**Symptoms:** Suggestions appearing that should be hidden

**Check:**
1. "Show my confidence thresholds"
2. "Show preference for [item]"
3. "Show my proactivity level"

**Fix:**
- Lower the threshold: "Set hideBelow to 50%"
- Or mark permanent: "Don't show [item] again"

### Not Seeing Expected Suggestions

**Symptoms:** Useful suggestions not appearing

**Check:**
1. Threshold too high: "Show my hideBelow threshold"
2. Item in "don't show again": "Show don't show again list"
3. Proactivity too low: "Show my proactivity level"

**Fix:**
- Lower threshold: "Set hideBelow to 20%"
- Remove from list: "Show [item] suggestions again"
- Raise proactivity: "Set proactivity to high"

### Corrupted Preferences File

**Symptoms:** JSON parse errors

**Fix:**
```bash
# Option 1: Restore from backup
cp ~/.claude/user-preferences.json.backup ~/.claude/user-preferences.json

# Option 2: Delete and start fresh
rm ~/.claude/user-preferences.json
# Next skill activation will create new file with defaults
```

---

## Best Practices

### 1. Start with Medium Proactivity

Don't jump to low or high immediately. Medium is balanced and helps you understand what suggestions are available.

### 2. Let the System Learn

Don't manually edit the preferences file. Let the system learn from your natural decisions. This produces better results over time.

### 3. Use "Don't Show Again" Sparingly

Reserve this for truly irrelevant items. For things you sometimes want, use skip instead - the system will naturally reduce their frequency.

### 4. Check Analytics Periodically

```
"Show my skill usage analytics"
```

This reveals patterns you might not notice and suggests optimizations.

### 5. Reset When Needed

If the system seems confused, reset specific preferences:
```
"Reset coding-style preferences"
```

This is non-destructive - you'll re-learn quickly.

### 6. Understand Thresholds Before Changing

Before adjusting thresholds, understand the current behavior:
```
"Why did you show me that suggestion?"
"Explain my threshold settings"
```

---

## Project-Level Preferences (v3.9.0)

### When to Use Project Preferences

Use project-level preferences when:
- **Security-critical project** needs stricter thresholds
- **Learning project** where you want more suggestions
- **Legacy project** with different coding standards
- **Team project** needs shared conventions

### How It Works

```
Global Preferences (~/.claude/user-preferences.json)
        ↓
        + (merge)
        ↓
Project Preferences (.claude/project-preferences.json)
        ↓
        = Effective Preferences (what skills actually use)
```

**Merge rules:**
1. Project values override global values
2. Unspecified values inherit from global
3. Deep merge for nested objects
4. Arrays are replaced (not merged)

### Creating Project Preferences

```
"Create project preferences for this project"
"Set up project-level overrides"
```

This creates `.claude/project-preferences.json` with:
- Sparse format (only overrides, inherits rest)
- Reason fields for documentation
- Project context section

### Override Examples

**Security-Critical Project:**
```json
{
  "projectName": "banking-api",
  "description": "Security-critical financial API",
  "overrides": {
    "confidenceThresholds": {
      "autoApply": 98,
      "_reason": "Be very conservative with auto-changes"
    },
    "profile": {
      "proactivityLevel": "low",
      "_reason": "Minimize surprises in production code"
    },
    "skillSpecificPreferences": {
      "security-scanner": {
        "showInfoLevel": true,
        "_reason": "Show all security findings"
      }
    }
  },
  "projectContext": {
    "priorities": {
      "security": "critical",
      "performance": "high"
    }
  }
}
```

**Learning Project:**
```json
{
  "projectName": "learn-react",
  "description": "Personal learning project",
  "overrides": {
    "profile": {
      "proactivityLevel": "high",
      "_reason": "Want maximum suggestions while learning"
    },
    "confidenceThresholds": {
      "hideBelow": 20,
      "_reason": "Show more suggestions, even uncertain ones"
    }
  }
}
```

### Viewing Project Settings

```
"Show project preferences"        # See project overrides
"Show effective preferences"      # See merged view (what's actually used)
"Why is this project different?"  # Explain differences from global
```

### Modifying Project Preferences

```
"Set project proactivity to high"
"Set project autoApply threshold to 98%"
"Enable strict security for this project"
"Remove project override for proactivity"
```

### Team Sharing

**Key difference from global preferences:**

| Aspect | Global | Project |
|--------|--------|---------|
| Location | `~/.claude/` | `.claude/` in project |
| Git | Not committed | **Can be committed** |
| Scope | All your projects | This project only |
| Sharing | Personal only | **Team shares** |

**Recommendation:** Commit `.claude/project-preferences.json` to git so your team uses the same AI behavior.

### Project Context

The `projectContext` section helps skills make better suggestions:

```json
{
  "projectContext": {
    "techStack": {
      "languages": ["typescript"],
      "frameworks": ["react", "express"],
      "testing": ["jest"]
    },
    "priorities": {
      "security": "high",
      "performance": "medium",
      "documentation": "low"
    }
  }
}
```

**How skills use this:**
- **test-generator:** Uses `testing` to choose framework
- **security-scanner:** Uses `security` priority for thoroughness
- **standards-enforcer:** Uses `techStack` for language rules

---

## Quick Reference

### Commands Cheat Sheet

| Command | Description |
|---------|-------------|
| `Show my preferences` | Full preference summary |
| `Show my thresholds` | Confidence thresholds |
| `Show my skill usage` | Usage analytics |
| `Set proactivity to [low/medium/high]` | Adjust proactivity |
| `Set [threshold] to [value]` | Adjust threshold |
| `Don't show [item] again` | Permanent hide |
| `Reset [item] preference` | Clear specific learning |
| `Reset all preferences` | Full reset |
| `Show project preferences` | Project overrides |
| `Set project [setting] to [value]` | Create/update project override |
| `Show effective preferences` | Merged view |
| `Delete project preferences` | Remove all project overrides |

### Proactivity Quick Guide

| Want | Set |
|------|-----|
| Fewer interruptions | Proactivity: Low |
| Balanced experience | Proactivity: Medium |
| Maximum help | Proactivity: High |

### Threshold Quick Guide

| Want | Adjust |
|------|--------|
| Fewer auto-actions | autoApply: 98%+ |
| See more suggestions | hideBelow: 20% |
| See fewer suggestions | hideBelow: 50% |
| More prominent suggestions | suggestProminently: 60% |

---

## Summary

The Personalization Engine transforms Claude Code from a generic tool into a personal assistant that learns and adapts:

1. **Persistence** - Tell me once, I remember forever
2. **Learning** - Suggestions improve based on your feedback
3. **Control** - Adjust thresholds and proactivity anytime
4. **Privacy** - All data local, never synced
5. **Transparency** - See what I've learned, reset anytime
6. **Project flexibility** - Override global settings per project (v3.9.0)

**Two levels of customization:**
- **Global** (`~/.claude/user-preferences.json`) - Your personal defaults
- **Project** (`.claude/project-preferences.json`) - Per-project overrides, shareable with team

**Start simple:** Use skills normally, accept/reject suggestions, and the system will adapt to you over time.
