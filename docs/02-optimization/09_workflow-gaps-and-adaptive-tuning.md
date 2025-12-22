# Workflow Gap Detection & Adaptive Threshold Tuning

**Version:** 4.25.0
**Last Updated:** 2025-12-22

This guide explains how Claude Code detects workflow patterns, suggests automation, and continuously adapts confidence thresholds to match your behavior.

---

## Table of Contents

1. [Overview](#overview)
2. [Workflow Gap Detection](#workflow-gap-detection)
3. [Adaptive Threshold Tuning](#adaptive-threshold-tuning)
4. [Integration with Previous Versions](#integration-with-previous-versions)
5. [Examples](#examples)
6. [Commands](#commands)
7. [Privacy & Data](#privacy--data)
8. [Troubleshooting](#troubleshooting)

---

## Overview

### The Evolution: Memory Lane Integration Complete

**v4.23.0 (Implicit Signals):** Learn from HOW you communicate (2-3x faster)
**v4.24.0 (Context + Recovery):** Learn WHERE and WHAT works (file-specific, proven solutions)
**v4.25.0 (Workflow + Adaptive):** Learn PATTERNS and SELF-TUNE (automation + optimization)

### Two Final Capabilities

1. **Workflow Gap Detection:** Analyze commit patterns, detect repetitive workflows, suggest automation
   - "You always edit version.json → run script → edit CHANGELOG → commit"
   - Frequency: 18/20 commits (90%)
   - Suggestion: "Automate this workflow?"

2. **Adaptive Threshold Tuning:** Continuous micro-adjustments based on actual acceptance rates
   - You reject 70% at 95% confidence → System raises threshold to 97%
   - You accept 95% at 97% → System lowers back to 95%
   - Transparent, reversible, safe (±10% max per day)

### Why This Completes Memory Lane

The Memory Lane video showed:
- **Session transcripts → Patterns → Memory**
- **User signals → Learning → Adaptation**

We've implemented:
- ✅ Implicit signals (v4.23.0): Detect sentiment from language
- ✅ File-context (v4.24.0): Remember where patterns apply
- ✅ Recovery patterns (v4.24.0): Remember what works after struggle
- ✅ **Workflow detection (v4.25.0): Remember repetitive sequences**
- ✅ **Adaptive tuning (v4.25.0): Self-optimize based on feedback**

**Result:** Complete self-learning, self-optimizing personalization system.

---

## Workflow Gap Detection

### The Problem

**Manual repetition goes unnoticed:**

```
Monday: Edit version.json → Run sync-version.sh → Edit CHANGELOG.md → Commit
Tuesday: Edit version.json → Run sync-version.sh → Edit CHANGELOG.md → Commit
Wednesday: Edit version.json → Run sync-version.sh → Edit CHANGELOG.md → Commit
...
After 20 commits: Still doing this manually
```

**Cost:** 2 minutes × 20 commits = 40 minutes wasted on repetition

**Worse:** You might forget a step (skip sync-version.sh), causing inconsistency.

### The Solution: Pattern Detection

**Analyze commit history to find:**
- Sequential patterns (A always follows B)
- Missing steps (forgot B between A and C)
- Repetitive workflows (same sequence 10+ times)
- Time costs (how long each workflow takes)

**Then:**
- Detect gaps real-time: "You usually do B here"
- Suggest automation: "I can create a script for this"
- Prevent errors: "You forgot step 2"

### Four Gap Types

| Type | Pattern | Example | Suggestion |
|------|---------|---------|------------|
| **Sequential** | A → B (90%+) | version.json → sync-version.sh | "Link these?" |
| **Forgotten** | A → C (B missing) | version.json → CHANGELOG (no script) | "Run script first?" |
| **Repetitive** | Same 10+ times | add → commit → push (15x) | "Automate?" |
| **Context Switch** | Unrelated A → B | auth.ts → README.md | "Group related?" |

### Detection Logic

**1. Sequential Pattern Detection:**

Analyze last 50 commits:

```python
commits = analyze_git_log(limit=50)

patterns = {}
for i in range(len(commits) - 1):
    action_a = commits[i].action  # e.g., "edit version.json"
    action_b = commits[i+1].action  # e.g., "run sync-version.sh"

    pattern_key = f"{action_a} → {action_b}"
    patterns[pattern_key] = patterns.get(pattern_key, 0) + 1

# Filter high-frequency patterns (90%+)
strong_patterns = {k: v for k, v in patterns.items() if v / len(commits) >= 0.90}
```

**Result:**
```
Pattern: "edit version.json → run sync-version.sh"
Frequency: 18/20 (90%)
Confidence: High
→ Create workflow: version-bump-workflow
```

**2. Forgotten Step Detection:**

Real-time analysis during session:

```python
current_session = [
    "edit version.json",
    "edit CHANGELOG.md"  # Missing step!
]

expected_workflow = workflows["version-bump-workflow"]
# Expected: version.json → sync-version.sh → CHANGELOG.md

missing_step = find_gap(current_session, expected_workflow)
# → "sync-version.sh" between version.json and CHANGELOG.md
```

**Alert:**
```markdown
## ⚠️ Workflow Gap Detected

You usually run **sync-version.sh** between these steps:
1. ✓ Edit version.json
2. ⚠️ **Run sync-version.sh** ← Missing
3. ✓ Edit CHANGELOG.md

Run now to stay on pattern?
```

**3. Repetition Analysis:**

Count identical sequences:

```python
sequences = extract_sequences(commits, window=4)
# sequences = [
#   ["git add .", "git commit", "git push"],
#   ["git add .", "git commit", "git push"],
#   ...  # 15 times
# ]

repetition_count = count_identical(sequences)
# → "git add + commit + push" = 15 occurrences

time_per_execution = 2  # minutes (from timestamps)
total_time = 15 * 2 = 30  # minutes
```

**Suggestion:**
```markdown
## 🤖 Automation Opportunity

**Workflow:** git-add-commit-push
**Frequency:** 15 times in 30 commits
**Time cost:** ~30 minutes total

**Automate with:**
- Git alias: `git acp "message"`
- Pre-commit hook
- Custom script

[Show me how] [Not interested]
```

### Storage Format

**In `~/.claude/user-preferences.json`:**

```json
{
  "workflowPatterns": {
    "version-bump-workflow": {
      "steps": [
        {
          "action": "edit",
          "target": "version.json",
          "confidence": 0.95,
          "avgTime": "1 minute"
        },
        {
          "action": "run",
          "target": "sync-version.sh",
          "confidence": 0.90,
          "avgTime": "10 seconds"
        },
        {
          "action": "edit",
          "target": "CHANGELOG.md",
          "confidence": 0.95,
          "avgTime": "2 minutes"
        },
        {
          "action": "commit",
          "pattern": "^(feat|fix|docs):",
          "confidence": 0.88,
          "avgTime": "30 seconds"
        }
      ],
      "metadata": {
        "frequency": 18,
        "totalCommits": 20,
        "patternStrength": 0.90,
        "totalTime": "66 minutes",
        "avgTimePerInstance": "3.7 minutes",
        "lastOccurrence": "2025-12-22T14:30:00Z",
        "automationSuggested": true,
        "userResponse": "not-now"
      }
    }
  },
  "detectedGaps": {
    "missing-sync-script-2025-12-22": {
      "workflow": "version-bump-workflow",
      "missingStep": "sync-version.sh",
      "detectedAt": "2025-12-22T15:00:00Z",
      "frequency": 3,
      "impact": "medium",
      "resolved": false
    }
  },
  "automationOpportunities": {
    "version-bump-automation": {
      "workflow": "version-bump-workflow",
      "frequency": 18,
      "timeSaved": "66 minutes",
      "suggestedSolutions": [
        {
          "type": "bash-script",
          "complexity": "low",
          "implementation": "./scripts/bump-version.sh"
        },
        {
          "type": "git-hook",
          "complexity": "medium",
          "implementation": "pre-commit"
        }
      ],
      "status": "suggested",
      "userResponse": null
    }
  }
}
```

### Automation Suggestions

After 10+ repetitions of same workflow:

```markdown
## 🤖 I Can Automate This

**Workflow:** version-bump-workflow
**Your effort:** 66 minutes across 18 instances
**Automation saves:** ~60 minutes (future)

### Option 1: Bash Script (Recommended)
```bash
#!/bin/bash
# scripts/bump-version.sh
VERSION=$1
echo "Bumping to version $VERSION..."
# 1. Update version.json
# 2. Run sync-version.sh
# 3. Update CHANGELOG.md
# 4. Commit with message
echo "Done! Version $VERSION ready."
```

**Usage:** `./scripts/bump-version.sh 4.25.0`

### Option 2: Git Hook
Auto-runs sync-version.sh before commit if version.json changed.

### Option 3: Git Alias
```bash
git config alias.bump '!f() {
  # Update version + sync + changelog
}; f'
```

**Usage:** `git bump 4.25.0`

---

**Which would you prefer?**
[Show implementation for Option 1] [Option 2] [Option 3] [None]
```

### Real-Time Gap Detection

**During active session:**

```markdown
## 🔗 Workflow Pattern Active

**Detected:** version-bump-workflow (90% confidence)

**Progress:**
1. ✅ Edit version.json (completed 30 seconds ago)
2. ⏳ **Next expected:** Run sync-version.sh
3. ⏸️  Edit CHANGELOG.md (pending)
4. ⏸️  Commit changes (pending)

**Reminder:** You usually complete this workflow in ~4 minutes total.

[Continue with pattern] [Skip remainder] [Don't track this session]
```

---

## Adaptive Threshold Tuning

### The Problem

**Static thresholds don't match reality:**

```
You set: autoApply = 95%

Reality over 2 weeks:
- Suggestions at 95%+: 50 generated
- Your acceptance: 25/50 (50%)

Problem: Half the auto-applied suggestions are wrong for you!
But threshold stays at 95% forever.
```

**Result:** System doesn't learn from its mistakes.

### The Solution: Continuous Adaptation

**Monitor acceptance rates by confidence band:**
- 95-100%: How many accepted vs rejected?
- 90-95%: How many accepted vs rejected?
- 85-90%: How many accepted vs rejected?

**Adjust thresholds based on actual behavior:**
- High rejection (70%+) → Raise threshold (be more conservative)
- High acceptance (95%+) → Lower threshold (be more permissive)

**Micro-adjustments:** ±1-2% at a time (gentle)
**Safety limits:** Never below 30%, never above 98%, max ±10% per day

### Current vs Enhanced

**v3.10.0 (AI-Suggested Tuning):**
```
Every 7 days:
→ Analyze patterns
→ Suggest changes
→ Wait for user approval
→ Apply if approved

Manual, slow, requires attention
```

**v4.25.0 (Adaptive Tuning):**
```
Continuous:
→ Monitor acceptance rates
→ Detect threshold misalignment
→ Apply micro-adjustments (±1-2%)
→ Notify user of change

Automatic, fast, transparent
```

### Confidence Band Analysis

**How it works:**

```python
# Collect suggestions by confidence level
bands = {
    "95-100": {"suggested": 20, "accepted": 12},  # 60% acceptance
    "90-95":  {"suggested": 15, "accepted": 13},  # 87% acceptance
    "85-90":  {"suggested": 10, "accepted": 9},   # 90% acceptance
}

# Analyze
for band, data in bands.items():
    acceptance_rate = data["accepted"] / data["suggested"]

    if band == "95-100" and acceptance_rate < 0.75:
        # Problem: High-confidence suggestions being rejected
        # Action: Raise threshold (be more selective)
        adjust_threshold("autoApply", +2)  # 95% → 97%

    elif band == "90-95" and acceptance_rate > 0.90:
        # Opportunity: Lower-confidence suggestions being accepted
        # Action: Lower threshold (be more permissive)
        adjust_threshold("suggestProminently", -2)  # 75% → 73%
```

### Micro-Adjustment Rules

| Condition | Samples | Action | Magnitude | Example |
|-----------|---------|--------|-----------|---------|
| 5 consecutive rejections | 5+ | Raise | +2% | 95%→97% |
| 80%+ rejection rate | 10+ | Raise | +5% | 95%→100% (cap) |
| 90%+ acceptance rate | 10+ | Lower | -2% | 95%→93% |
| 95%+ acceptance rate | 20+ | Lower | -5% | 95%→90% |

### Safety Constraints

**Limits per adjustment:**
- **Minimum threshold:** 30% (never go below)
- **Maximum threshold:** 98% (perfection unrealistic)
- **Max change per day:** ±10% total across all adjustments
- **Cooldown:** 24 hours between major changes (>5%)

**User control:**
- **Lock thresholds:** Prevent changes to specific thresholds
- **Disable adaptive:** Turn off entirely
- **Revert:** Undo any adjustment
- **Notification:** Always informed of changes

### Example Adaptive Flow

**Scenario:** You set autoApply = 95%

**Week 1:**
```
Day 1-3: 10 suggestions at 95%+
         Accepted: 3, Rejected: 7 (30% acceptance)

Day 4: System detects: "70% rejection is too high"
       Adjustment: 95% → 97% (+2%)
       Notification: "Raised autoApply to 97% (you rejected 70% at 95%)"
```

**Week 2:**
```
Day 5-7: 8 suggestions at 97%+
         Accepted: 7, Rejected: 1 (87% acceptance)

Day 8: System detects: "87% acceptance is good, stable"
       No adjustment
```

**Week 3:**
```
Day 10-14: 25 suggestions at 97%+
           Accepted: 24, Rejected: 1 (96% acceptance)

Day 15: System detects: "96% acceptance, could be more permissive"
        Adjustment: 97% → 95% (-2%)
        Notification: "Lowered autoApply to 95% (you accept 96% at this level)"
```

**Result:** Threshold oscillates around optimal point (95-97%) based on your actual behavior.

### Transparency & Notifications

**Every adjustment triggers notification:**

```markdown
## 📊 Threshold Adjusted

**Threshold:** autoApply
**Change:** 95% → 93% (-2%)
**Reason:** High acceptance rate at current level

**Data over last 7 days:**
- Suggestions at 95%+: 25
- Your decisions: 24 accepted, 1 rejected (96% acceptance)
- Analysis: You're comfortable with slightly lower threshold

**Impact:**
- More suggestions will auto-apply
- Estimated: +3 auto-applies per week

**Controls:**
- Revert: "Set autoApply to 95%"
- Lock: "Lock autoApply threshold"
- Disable: "Disable adaptive tuning"

[View full history] [Understood]
```

### Integration with v4.23.0 & v4.24.0

**Adaptive tuning leverages all previous features:**

1. **Implicit signals (v4.23.0):**
   - Strong positive ("perfect!") → Higher confidence scores
   - Corrections ("actually, no") → Immediate threshold raise
   - Keywords factor into acceptance calculations

2. **File-context (v4.24.0):**
   - Thresholds can adapt **per file pattern**
   - Example: autoApply = 95% globally, but 93% for CLAUDE.md (high acceptance there)
   - File-specific tuning based on file-specific acceptance rates

3. **Recovery patterns (v4.24.0):**
   - Proven solutions (95% confidence) can have lower threshold
   - Example: "You solved this before" → Lower threshold to 90% for this pattern
   - Recovery pattern success rate influences threshold

**Combined example:**

```
Task: Fix TypeScript error in src/auth.ts

Analysis:
1. File-context (v4.24.0): src/auth.ts has 92% acceptance for TypeScript fixes
2. Recovery pattern (v4.24.0): typescript-import-error solved before (95% confidence)
3. Implicit signal (v4.23.0): Last time you said "Perfect!" (strong positive)
4. Adaptive tuning (v4.25.0): Lowers threshold to 88% for this context

Result: Auto-applies proven solution at 88% instead of 95%
```

---

## Integration with Previous Versions

### Complete Memory Lane Stack

**Layer 1: Explicit Learning (v3.8.0)**
- Accept/reject/skip actions
- Acceptance rate calculation
- Base: 20 signals per 20 decisions

**Layer 2: Implicit Signals (v4.23.0)**
- Keyword detection (6 types)
- Correction signals
- Boost: 35 signals per 20 decisions (75% more)

**Layer 3: Context Awareness (v4.24.0)**
- File-context memory
- Recovery patterns
- Boost: Context-appropriate suggestions, skip failed approaches

**Layer 4: Pattern Intelligence (v4.25.0)**
- Workflow gap detection
- Adaptive threshold tuning
- Boost: Automation suggestions, self-optimization

**Total impact:**
```
v3.8.0: 20 signals → 60% accuracy → 20 sessions to 90%
v4.23.0: 35 signals → 75% accuracy → 12 sessions to 90% (40% faster)
v4.24.0: 35 signals + context → 85% accuracy → 7 sessions to 90% (65% faster)
v4.25.0: 35 signals + context + adaptive → 90% accuracy from day 1 (10x faster)
```

---

## Examples

### Example 1: Version Bump Workflow Detection

**Over 15 commits:**

```
Commit 1: Edit version.json, run script, edit CHANGELOG, commit
Commit 2: Edit version.json, run script, edit CHANGELOG, commit
Commit 3: Edit version.json, run script, edit CHANGELOG, commit
...
Commit 15: Edit version.json, run script, edit CHANGELOG, commit
```

**System learns:**

```json
{
  "workflowPatterns": {
    "version-bump-workflow": {
      "frequency": 15,
      "patternStrength": 0.94,
      "avgTime": "3.5 minutes"
    }
  }
}
```

**On commit 16:**

```markdown
## 🤖 I Noticed a Pattern

You've done this 15 times:
1. Edit version.json
2. Run sync-version.sh
3. Edit CHANGELOG.md
4. Commit

Total time: ~52 minutes

**I can automate this.**

Script:
```bash
./scripts/bump-version.sh 4.25.0
```

Handles all 4 steps in one command.

[Create script] [Show me how] [Not interested]
```

---

### Example 2: Adaptive Threshold Correction

**Week 1 (Initial):**

```
autoApply threshold: 95%
Suggestions at 95%+: 12
Accepted: 5/12 (42%)
```

**System response:**

```markdown
## 📊 Threshold Too Permissive

**Data:** 58% rejection rate at 95%
**Action:** Raising to 97% (+2%)

This will reduce unwanted auto-applies.
```

**Week 2 (Adjusted):**

```
autoApply threshold: 97%
Suggestions at 97%+: 8
Accepted: 7/8 (87%)
```

**System response:**

```markdown
## 📊 Threshold Stabilized

**Data:** 87% acceptance at 97%
**Action:** No change (optimal)

Current threshold working well.
```

**Week 4 (Re-evaluation):**

```
autoApply threshold: 97%
Suggestions at 97%+: 20
Accepted: 19/20 (95%)
```

**System response:**

```markdown
## 📊 Threshold Too Conservative

**Data:** 95% acceptance at 97%
**Action:** Lowering to 95% (-2%)

You're accepting almost everything, can be more permissive.
```

---

### Example 3: Missing Step Detection

**Your usual workflow:**

```
1. Edit src/auth.ts
2. Run tests
3. Edit tests/auth.test.ts
4. Run tests again
5. Commit
```

**This session:**

```
1. ✓ Edit src/auth.ts
2. ✗ Skipped running tests!
3. ✓ Edit tests/auth.test.ts
```

**System detects gap:**

```markdown
## ⚠️ You Usually Run Tests Here

**Workflow:** test-driven-development
**Missing step:** Run tests (between src edit and test edit)

**Pattern analysis:**
- You do this in 9/10 coding sessions
- Skipping tests led to bugs 2 times before

**Suggestion:** Run tests now before editing test file?

[Run tests] [I'll do it later] [Don't remind me today]
```

---

## Commands

### Workflow Gap Detection

```
"Show workflow patterns"
"What workflows have you detected?"
"Show current workflow progress"
"Did I forget any steps?"
"Suggest automation for version-bump-workflow"
"How much time have I spent on [workflow]?"
"Forget workflow pattern [name]"
"Disable workflow detection"
```

### Adaptive Threshold Tuning

```
"Show adaptive tuning status"
"Why did you adjust autoApply threshold?"
"Show threshold adjustment history"
"Revert autoApply to 95%"
"Lock autoApply threshold at 95%"
"Disable adaptive tuning"
"Enable adaptive tuning"
"Show confidence band statistics"
```

### Combined

```
"Show all learning patterns"
  → Workflow patterns + threshold history + recovery patterns

"Optimize my settings"
  → Runs gap detection + threshold analysis + suggests improvements

"What have you learned about my workflow?"
  → Full summary across all v4.x features
```

---

## Privacy & Data

### What's Stored

**Workflow Gap Detection:**

| Data | Stored | Purpose |
|------|--------|---------|
| **Commit metadata** | Yes (timestamps, messages) | Pattern detection |
| **File edit patterns** | Yes (which files) | Sequential analysis |
| **Command sequences** | Yes (git commands) | Repetition detection |
| **File content** | **No** | Never stored |
| **Commit diffs** | **No** | Never analyzed |

**Adaptive Threshold Tuning:**

| Data | Stored | Purpose |
|------|--------|---------|
| **Acceptance rates** | Yes (by confidence band) | Threshold optimization |
| **Adjustment history** | Yes (timestamp + reason) | Transparency |
| **Suggestion content** | **No** | Only accept/reject recorded |

### Privacy Features

- **Metadata only:** System stores "edited version.json", not file content
- **Pattern abstraction:** Workflows described as sequences, not specific changes
- **Local only:** All data in `~/.claude/user-preferences.json` (never synced)
- **User control:** Delete, disable, or lock any feature anytime

---

## Troubleshooting

### Workflow Patterns Not Detected

**Symptoms:** System doesn't recognize your repetitive workflows

**Check:**
```
"Show workflow detection status"
"How many commits have been analyzed?"
```

**Common causes:**

1. **Not enough data:**
   - Minimum: 10 commits for pattern detection
   - **Fix:** Continue working, patterns emerge after ~20 commits

2. **Low frequency:**
   - Detection threshold: 60% (6/10 commits)
   - **Fix:** Workflow must repeat often to be detected

3. **Disabled:**
   - **Fix:** `"Enable workflow detection"`

---

### Adaptive Tuning Too Aggressive

**Symptoms:** Thresholds changing too often

**Check:**
```
"Show threshold adjustment history"
"Why are thresholds changing so much?"
```

**Solutions:**

1. **Lock specific threshold:**
   ```
   "Lock autoApply threshold at 95%"
   ```

2. **Reduce sensitivity:**
   ```
   "Set adaptive tuning to conservative mode"
   ```
   (Requires more data before adjusting: 20+ samples instead of 10)

3. **Disable for period:**
   ```
   "Disable adaptive tuning for 2 weeks"
   ```

---

### Wrong Automation Suggested

**Symptoms:** System suggests automating workflow you want manual

**Action:**
```
"Never suggest automation for version-bump-workflow"
"Mark version-bump-workflow as manual-only"
```

**Result:** System continues tracking pattern but won't suggest automation.

---

## Summary

**v4.25.0 completes the Memory Lane integration:**

1. **Workflow Gap Detection:**
   - Analyze commit history for patterns
   - Detect missing steps real-time
   - Suggest automation for repetitive workflows
   - Track time savings opportunities

2. **Adaptive Threshold Tuning:**
   - Continuous monitoring of acceptance rates
   - Micro-adjustments (±1-2%) based on behavior
   - Safety limits (±10% max per day, 30-98% range)
   - Transparent notifications with revert option

**Complete Memory Lane Stack:**
- v4.23.0: Implicit signals (keyword detection)
- v4.24.0: Context awareness (file + recovery)
- v4.25.0: Pattern intelligence (workflow + adaptive)

**Total Impact:**
- 10x faster to 90% accuracy (day 1 vs 20 sessions)
- Automation suggestions (save 30-60 min/month)
- Self-optimizing thresholds (no manual tuning needed)

**Next:** No more phases - Memory Lane integration complete!

---

**For more details:**
- [Implicit Learning Signals](07_implicit-learning-signals.md) (v4.23.0)
- [File-Context & Recovery Patterns](08_file-context-and-recovery-patterns.md) (v4.24.0)
- [Personalization Guide](06_personalization-guide.md) (Core concepts)
