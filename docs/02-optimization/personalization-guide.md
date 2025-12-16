# Personalization Guide

**Version:** 4.0.0
**Last Updated:** 2025-12-16

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
13. [AI-Suggested Tuning](#ai-suggested-tuning-v3100) (v3.10.0)
14. [Cross-Project Intelligence](#cross-project-intelligence-v3120) (v3.12.0)
15. [Import/Export Preferences](#importexport-preferences-v3130) (v3.13.0)
16. [Preference Templates](#preference-templates-v3140) (v3.14.0)
17. [Remote Template Sources](#remote-template-sources-v400) (v4.0.0)

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

## AI-Suggested Tuning (v3.10.0)

### How It Works

The personalization engine analyzes your decision patterns and suggests preference optimizations:

1. **Threshold Tuning** - If you reject many suggestions at a confidence level, suggests raising the threshold
2. **Proactivity Adjustment** - If acceptance varies by category, suggests category-specific settings
3. **Skill Optimization** - Identifies skills that might need different settings or disabling

### Triggering Analysis

**Manual:**
```
"Suggest preference improvements"
"Analyze my preferences"
"Optimize my settings"
"Tune my preferences"
```

**Automatic:** Every 7 days (configurable via `analysisIntervalDays`)

### Understanding Suggestions

Each suggestion includes:
- **Confidence Level:** High (50+ samples), Medium (20-50), Low (<20)
- **Rationale:** Why this change is recommended
- **Data Points:** The numbers behind the suggestion
- **Actions:** Apply, Dismiss, or Snooze

### Example Suggestion

```
Suggestion 1: Raise Auto-Apply Threshold (High Confidence)

Current: autoApply = 95%
Suggested: autoApply = 97%

Why: You rejected 43% of auto-applied actions (86 of 200).
Raising the threshold will reduce unwanted automatic changes.

Data:
- Sample size: 200 decisions (high confidence)
- Rejection rate: 43% (threshold: 40%)
- Trend: Stable

Apply: "Set autoApply to 97"
Dismiss: "Dismiss suggestion 1"
Snooze: "Snooze suggestion 1 for 2 weeks"
```

### Applying Suggestions

**One-command application:**
- `Apply suggestion 1` - Apply specific suggestion
- `Set autoApply to 97` - Direct setting change
- `Apply all suggestions` - Apply all (use with caution)

**Dismissing:**
- `Dismiss suggestion 1` - Won't be shown again
- `Dismiss all` - Dismiss all current suggestions

**Snoozing:**
- `Snooze suggestion 1 for 2 weeks` - Remind later

### Configuration

Adjust tuning behavior in `~/.claude/user-preferences.json`:

```json
{
  "tuningSuggestions": {
    "analysisIntervalDays": 7,
    "minimumSampleSize": 20,
    "thresholds": {
      "triggerAnalysis": {
        "rejectionRateHigh": 0.4,
        "acceptanceRateHigh": 0.9
      }
    },
    "autoTuning": {
      "enabled": false,
      "requireConfirmation": true
    }
  }
}
```

| Setting | Default | Description |
|---------|---------|-------------|
| `analysisIntervalDays` | 7 | Days between auto-analyses |
| `minimumSampleSize` | 20 | Min decisions before suggestions |
| `rejectionRateHigh` | 0.4 | Suggest raising threshold if rejection > this |
| `acceptanceRateHigh` | 0.9 | Suggest lowering threshold if acceptance > this |
| `autoTuning.enabled` | false | Auto-apply high-confidence suggestions |

### The Feedback Loop

```
v3.8.0: SET preferences manually
       ↓
v3.9.0: OVERRIDE per project
       ↓
v3.10.0: OPTIMIZE based on patterns ← You are here
       ↓
     Self-improving preferences
```

AI-Suggested Tuning closes the feedback loop. Instead of preferences being static, they evolve based on your actual usage patterns. Over time, the system learns what works for you and suggests adjustments to improve the experience.

### Privacy

All analysis happens locally. Your decision history never leaves your machine. The tuning algorithm runs entirely on your data without any cloud processing.

---

## Cross-Project Intelligence (v3.12.0)

### How It Works

Cross-Project Intelligence analyzes patterns across all your registered projects:

1. **Pattern Aggregation** - Identifies preferences used consistently across projects
2. **Consistency Detection** - Finds divergences from your established patterns
3. **Cross-Project Suggestions** - Recommends propagating patterns to new projects

### The Learning Leverage Effect

```
Single-project learning:
  Project A: learns X
  Project B: learns X again (wasted effort)
  Project C: learns X again (wasted effort)

Cross-project learning:
  Project A: learns X
  Project B: "You prefer X in Project A. Apply here?" ✓
  Project C: "You prefer X in 2 projects. Apply here?" ✓

Result: Nx leverage on learning investment (where N = projects)
```

### Triggering Analysis

**Manual:**
```
"Analyze patterns across my projects"
"Show cross-project insights"
"Are my projects configured consistently?"
"What patterns do I use consistently?"
```

**Automatic:** Every 7 days (configurable via `aggregationIntervalDays`)

### Pattern Types

| Type | Description | Example |
|------|-------------|---------|
| **Propagate** | Apply established pattern to new projects | "Enable strict mode in 2 remaining projects" |
| **Standardize** | Align divergent projects to a standard | "3 projects use different commit styles" |
| **Detect-Outlier** | Flag projects below your standard | "Project Y has lower test coverage" |

### Example Cross-Project Suggestion

```
Suggestion: Propagate Conventional Commits (High Confidence)

Pattern: conventional commits
Adoption: 90% (9/10 projects)
Missing: legacy-app

Rationale: You use conventional commits in 9 projects.
legacy-app would benefit from the same standard.

Apply: "Propagate conventional commits to legacy-app"
```

### Applying Suggestions

**Propagate to specific projects:**
- `Propagate strict mode to scripts and tools`
- `Apply suggestion 1`

**Propagate to all projects:**
- `Propagate conventional commits to all projects`

**Exclude projects from analysis:**
- `Ignore prototype for cross-project analysis`

### Configuration

```json
{
  "crossProjectLearning": {
    "enabled": true,
    "aggregationIntervalDays": 7,
    "thresholds": {
      "minProjectsForPattern": 3,
      "propagateConfidence": 0.8,
      "minProjectsForAnalysis": 3
    }
  }
}
```

| Setting | Default | Description |
|---------|---------|-------------|
| `enabled` | true | Enable/disable cross-project analysis |
| `aggregationIntervalDays` | 7 | Days between auto-analyses |
| `minProjectsForPattern` | 3 | Min projects to establish a pattern |
| `propagateConfidence` | 0.8 | Min adoption rate to suggest propagation |
| `minProjectsForAnalysis` | 3 | Min projects before enabling |

### Requirements

Cross-project analysis requires:
- **Projects Registry:** At least 3 projects registered (`~/.claude/projects-registry.json`)
- **Learning History:** Some decision history in user preferences

**Check your registry:** "Show my projects"

### Privacy

All cross-project analysis happens locally. The system reads:
- Your projects registry (names, paths, tags)
- User preferences (global learnings)
- Project preferences (per-project overrides)

No data leaves your machine.

---

## Import/Export Preferences (v3.13.0)

### Overview

Export your carefully tuned preferences for backup, sharing, or transfer to new machines. Import preferences with validation, preview, and merge strategies.

### Export Commands

| Command | Result |
|---------|--------|
| `Export my preferences` | Full export to default path |
| `Export preferences to [path]` | Export to specific location |
| `Export preferences as template` | Clean template (no history) |
| `Export anonymized preferences` | Share without personal data |
| `Create preferences backup` | Full backup with timestamp |

### Export Types

| Type | Contents | Use Case |
|------|----------|----------|
| **full** | All settings + analytics | Personal backup |
| **partial** | Selected sections only | Share specific settings |
| **anonymized** | Settings without history/timestamps | Team sharing |
| **template** | Core settings only (no learned data) | Reusable starter config |

### Import Commands

| Command | Result |
|---------|--------|
| `Import preferences from [file]` | Import with preview |
| `Restore from backup` | Restore last backup |
| `Compare preferences with [file]` | Show diff without importing |

### Merge Strategies

| Strategy | Behavior |
|----------|----------|
| **overwrite** | Replace all matching sections entirely |
| **merge** | Deep merge (import values win on conflict) |
| **selective** | Choose what to import per section |

### Safety Features

- **Automatic backup** before every import
- **Version validation** prevents incompatible imports
- **Preview mode** shows changes before applying
- **Daily limit** prevents accidental repeated imports (default: 5)
- **Rollback** command restores previous state

### Example Workflows

**Backup before system change:**
```
"Export my preferences"
→ Saved to ~/claude-preferences-export.json

# After OS reinstall
"Import preferences from ~/claude-preferences-export.json"
→ All settings restored
```

**Share with teammate:**
```
"Export preferences as template"
→ Creates clean template without personal data

# Teammate imports:
"Import preferences from ~/team-template.json"
→ Gets your settings as a starting point
```

**Machine migration:**
```
# On old machine:
"Export my preferences"

# Copy file to new machine, then:
"Import preferences from ~/claude-preferences-export.json"
→ Preview shows what will change
→ Confirm to apply
```

### Configuration

```json
{
  "importExport": {
    "safetySettings": {
      "createBackupBeforeImport": true,
      "validateSchemaVersion": true,
      "requireConfirmation": true,
      "maxImportsPerDay": 5
    },
    "defaults": {
      "exportPath": "~/claude-preferences-export.json",
      "defaultExportType": "full",
      "includeAnalytics": true,
      "includeLearningHistory": false
    }
  }
}
```

### Export File Format

Exports use a versioned JSON format with compatibility checking:

```json
{
  "$schema": "claude-preferences-export-v1",
  "exportVersion": "1.0.0",
  "sourceVersion": "3.13.0",
  "compatibility": {
    "minVersion": "3.8.0",
    "maxVersion": "3.13.0"
  },
  "contents": { ... },
  "metadata": {
    "checksum": "sha256:..."
  }
}
```

---

## Preference Templates (v3.14.0)

### Overview

Preference templates are pre-built configurations for common use cases. Instead of starting from scratch, apply a template that matches your workflow.

### Available Templates

| Template | Best For | Key Characteristics |
|----------|----------|---------------------|
| **balanced** | Most developers | Sensible defaults, balanced automation |
| **security-first** | Security-conscious | Conservative, thorough scanning |
| **speed-focused** | Experienced devs | Maximum automation, fewer prompts |
| **learning-mode** | Beginners | Maximum guidance, lots of suggestions |
| **minimal** | Experts | Minimal interruptions |

### Using Templates

**List templates:**
```
"Show available templates"
"What templates are available?"
```

**Apply a template:**
```
"Apply balanced template"
"Apply security-first template"
```

**Get help choosing:**
```
"Help me choose a template"
"Compare balanced and speed-focused"
```

### How Templates Work

Templates use the same format as exports (v3.13.0). When you apply a template:

1. **Preview** - See what will change
2. **Backup** - Current preferences backed up
3. **Merge** - Template values applied (your learned preferences preserved)
4. **Track** - Template recorded in history

### Template Comparison

Each template has different threshold settings:

| Setting | balanced | security-first | speed-focused | learning-mode | minimal |
|---------|----------|----------------|---------------|---------------|---------|
| autoApply | 95 | 99 | 90 | 98 | 98 |
| suggestProminently | 75 | 85 | 65 | 60 | 90 |
| showAsOptional | 50 | 60 | 40 | 35 | 75 |
| hideBelow | 30 | 40 | 25 | 15 | 50 |
| proactivity | medium | medium | high | high | low |

### Creating Custom Templates

Export your preferences as a template to share with teammates:

```
"Export preferences as template"
```

Others can then import your template:

```
"Import preferences from ~/team-template.json"
```

---

## Remote Template Sources (v4.0.0)

### Overview

Share templates across teams using git repositories or URLs. No authentication required - templates are just JSON files.

**Key Concept:** Git-native template sharing
- Templates are portable JSON files
- Share via git repos or raw URLs
- Teams curate template catalogs
- No server infrastructure needed

### Adding a Template Source

Add a team or community template catalog:

```
"Add template source https://raw.githubusercontent.com/your-team/templates/main/catalog.json"
```

### Browsing Available Templates

View all templates from configured sources:

```
"Browse template catalog"
"List remote templates"
"What templates are available?"
```

### Importing Remote Templates

Fetch and apply a template from a remote source:

```
"Import team-standard template"
"Fetch security-template from team-source"
```

### Managing Sources

```
"List template sources"
"Remove template source [name]"
"Refresh template sources"
```

### Creating a Team Template Catalog

**Step 1:** Create a git repository with your templates

**Step 2:** Add a `catalog.json`:
```json
{
  "$schema": "claude-template-catalog-v1",
  "name": "Your Team Templates",
  "templates": [
    {
      "id": "team-standard",
      "name": "Team Standard",
      "sourceUrl": "./team-standard.json",
      "version": "1.0.0"
    }
  ]
}
```

**Step 3:** Share the raw URL with your team

See `examples/team-templates/` for a complete example.

### Security

| Feature | Description |
|---------|-------------|
| **HTTPS Only** | Only HTTPS sources allowed by default |
| **Checksum Verification** | SHA256 hash validation |
| **Preview Before Import** | See changes before applying |
| **Full Audit Trail** | Track all source additions and imports |

### Template Catalog Comparison

| Source Type | Best For |
|-------------|----------|
| Built-in templates | Quick start, common patterns |
| Team catalog | Organization standards |
| Community catalog | Discovering new configurations |

---

## Quick Reference

### Commands Cheat Sheet

| Command | Description |
|---------|-------------|
| `Show my preferences` | Full preference summary |
| `Show my thresholds` | Confidence thresholds |
| `Show my skill usage` | Usage analytics |
| `Set proactivity to [low/medium/high]` | Adjust proactivity |
| `Export my preferences` | Export for backup/sharing |
| `Import preferences from [file]` | Import with preview |
| `Restore from backup` | Rollback to previous state |
| `Show available templates` | List preference templates |
| `Apply [template] template` | Apply a pre-built template |
| `Compare templates` | Compare template settings |
| `Set [threshold] to [value]` | Adjust threshold |
| `Don't show [item] again` | Permanent hide |
| `Reset [item] preference` | Clear specific learning |
| `Reset all preferences` | Full reset |
| `Show project preferences` | Project overrides |
| `Set project [setting] to [value]` | Create/update project override |
| `Show effective preferences` | Merged view |
| `Delete project preferences` | Remove all project overrides |
| `Suggest preference improvements` | Get AI-suggested tuning |
| `Apply suggestion [n]` | Apply a tuning suggestion |
| `Dismiss suggestion [n]` | Dismiss a suggestion |
| `Snooze suggestion [n] for [time]` | Remind later |
| `Show suggestion history` | View applied/dismissed suggestions |
| `Analyze patterns across my projects` | Cross-project analysis |
| `Show cross-project insights` | View established patterns |
| `Propagate [setting] to [projects]` | Apply pattern across projects |
| `Show consistency report` | View divergences |
| `Add template source [URL]` | Add remote template catalog |
| `Browse template catalog` | View all remote templates |
| `List template sources` | Show configured sources |
| `Remove template source [name]` | Remove a source |
| `Refresh template sources` | Check for updates |

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
7. **AI-Suggested Tuning** - System suggests preference improvements based on patterns (v3.10.0)
8. **Cross-Project Intelligence** - Learn once, apply everywhere - Nx leverage (v3.12.0)
9. **Import/Export** - Portable preferences for backup, sharing, and machine migration (v3.13.0)

**Five levels of customization:**
- **Global** (`~/.claude/user-preferences.json`) - Your personal defaults
- **Project** (`.claude/project-preferences.json`) - Per-project overrides, shareable with team
- **AI-Tuned** - Intelligent suggestions that evolve based on your actual usage
- **Cross-Project** - Patterns propagated across all your projects automatically
- **Portable** - Export/import for backup, sharing, and migration

**The personalization journey:**
```
SET → OVERRIDE → OPTIMIZE → LEVERAGE → SHARE
(Manual) (Per-project) (AI-suggested) (Cross-project) (Export/Import)
```

**Start simple:** Use skills normally, accept/reject suggestions, and the system will adapt to you over time. After 20+ decisions, AI-Suggested Tuning will begin offering optimization recommendations. With 3+ registered projects, Cross-Project Intelligence enables learning leverage across your entire portfolio. Export your preferences anytime for backup or to share with teammates.
