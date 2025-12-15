---
name: personalization-engine
description: Central hub for managing user preferences, learning patterns, and adapting skill behavior based on historical feedback. Enables "tell me once" paradigm where the system remembers and adapts.
allowed-tools: Read, Write, Bash
---

# Personalization Engine Skill

**Purpose:** Central preference management that enables skills to learn from user feedback, persist decisions across sessions, and adapt behavior based on individual patterns.

**When to use:**
- User asks about their preferences ("what have you learned about me?")
- User wants to adjust confidence thresholds
- User says "don't show this again" or "remember this preference"
- Skills need to read/write user preferences
- User wants to see personalization analytics

**Key Innovation:** "Tell me once" paradigm - decisions persist across sessions, skills learn and adapt.

**Location:** `~/.claude/user-preferences.json` (global, not per-project)

---

## The Personalization Problem

### Without Personalization

**Typical experience:**
```
Session 1:
User: "Skip that suggestion"
Claude: [Suggestion hidden for this session]

Session 2:
User: "Why are you showing me that again?!"
Claude: [No memory of previous decision]
```

**Problems:**
- Users repeat same decisions session after session
- Skills don't learn from feedback
- No persistence of "don't show again" choices
- Generic suggestions that don't match user style
- **40% productive time lost** to re-establishing context

### With Personalization Engine

**New experience:**
```
Session 1:
User: "Skip that suggestion"
Claude: [Records: user skipped 'verbose-logging' - now at 3 skips]
        "Got it. I've noted you prefer to skip verbose logging suggestions.
         After 3 skips, I won't suggest this again unless you ask."

Session 2:
Claude: [Reads preferences, sees 'verbose-logging' skipped 3x]
        [Automatically filters out verbose logging suggestions]
        [User never sees it again]

User: "Why don't you suggest verbose logging?"
Claude: "You've skipped verbose logging suggestions 3 times, so I stopped showing them.
         Say 'reset verbose-logging preference' if you'd like to see them again."
```

**Benefits:**
- "Tell me once" → System remembers forever
- Skills learn from accept/reject/skip patterns
- Confidence thresholds adapt to user style
- Personalized suggestions based on history
- Transparency: User can see what system learned

---

## Operation 1: Read User Preferences

**User Queries:**
- "What are my preferences?"
- "Show my personalization settings"
- "What have you learned about me?"
- "Show my skill usage analytics"

### Reading Steps

1. **Check for preferences file:**
   ```bash
   # Check if preferences file exists
   ls ~/.claude/user-preferences.json 2>/dev/null
   ```

2. **Load preferences:**
   - If exists: Parse JSON and return relevant sections
   - If not exists: Return defaults with "no preferences recorded yet" message

3. **Return formatted summary:**

### Response Template: Preferences Summary

```markdown
## Your Personalization Profile

**Learning Period:** 45 days (since 2025-11-01)
**Total Decisions Tracked:** 234
**Overall Acceptance Rate:** 72%

---

### Profile Settings

| Setting | Value |
|---------|-------|
| Experience Level | Intermediate |
| Primary Languages | TypeScript, Python |
| Proactivity Level | Medium |
| Preferred Workflow | Wizard |

---

### Confidence Thresholds

| Action | Your Threshold | Default | Difference |
|--------|---------------|---------|------------|
| Auto-apply | 95% | 90% | +5% (more conservative) |
| Suggest prominently | 75% | 75% | Same |
| Show as optional | 50% | 50% | Same |
| Hide below | 30% | 25% | +5% (less noise) |

---

### Top Skills by Usage

| Rank | Skill | Invocations | Last Used |
|------|-------|-------------|-----------|
| 1 | version-management | 78 | Today |
| 2 | commit-readiness-checker | 56 | Today |
| 3 | security-scanner | 34 | Yesterday |
| 4 | test-generator | 28 | 3 days ago |
| 5 | standards-enforcer | 22 | Today |

---

### Learned Preferences

**High Acceptance (>75%):**
- Null checks before dereferencing (92%)
- Conventional commit messages (88%)
- TypeScript strict mode (85%)

**Low Acceptance (<40%):**
- Early returns (23%) - You prefer explicit conditionals
- Verbose logging (12%) - You prefer minimal logging
- JSDoc comments (35%) - You prefer inline comments

**Permanently Skipped:**
- sequential-thinking MCP setup (skipped 3x, permanent)
- Git hook installation (skipped 2x, permanent)

---

### Recommendations

Based on your patterns:

1. **workflow-analyzer** (78% confidence)
   - You commit frequently (15 commits this week)
   - This skill could identify optimization patterns
   - Estimated time: 2 minutes to enable

2. **Raise auto-apply threshold to 97%** (65% confidence)
   - You rarely accept auto-applied changes
   - Higher threshold = fewer surprises

Would you like to adjust any of these settings?
```

### Response Template: No Preferences Yet

```markdown
## Personalization Status

**Status:** No preferences recorded yet

You're starting fresh! As you use Claude Code, I'll learn your preferences:

**What I'll Learn:**
- Which suggestions you accept vs reject
- Your preferred coding style patterns
- Which recommendations you skip
- Your confidence threshold preferences

**How It Works:**
1. Use skills normally (commit-readiness, security-scanner, etc.)
2. Accept, reject, or skip suggestions
3. Preferences are saved to `~/.claude/user-preferences.json`
4. Future sessions adapt based on your history

**Privacy:**
- All data stored locally on your machine
- Never synced to cloud
- You can view, edit, or delete anytime

Start using skills and I'll begin learning your preferences!
```

---

## Operation 2: Update Preferences

**User Queries:**
- "Remember that I prefer X"
- "Don't show this suggestion again"
- "Set my proactivity level to low"
- "Update my confidence threshold to 90%"
- "Skip this recommendation permanently"

### Update Types

#### Type 1: Direct Preference Setting

User explicitly sets a preference.

**Example:**
```
User: "Set my proactivity level to low"

Response:
✅ Updated proactivity level: medium → low

What this means:
- Only high-confidence suggestions will be shown
- Optional suggestions will be hidden
- Minimal interruptions during workflow

To revert: Say "set proactivity to medium"
```

#### Type 2: Feedback-Based Learning

Skills report user decisions, engine updates acceptance rates.

**Feedback Protocol:**

```typescript
interface PreferenceFeedback {
  skill: string;         // e.g., "standards-enforcer"
  category: string;      // e.g., "coding-style"
  item: string;          // e.g., "early-returns"
  action: "accept" | "reject" | "skip" | "dont-show-again";
  context?: string;      // Optional context
  timestamp: string;     // ISO date
}
```

**Learning Algorithm:**

```
New acceptance rate = (old_rate × old_samples + new_value) / (old_samples + 1)

Where:
- accept = 1.0
- reject = 0.0
- skip = 0.3 (weak negative signal)

Example:
- Old rate: 0.60 (60%), 10 samples
- User rejects suggestion
- New rate: (0.60 × 10 + 0.0) / 11 = 0.545 (54.5%)
```

**Threshold Rules:**

| Acceptance Rate | Status | Behavior |
|-----------------|--------|----------|
| ≥75% | High acceptance | Show prominently |
| 50-74% | Medium | Show as optional |
| 25-49% | Low | Hide by default (proactivity=high shows) |
| <25% | Very low | Never show |

#### Type 3: Skip Counter

Tracks how many times user skips a recommendation.

```
Skip 1: Note preference
Skip 2: Lower priority
Skip 3: Mark as "permanent skip" (unless user says otherwise)
```

**Response Template: Skill Skipped**

```markdown
Got it. I've noted you skipped "sequential-thinking MCP setup".

**Skip History:**
- Skip 1: 2025-12-10
- Skip 2: 2025-12-12
- Skip 3: Today (permanent skip threshold reached)

**Action:** I won't suggest this again unless you ask.

To see it again: Say "reset sequential-thinking preference"
To see all skipped items: Say "show skipped recommendations"
```

#### Type 4: Don't Show Again

Explicit "never show this" request.

**Response Template: Don't Show Again**

```markdown
✅ Marked as "don't show again": Security scanner info-level findings

**What this affects:**
- Security scanner will hide informational findings
- Only Medium, High, and Critical will be shown

**To revert:**
Say "show security scanner info-level findings again"

**All "don't show again" items:**
1. Security scanner info-level findings
2. Test coverage reminder below 80%
3. Git hook installation prompt
```

### Update Steps

1. **Parse user intent:**
   - Direct setting change?
   - Feedback on a suggestion?
   - Skip request?
   - Don't show again?

2. **Load current preferences:**
   ```bash
   cat ~/.claude/user-preferences.json
   ```

3. **Apply update:**
   - Calculate new values (if learning-based)
   - Merge with existing preferences
   - Create backup if major change

4. **Write updated preferences:**
   ```bash
   cp ~/.claude/user-preferences.json ~/.claude/user-preferences.json.backup
   # Write new content
   ```

5. **Confirm to user:**
   - Show before/after
   - Explain impact
   - Provide revert instructions

---

## Operation 3: Adaptive Threshold Management

**User Queries:**
- "Why did you show me that suggestion?"
- "Why didn't you suggest X?"
- "Make suggestions more/less frequent"
- "Explain my threshold settings"

### How Thresholds Work

**Four threshold levels:**

```
100% ─────────────────────────────────────
      │ AUTO-APPLY ZONE                  │
 95%  ├─────────────────────────────────────  autoApply threshold
      │ PROMINENT SUGGESTION ZONE        │
 75%  ├─────────────────────────────────────  suggestProminently threshold
      │ OPTIONAL SUGGESTION ZONE         │
 50%  ├─────────────────────────────────────  showAsOptional threshold
      │ LOW CONFIDENCE ZONE              │
 30%  ├─────────────────────────────────────  hideBelow threshold
      │ HIDDEN (too low confidence)      │
  0% ─────────────────────────────────────
```

**Proactivity Level Modifiers:**

| Proactivity | autoApply | prominent | optional | hide |
|-------------|-----------|-----------|----------|------|
| Low | 98% | 85% | 70% | 50% |
| Medium | 95% | 75% | 50% | 30% |
| High | 90% | 60% | 40% | 20% |

### Response Template: Threshold Explanation

```markdown
## Why You Saw That Suggestion

**Suggestion:** "Consider using early returns"
**Confidence:** 65%
**Your Threshold:** Show as optional at ≥50%

**Decision Path:**
1. Confidence (65%) < Auto-apply (95%) → Won't auto-apply
2. Confidence (65%) < Prominent (75%) → Won't show prominently
3. Confidence (65%) ≥ Optional (50%) → ✅ Show as optional
4. Confidence (65%) ≥ Hide (30%) → Don't hide

**Result:** Shown as optional suggestion

**Your History with This Pattern:**
- Acceptance rate: 23% (5 accepted, 17 rejected)
- Trend: Declining (you've rejected last 5)

**Recommendation:**
Based on your history, I could stop showing "early returns" suggestions.
Say "don't suggest early returns" to apply this.
```

### Response Template: Why Not Suggested

```markdown
## Why I Didn't Suggest X

**Pattern:** Verbose logging
**Confidence:** 45%
**Your Threshold:** Hide below 50%

**Decision Path:**
1. Confidence (45%) < Hide threshold (50%)
2. **Result:** Hidden

**Your History:**
- Acceptance rate: 12% (2 accepted, 15 rejected)
- Status: Low acceptance (auto-hidden)

**If You Want to See It:**
1. Lower your hide threshold: "set hide threshold to 40%"
2. Reset this specific preference: "reset verbose-logging preference"
3. Ask explicitly: "suggest verbose logging for this code"
```

---

## Operation 4: Skill Usage Analytics

**User Queries:**
- "Which skills do I use most?"
- "Show my usage patterns"
- "What skills should I try?"
- "Analyze my workflow"

### Analytics Response Template

```markdown
## Your Claude Code Usage Analytics

**Analysis Period:** Last 30 days
**Total Skill Invocations:** 234

---

### Usage Distribution

```
version-management      ████████████████████ 78 (33%)
commit-readiness        ██████████████ 56 (24%)
security-scanner        █████████ 34 (15%)
test-generator          ███████ 28 (12%)
standards-enforcer      █████ 22 (9%)
other                   ███ 16 (7%)
```

---

### Usage Patterns

**Peak Usage Times:**
- Most active: Weekdays 9am-12pm
- Least active: Weekends

**Workflow Pattern Detected:** Release-focused
- High version-management usage suggests frequent releases
- commit-readiness checks before every commit
- security-scanner run before deployments

**Session Characteristics:**
- Average session length: 45 minutes
- Average skills per session: 3.2
- Most common sequence: commit-readiness → version-management → security-scanner

---

### Skill Recommendations

Based on your patterns, you might benefit from:

**1. workflow-analyzer** (85% match)
- You have 15 commits this week
- Pattern: Frequent small commits
- Benefit: Identify commit pattern optimizations
- Time to enable: 2 minutes

**2. documentation-sync-checker** (72% match)
- You use version-management frequently
- Pattern: Version updates might drift from docs
- Benefit: Catch documentation staleness early
- Time to enable: 3 minutes

**3. test-generator** (more) (65% match)
- Current usage: 28 invocations
- You run security-scanner frequently
- Pattern: Security-conscious but test coverage unknown
- Benefit: Ensure test coverage matches security focus

---

### Unused Skills

You haven't tried these skills yet:
- projects-registry (multi-project tracking)
- api-debugging (API troubleshooting)
- component-finder (React/Vue component search)

Would you like me to explain any of these?
```

---

## Operation 5: Reset Preferences

**User Queries:**
- "Reset my preferences"
- "Clear preference for X"
- "Start fresh with personalization"
- "Delete my learning history"

### Reset Options

#### Option 1: Reset Specific Preference

```markdown
✅ Reset preference: early-returns

**Before:**
- Acceptance rate: 23% (low)
- Sample size: 22 decisions
- Status: Hidden by default

**After:**
- Acceptance rate: 50% (neutral)
- Sample size: 0
- Status: Will be shown normally

The system will re-learn your preference as you use it.
```

#### Option 2: Reset Category

```markdown
✅ Reset category: coding-style

**Preferences Reset:**
- early-returns
- verbose-logging
- null-checks
- type-annotations
+ 8 more

**What Happens:**
- All coding-style suggestions return to default confidence
- System will re-learn from your decisions
- Other categories (workflow, quality, etc.) unchanged
```

#### Option 3: Full Reset

```markdown
⚠️ Full Preferences Reset

This will:
- Delete ~/.claude/user-preferences.json
- Reset all learned preferences to defaults
- Clear usage analytics
- Remove all "don't show again" items
- Clear skipped recommendations list

**Backup Created:** ~/.claude/user-preferences.json.backup.2025-12-15

Are you sure? Say "confirm reset" to proceed.
```

---

## Integration Protocol for Skills

Other skills integrate with Personalization Engine using this protocol:

### Reading Preferences (Skill Start)

```markdown
## Reading User Preferences

When a skill activates, it should:

1. **Check for preferences file:**
   - If `~/.claude/user-preferences.json` exists, read relevant sections
   - If not, use defaults

2. **Load skill-specific preferences:**
   ```json
   {
     "skillSpecificPreferences": {
       "security-scanner": {
         "showInfoLevel": true,
         "autoFixLowRisk": false
       }
     }
   }
   ```

3. **Load learned preferences for relevant categories:**
   ```json
   {
     "learnedPreferences": {
       "quality": {
         "security-scan-threshold": "high"
       }
     }
   }
   ```

4. **Load confidence thresholds:**
   ```json
   {
     "confidenceThresholds": {
       "suggestProminently": 75,
       "showAsOptional": 50
     }
   }
   ```

5. **Filter suggestions:**
   - Check `dontShowAgain.items` for items to skip
   - Check `skippedRecommendations.items` for skipped items
   - Apply confidence thresholds to each suggestion
```

### Writing Feedback (After User Decision)

```markdown
## Recording User Feedback

When user accepts/rejects/skips a suggestion:

1. **Construct feedback event:**
   ```json
   {
     "timestamp": "2025-12-15T10:30:00Z",
     "skill": "standards-enforcer",
     "category": "coding-style",
     "item": "early-returns",
     "action": "rejected",
     "context": "user preferred explicit conditional"
   }
   ```

2. **Update learned preferences:**
   - Calculate new acceptance rate
   - Update sample size
   - Record trend direction

3. **Update analytics:**
   - Increment decision counter
   - Update category breakdown
   - Add to learning history (max 100 events)

4. **Update skill usage:**
   - Increment usage counter
   - Update lastUsed timestamp

5. **Write to preferences file:**
   - Create backup first
   - Write updated JSON
   - Validate JSON structure
```

### Example: Standards Enforcer Integration

```markdown
## Standards Enforcer + Personalization

**Before (v3.7.0):**
- Standards Enforcer tracks acceptance rates internally
- Learning resets each session
- No cross-skill patterns

**After (v3.8.0):**

**On Activation:**
```
1. Read ~/.claude/user-preferences.json
2. Load learnedPreferences.coding-style
3. Filter suggestions where acceptance_rate < hideBelow threshold
4. Apply confidence modifiers from learned rates
```

**On User Decision:**
```
1. User rejects "early returns" suggestion
2. Calculate new acceptance rate
3. Write feedback to preferences file
4. Update analytics
```

**Result:**
- Learning persists across sessions
- Other skills benefit from coding-style learnings
- User sees consistent behavior
```

---

## File Structure

```
~/.claude/
├── user-preferences.json       # Main preferences file
├── user-preferences.json.backup # Auto-backup before changes
└── ...

Template location:
templates/user-preferences.json.template
```

---

## Privacy & Data

### What's Stored

- **Profile:** Experience level, languages, proactivity
- **Thresholds:** Confidence settings
- **Skill usage:** Which skills used, how often
- **Learned preferences:** Accept/reject patterns
- **Skipped items:** Things you've skipped
- **Learning history:** Last 100 events per category

### What's NOT Stored

- Actual code content
- File paths from your projects
- Any personally identifiable information
- Anything synced to cloud

### Data Location

- **File:** `~/.claude/user-preferences.json`
- **Backup:** `~/.claude/user-preferences.json.backup`
- **Scope:** Local machine only
- **Sync:** Never synced to cloud

### How to Delete

```bash
# Delete preferences (fresh start)
rm ~/.claude/user-preferences.json

# Delete backup too
rm ~/.claude/user-preferences.json.backup
```

---

## Troubleshooting

### Issue: Preferences Not Persisting

**Symptoms:** Decisions don't seem to be remembered

**Causes:**
1. File permissions issue
2. Invalid JSON in preferences file
3. Skill not writing feedback

**Solutions:**
1. Check file permissions: `ls -la ~/.claude/user-preferences.json`
2. Validate JSON: `cat ~/.claude/user-preferences.json | python -m json.tool`
3. Check backup: `cat ~/.claude/user-preferences.json.backup`

### Issue: Wrong Suggestions Appearing

**Symptoms:** Seeing suggestions that should be hidden

**Causes:**
1. Confidence threshold too low
2. Preference not recorded properly
3. Proactivity level overriding

**Solutions:**
1. Check thresholds: "show my confidence thresholds"
2. Check specific preference: "show preference for [item]"
3. Check proactivity: "show my proactivity level"

### Issue: Preferences File Corrupted

**Symptoms:** JSON parse errors when reading preferences

**Solutions:**
1. Restore from backup:
   ```bash
   cp ~/.claude/user-preferences.json.backup ~/.claude/user-preferences.json
   ```
2. If backup also corrupted, delete and start fresh:
   ```bash
   rm ~/.claude/user-preferences.json
   ```

### Issue: Too Many/Few Suggestions

**Symptoms:** Overwhelmed by suggestions OR not seeing useful ones

**Solutions:**
1. Adjust proactivity level:
   - Too many: "set proactivity to low"
   - Too few: "set proactivity to high"
2. Adjust specific thresholds:
   - "set hide threshold to 40%" (see more)
   - "set hide threshold to 50%" (see fewer)

---

## Quick Reference

### Commands

| Command | Description |
|---------|-------------|
| "Show my preferences" | Display full preference summary |
| "Show my thresholds" | Display confidence thresholds |
| "Show my skill usage" | Display usage analytics |
| "Set proactivity to [low/medium/high]" | Adjust proactivity |
| "Set [threshold] to [value]" | Adjust specific threshold |
| "Don't show [item] again" | Permanently hide item |
| "Reset [item] preference" | Clear learned preference |
| "Reset all preferences" | Full reset (with backup) |

### Proactivity Levels

| Level | Description | Best For |
|-------|-------------|----------|
| Low | Minimal suggestions, only high-confidence | Experienced users, speed |
| Medium | Balanced approach | Most users |
| High | Maximum suggestions, all options shown | Learning, exploration |

### Confidence Thresholds

| Threshold | Default | Description |
|-----------|---------|-------------|
| autoApply | 95% | Auto-apply actions (careful!) |
| suggestProminently | 75% | Show prominently |
| showAsOptional | 50% | Show as optional |
| hideBelow | 30% | Hide suggestions |

---

## Version History

- **v3.8.0** (2025-12-15): Initial implementation
  - Core operations: Read, Update, Thresholds, Analytics
  - Integration protocol for skills
  - user-preferences.json schema
  - Privacy-first local storage
