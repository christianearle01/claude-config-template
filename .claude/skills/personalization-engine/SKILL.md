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

## Operation 6: Project Preferences (v3.9.0)

**User Queries:**
- "Show project preferences"
- "Set project proactivity to high"
- "Override security threshold for this project"
- "Create project preferences file"
- "Why is this project using different settings?"
- "Show effective preferences" (merged view)

### The Project Override Problem

**Global preferences don't fit all projects:**
- Security-critical project needs stricter thresholds
- Learning project wants more suggestions
- Legacy project has different coding standards
- Team project needs shared conventions

**Solution:** Project-level preference overrides that merge with global.

### Merge Logic

```
Final Preference = Global + Project Override

Merge Rules:
1. Project values override global values
2. Unspecified values inherit from global
3. Deep merge for nested objects
4. Arrays are replaced (not merged)

Example:
Global: { proactivityLevel: "medium", autoApply: 95, hideBelow: 30 }
Project: { proactivityLevel: "high" }
Result: { proactivityLevel: "high", autoApply: 95, hideBelow: 30 }
```

### File Locations

```
Global (personal):
~/.claude/user-preferences.json

Project (shared with team):
.claude/project-preferences.json

Reading order:
1. Read global preferences
2. Check for project preferences
3. Deep merge (project wins)
4. Return effective preferences
```

### Creating Project Preferences

**User says:** "Create project preferences for this project"

**Steps:**
1. Check if `.claude/project-preferences.json` exists
2. If not, create from template with sensible defaults
3. Prompt user for key overrides (proactivity, security level)
4. Save to `.claude/project-preferences.json`

**Response:**

```markdown
## Project Preferences Created

**File:** .claude/project-preferences.json

I've created a project preferences file with:
- Sparse format (only overrides, inherits rest from global)
- Reason fields for documentation
- Project context section

**Current Overrides:** None (using all global settings)

**To customize:**
- "Set project proactivity to high"
- "Set project autoApply threshold to 98%"
- "Enable strict security scanning for this project"

**Team sharing:**
This file can be committed to git so your team shares the same AI behavior.
```

### Viewing Project Preferences

**User says:** "Show project preferences"

**Response Template:**

```markdown
## Project Preferences: claude-config-template

**Status:** Project overrides active
**File:** .claude/project-preferences.json

---

### Overrides from Global

| Setting | Global | Project | Reason |
|---------|--------|---------|--------|
| proactivityLevel | medium | high | Documentation project - want thorough suggestions |
| autoApply | 95% | 98% | Be conservative with auto-changes |
| security.showInfoLevel | false | true | Show all security findings |

---

### Inherited from Global (no override)

- Experience level: intermediate
- Primary languages: typescript, python
- suggestProminently: 75%
- showAsOptional: 50%
- hideBelow: 30%

---

### Project Context

**Tech Stack:**
- Languages: TypeScript, Markdown
- Frameworks: None (documentation project)
- Testing: None

**Priorities:**
- Security: medium
- Documentation: high
- Performance: low

---

**To modify:** "Set project [setting] to [value]"
**To remove override:** "Remove project override for [setting]"
**To delete all:** "Delete project preferences"
```

### Viewing Effective Preferences

**User says:** "Show effective preferences" or "What settings am I actually using?"

**Response Template:**

```markdown
## Effective Preferences (Merged View)

**Source:** Global + Project overrides

---

### Profile
| Setting | Value | Source |
|---------|-------|--------|
| experienceLevel | intermediate | Global |
| proactivityLevel | high | **Project** |
| primaryLanguages | typescript, python | Global |

### Confidence Thresholds
| Threshold | Value | Source |
|-----------|-------|--------|
| autoApply | 98% | **Project** |
| suggestProminently | 75% | Global |
| showAsOptional | 50% | Global |
| hideBelow | 30% | Global |

### Skill Settings
| Skill | Setting | Value | Source |
|-------|---------|-------|--------|
| security-scanner | showInfoLevel | true | **Project** |
| test-generator | coverageTarget | 80% | Global |

---

**Legend:**
- Global = From ~/.claude/user-preferences.json
- **Project** = Override from .claude/project-preferences.json
```

### Modifying Project Preferences

**User says:** "Set project proactivity to low"

**Steps:**
1. Load current project preferences (or create if not exists)
2. Set `overrides.profile.proactivityLevel = "low"`
3. Add reason field if user provides one
4. Save to `.claude/project-preferences.json`

**Response:**

```markdown
✅ Updated project preference

**Setting:** proactivityLevel
**Global value:** medium
**Project override:** low

**Reason:** (none provided)

To add a reason: "Set project proactivity reason to 'Security-critical project'"

**Effective value for this project:** low
```

### Removing Project Override

**User says:** "Remove project override for proactivity"

**Steps:**
1. Load project preferences
2. Delete `overrides.profile.proactivityLevel`
3. Save changes

**Response:**

```markdown
✅ Removed project override

**Setting:** proactivityLevel
**Was:** low (project override)
**Now:** medium (global default)

This project will now use your global proactivity setting.
```

### Deleting Project Preferences

**User says:** "Delete project preferences"

**Response:**

```markdown
⚠️ Delete Project Preferences

This will:
- Delete .claude/project-preferences.json
- Revert to using global preferences only
- Remove all project-specific overrides

**Backup:** I'll create .claude/project-preferences.json.backup first

Are you sure? Say "confirm delete project preferences" to proceed.
```

### Project Context

The `projectContext` section provides hints to skills:

```json
{
  "projectContext": {
    "techStack": {
      "languages": ["typescript"],
      "frameworks": ["react"],
      "testing": ["jest"]
    },
    "priorities": {
      "security": "high",
      "performance": "medium"
    }
  }
}
```

**How skills use this:**
- **test-generator:** Uses `testing` to choose framework
- **security-scanner:** Uses `security` priority to adjust thoroughness
- **standards-enforcer:** Uses `techStack` for language-specific rules

### Team Sharing

**Key difference from global preferences:**

| Aspect | Global Preferences | Project Preferences |
|--------|-------------------|---------------------|
| Location | `~/.claude/` | `.claude/` in project |
| Scope | All projects | This project only |
| Git | Not committed | Can be committed |
| Sharing | Personal only | Team can share |
| Privacy | Private settings | Shared conventions |

**Recommendation:** Commit `.claude/project-preferences.json` to git so your team uses the same AI behavior.

---

## File Structure

```
~/.claude/
├── user-preferences.json         # Global preferences (personal)
├── user-preferences.json.backup  # Auto-backup before changes
└── ...

<project-root>/.claude/
├── project-preferences.json      # Project overrides (team-shareable)
└── ...

Templates:
├── templates/user-preferences.json.template
└── templates/project-preferences.json.template
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
| "Show project preferences" | Display project overrides |
| "Set project [setting] to [value]" | Create/update project override |
| "Show effective preferences" | Display merged view |
| "Delete project preferences" | Remove project overrides |

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

## Operation 7: AI-Suggested Tuning (v3.10.0)

**User Queries:**
- "Suggest preference improvements"
- "Analyze my preferences"
- "Why am I seeing so many suggestions?"
- "Optimize my settings"
- "Tune my preferences"
- "Show tuning suggestions"

**Auto-trigger:** When `analysisIntervalDays` has passed since `lastAnalyzedAt` and `totalDecisionsTracked >= minimumSampleSize`

### The Tuning Problem

**Without AI-Suggested Tuning:**
- Users set preferences once and forget
- High rejection rate = wasted suggestions
- High acceptance rate = could be more proactive
- No feedback on whether settings are optimal
- Preferences drift from actual behavior

**With AI-Suggested Tuning:**
- System analyzes decision patterns
- Generates confidence-scored recommendations
- User applies with one command or dismisses
- Preferences evolve based on actual usage

### Analysis Algorithm

```
1. CHECK PREREQUISITES:
   - totalDecisionsTracked >= minimumSampleSize (default: 20)
   - Time since lastAnalyzedAt > analysisIntervalDays (default: 7)
   - If not met: Return "insufficient data" response

2. ANALYZE THRESHOLDS:
   For each confidence level (autoApply, suggestProminently, showAsOptional):

   a. Calculate acceptance rate for suggestions at that level
   b. If rejectionRate > 40%:
      → SUGGEST raising threshold
      → Rationale: "You rejected X% of suggestions at this level"
   c. If acceptanceRate > 90%:
      → SUGGEST lowering threshold (more automation)
      → Rationale: "You accept X% at this level - could automate more"

3. ANALYZE PROACTIVITY:
   a. If overallAcceptanceRate < 60%:
      → SUGGEST lowering proactivity
      → Rationale: "Overall acceptance low - reduce suggestion frequency"
   b. If overallAcceptanceRate > 85% AND skillUsageFrequency is high:
      → SUGGEST raising proactivity
      → Rationale: "High acceptance + active usage = can show more"

4. ANALYZE CATEGORY VARIANCE:
   For each category in categoryBreakdown:

   a. Calculate category-specific acceptance rate
   b. If variance > 25% from overall:
      → SUGGEST category-specific settings
      → Example: "coding-style: 92%, documentation: 41%"

5. ANALYZE SKILLS:
   For each skill in skillUsageFrequency:

   a. If skill acceptance < 50% AND sampleSize > 10:
      → SUGGEST disabling or threshold override
      → Rationale: "This skill's suggestions aren't matching your preferences"
   b. If skill acceptance > 95% AND sampleSize > 20:
      → SUGGEST skill can be more proactive
      → Rationale: "You accept almost all - could auto-apply"

6. SCORE AND RANK SUGGESTIONS:
   confidence = High (samples >= 50), Medium (>= 20), Low (< 20)
   impact = deviation from optimal rate
   priority = confidence × impact

   Sort by priority, return top 3

7. UPDATE tuningSuggestions:
   - Set lastAnalyzedAt to now
   - Store pendingSuggestions
   - Preserve suggestionHistory
```

### Confidence Scoring

| Sample Size | Confidence | Reliability |
|-------------|------------|-------------|
| ≥ 50 | High | Strong pattern, reliable suggestion |
| 20-49 | Medium | Emerging pattern, moderate confidence |
| < 20 | Low | Insufficient data, tentative suggestion |

### Response Template: Tuning Suggestions Found

```markdown
## Preference Tuning Suggestions

Based on analyzing **{totalDecisions}** decisions over **{learningPeriodDays}** days:

---

### Suggestion 1: Raise Auto-Apply Threshold (High Confidence)

**Current:** autoApply = 95%
**Suggested:** autoApply = 97%

**Why:** You rejected 43% of auto-applied actions (86 of 200).
Raising the threshold will reduce unwanted automatic changes.

**Data:**
| Metric | Value |
|--------|-------|
| Sample size | 200 decisions |
| Rejection rate | 43% |
| Threshold trigger | > 40% |
| Trend | Stable |

**Actions:**
- Apply: "Set autoApply to 97"
- Dismiss: "Dismiss suggestion 1"
- Snooze: "Snooze suggestion 1 for 2 weeks"

---

### Suggestion 2: Lower Proactivity for Documentation (Medium Confidence)

**Current:** proactivityLevel = medium (global)
**Suggested:** Set documentation category to low proactivity

**Why:** You accept 92% of coding suggestions but only 41% of documentation suggestions.
The variance suggests category-specific settings would help.

**Data:**
| Category | Acceptance | Sample Size |
|----------|------------|-------------|
| coding-style | 92% | 95 |
| documentation | 41% | 29 |
| Variance | 51% | - |

**Actions:**
- Apply: "Set documentation proactivity to low"
- Dismiss: "Dismiss suggestion 2"

---

### Suggestion 3: Consider Disabling test-generator (Low Confidence)

**Current:** test-generator enabled
**Suggested:** Disable or override thresholds

**Why:** You've rejected 67% of test-generator suggestions (8 of 12).
This skill may not match your testing workflow.

**Data:**
| Metric | Value |
|--------|-------|
| Sample size | 12 decisions |
| Rejection rate | 67% |
| Confidence | Low (needs more data) |

**Actions:**
- Apply: "Disable test-generator skill"
- Override: "Set test-generator threshold to 90%"
- Wait: "Keep collecting data"

---

### Summary

| Category | Acceptance | Trend | Suggested Action |
|----------|------------|-------|------------------|
| coding-style | 92% | improving | None needed |
| workflow | 78% | stable | None needed |
| quality | 85% | stable | None needed |
| documentation | 41% | declining | **Lower proactivity** |

**Next analysis:** {nextAnalysisDate} (in 7 days)

---

**Quick Actions:**
- "Apply suggestion 1" - Apply first suggestion
- "Apply all suggestions" - Apply all (use with caution)
- "Dismiss all" - Dismiss all suggestions
- "Show suggestion details" - More information
```

### Response Template: No Suggestions Needed

```markdown
## Preference Analysis Complete

**Status:** Your preferences are well-tuned!

**Analysis Period:** {learningPeriodDays} days
**Decisions Analyzed:** {totalDecisions}
**Last Analysis:** {lastAnalyzedAt}

---

### Current Performance

| Metric | Value | Status |
|--------|-------|--------|
| Overall acceptance | 82% | Good |
| Decisions tracked | 156 | Sufficient |
| Learning period | 21 days | Mature |

---

### Category Breakdown

| Category | Acceptance | Trend | Status |
|----------|------------|-------|--------|
| coding-style | 89% | stable | ✓ Well-tuned |
| workflow | 78% | improving | ✓ Well-tuned |
| quality | 85% | stable | ✓ Well-tuned |
| documentation | 76% | stable | ✓ Well-tuned |

---

### Analysis Summary

All metrics within optimal ranges:
- ✓ No thresholds triggering high rejection
- ✓ No categories with significant variance
- ✓ No underperforming skills detected

**Next analysis:** {nextAnalysisDate}

---

**Tip:** You can always manually adjust preferences:
- "Set autoApply to 98%"
- "Set proactivity to low"
- "Show my current thresholds"
```

### Response Template: Insufficient Data

```markdown
## Preference Analysis: Insufficient Data

**Status:** Not enough data for meaningful analysis

**Current Data:**
| Metric | Value | Required |
|--------|-------|----------|
| Decisions tracked | {totalDecisions} | ≥ 20 |
| Days since last analysis | {daysSinceAnalysis} | ≥ 7 |

---

### What's Needed

To generate tuning suggestions, we need:
1. **Minimum 20 decisions** - Accept, reject, or skip suggestions from skills
2. **At least 7 days** since last analysis

**Current Progress:**
```
Decisions: [{totalDecisions}/20] ████████░░░░░░░░░░░░ {percentage}%
```

---

### How to Build Data Faster

Use skills that track decisions:
- **security-scanner** - Accept/reject security findings
- **standards-enforcer** - Accept/reject style suggestions
- **test-generator** - Accept/reject test suggestions
- **commit-readiness-checker** - Accept/reject pre-commit checks

Each decision you make helps the system learn your preferences.

**Check again:** "Analyze my preferences" (after more usage)
```

### Applying Suggestions

**User says:** "Apply suggestion 1" or "Set autoApply to 97"

**Steps:**
1. Find pending suggestion by ID or parse direct command
2. Update relevant preference in `user-preferences.json`
3. Move suggestion from `pendingSuggestions` to `suggestionHistory`
4. Set status to "applied"

**Response:**

```markdown
✅ Applied Tuning Suggestion

**Change:** autoApply threshold
**Before:** 95%
**After:** 97%

**Rationale:** Reduces unwanted auto-applied actions based on your 43% rejection rate.

**Effect:** Actions now need ≥97% confidence to auto-apply.

**To revert:** "Set autoApply to 95%"

---

**Remaining suggestions:** 2
- "Show tuning suggestions" to see others
```

### Dismissing Suggestions

**User says:** "Dismiss suggestion 1" or "Dismiss all"

**Steps:**
1. Find suggestion(s) by ID
2. Move to `suggestionHistory` with status "dismissed"
3. Record `actionAt` timestamp

**Response:**

```markdown
✅ Dismissed Suggestion

**Suggestion:** Raise Auto-Apply Threshold
**Status:** Dismissed (won't be suggested again)

**Note:** If your rejection pattern continues, a similar suggestion may appear in future analyses with fresh data.

**Remaining suggestions:** 2
```

### Snoozing Suggestions

**User says:** "Snooze suggestion 1 for 2 weeks"

**Steps:**
1. Calculate `snoozeUntil` date
2. Set status to "snoozed"
3. Move to history with snooze timestamp

**Response:**

```markdown
✅ Snoozed Suggestion

**Suggestion:** Raise Auto-Apply Threshold
**Status:** Snoozed until {snoozeUntilDate}

I'll remind you about this suggestion after the snooze period if the pattern persists.

**Remaining suggestions:** 2
```

### Viewing Suggestion History

**User says:** "Show suggestion history" or "What suggestions have I applied?"

**Response:**

```markdown
## Tuning Suggestion History

### Applied

| Date | Suggestion | Change |
|------|------------|--------|
| 2025-12-10 | Raise autoApply | 95% → 97% |
| 2025-12-03 | Lower doc proactivity | medium → low |

### Dismissed

| Date | Suggestion | Reason |
|------|------------|--------|
| 2025-12-08 | Disable test-generator | Wanted to keep trying |

### Snoozed

| Suggestion | Snooze Until |
|------------|--------------|
| Category-specific thresholds | 2025-12-25 |

---

**Total:** 2 applied, 1 dismissed, 1 snoozed
```

### Configuration

Users can adjust tuning behavior in `~/.claude/user-preferences.json`:

```json
{
  "tuningSuggestions": {
    "analysisIntervalDays": 7,
    "minimumSampleSize": 20,
    "thresholds": {
      "triggerAnalysis": {
        "rejectionRateHigh": 0.4,
        "acceptanceRateLow": 0.6,
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

**Configurable options:**

| Setting | Default | Description |
|---------|---------|-------------|
| analysisIntervalDays | 7 | Days between auto-analyses |
| minimumSampleSize | 20 | Min decisions before suggestions |
| rejectionRateHigh | 0.4 | Suggest raising threshold if rejection > this |
| acceptanceRateHigh | 0.9 | Suggest lowering threshold if acceptance > this |
| autoTuning.enabled | false | Auto-apply high-confidence suggestions |

---

## Operation 8: Cross-Project Intelligence (v3.12.0)

**User Queries:**
- "Analyze patterns across my projects"
- "What patterns do I use consistently?"
- "Are my projects configured consistently?"
- "Apply my preferences to this new project"
- "Show cross-project insights"
- "Propagate [setting] to all projects"
- "Show consistency report"

**Auto-trigger:** When `aggregationIntervalDays` has passed since `lastAggregatedAt` and registry has `minProjectsForAnalysis` projects

### The Cross-Project Problem

**Without Cross-Project Intelligence:**
- Learning is siloed per project
- User prefers "conventional commits" in 8/10 projects - new project doesn't know
- Quality standards vary unintentionally
- Workflow preferences rediscovered per project
- No "compound interest" on learning investment

**With Cross-Project Intelligence:**
- Patterns aggregate across all registered projects
- New projects inherit established preferences
- Divergences are detected and flagged
- One command standardizes across projects

### Analysis Algorithm

```
1. CHECK PREREQUISITES:
   - Projects Registry exists at ~/.claude/projects-registry.json
   - At least minProjectsForAnalysis (3) projects registered
   - Time since lastAggregatedAt > aggregationIntervalDays (7)
   - If not met: Return "insufficient data" response

2. LOAD DATA:
   a. Read ~/.claude/projects-registry.json (project list)
   b. Read ~/.claude/user-preferences.json (global learnings)
   c. For each project in registry:
      - Check if <project-path>/.claude/project-preferences.json exists
      - Load project-specific overrides

3. AGGREGATE PATTERNS:
   For each preference category (workflow, coding-style, quality, documentation):
   For each preference item:

   a. Count projects using this pattern (explicit override or inherited default)
   b. Calculate adoption rate: projects_using / total_projects
   c. If adoptionRate >= propagateConfidence (0.8):
      → Mark as "established pattern"
   d. Track which projects have different values

4. DETECT CONSISTENCY:
   For key settings (commit style, branch naming, quality thresholds):

   a. Identify global preference (most common OR explicitly set in global prefs)
   b. Find divergent projects (different value than global)
   c. Score severity:
      - Production project diverges = "action-recommended"
      - Staging project diverges = "warning"
      - Personal/experimental = "info"
   d. Check if divergence has documented reason (in project-preferences)

5. GENERATE SUGGESTIONS:
   Type A: PROPAGATE
   - Pattern used in 80%+ of projects
   - Some projects don't have it
   - Suggestion: "Apply X to remaining Y projects"

   Type B: STANDARDIZE
   - Multiple projects use different values for same setting
   - No clear majority or global preference differs
   - Suggestion: "Standardize X across projects"

   Type C: DETECT-OUTLIER
   - Project falls below established standard
   - E.g., test coverage 50% when standard is 80%
   - Suggestion: "Project Y below your standard for X"

6. SCORE AND RANK:
   confidence = based on sample size and adoption rate
   impact = severity × project_count
   priority = confidence × impact

   Return top 5 suggestions sorted by priority

7. UPDATE TRACKING:
   - Set lastAggregatedAt to now
   - Store detected patterns in projectPatterns
   - Record divergences in consistencyReport
   - Add new suggestions to crossProjectSuggestions.pending
```

### Confidence Scoring for Cross-Project

| Adoption Rate | Project Count | Confidence | Reliability |
|---------------|---------------|------------|-------------|
| ≥ 90% | 5+ projects | High | Strong established pattern |
| 80-89% | 3-4 projects | High | Established pattern |
| 70-79% | 3+ projects | Medium | Emerging pattern |
| < 70% | Any | Low | No clear pattern |

### Response Template: Cross-Project Intelligence Report

```markdown
## Cross-Project Intelligence Report

**Analysis Date:** {date}
**Projects Analyzed:** {count}
**Patterns Detected:** {patternCount}

---

### Established Patterns (80%+ Adoption)

| Pattern | Adoption | Projects | Category |
|---------|----------|----------|----------|
| Conventional commits | 90% (9/10) | All except legacy-app | workflow |
| TypeScript strict mode | 80% (8/10) | All except scripts, tools | coding-style |
| 80% test coverage | 80% (8/10) | All except prototype | quality |
| Auto-update changelog | 90% (9/10) | All except archived | documentation |

---

### Consistency Report

**Overall Consistency:** {percentage}%
**Divergences Found:** {count}

#### Divergence 1: Commit Style (Warning)

**Your standard:** conventional
**Divergent projects:**

| Project | Current Value | Reason |
|---------|---------------|--------|
| legacy-app | simple | Not documented |

**Impact:** Production project using non-standard commit style

**Suggestion:** "Standardize legacy-app to conventional commits"

---

#### Divergence 2: Test Coverage (Info)

**Your standard:** 80%
**Divergent project:**

| Project | Current Value | Reason |
|---------|---------------|--------|
| prototype | 50% | "Experimental - lower coverage acceptable" |

**Impact:** Low (experimental project with documented reason)

**Action:** None recommended (reason documented)

---

### Cross-Project Suggestions

#### Suggestion 1: Propagate TypeScript Strict Mode (High Confidence)

**Type:** Propagate established pattern
**Pattern:** TypeScript strict mode
**Adoption:** 80% (8/10 projects)

**Source projects:** api, web-app, mobile, dashboard, admin, lib, cli, backend
**Target projects:** scripts, tools

**Rationale:** You enable TypeScript strict mode in 80% of projects.
These 2 utility projects may benefit from the same type safety.

**Actions:**
- Apply: "Propagate strict mode to scripts and tools"
- Skip: "Skip this suggestion"
- More info: "Why strict mode?"

---

#### Suggestion 2: Standardize Branch Naming (Medium Confidence)

**Type:** Standardize inconsistent settings
**Pattern:** Branch naming convention
**Current state:** Mixed

| Convention | Projects | Count |
|------------|----------|-------|
| feature/ | api, web-app, mobile | 3 |
| feat/ | dashboard, admin | 2 |
| No prefix | scripts, tools, lib | 3 |

**Rationale:** No clear standard. Consider aligning to most common (feature/).

**Actions:**
- Apply feature/: "Standardize branch naming to feature/"
- Keep varied: "Dismiss this suggestion"

---

### Summary

| Metric | Value | Status |
|--------|-------|--------|
| Pattern consistency | 87% | Good |
| Established patterns | 12 | |
| Projects up-to-date | 8/10 | |
| Suggested actions | 3 | |
| Critical divergences | 0 | ✓ |
| Warnings | 1 | |
| Info items | 2 | |

**Next analysis:** {nextDate} (in 7 days)

---

**Quick Actions:**
- "Apply suggestion 1" - Propagate pattern
- "Apply all propagate suggestions" - Apply all propagate-type suggestions
- "Show divergence details" - More about inconsistencies
- "Ignore project [name] for cross-project" - Exclude from analysis
```

### Response Template: Insufficient Data

```markdown
## Cross-Project Intelligence

**Status:** Insufficient data for cross-project analysis

**Current State:**

| Requirement | Current | Required |
|-------------|---------|----------|
| Projects in registry | {count} | ≥ 3 |
| Projects with preferences | {prefCount} | ≥ 1 |
| Days since last analysis | {days} | ≥ 7 |

---

### How to Enable Cross-Project Analysis

1. **Register more projects:**
   ```
   "Register this project"
   ```
   Or use CLI: `./scripts/register-project.sh`

2. **Build preference history:**
   - Use skills that track decisions
   - Accept/reject suggestions to build patterns
   - Set explicit preferences

3. **Wait for data accumulation:**
   - Minimum 3 projects needed
   - Analysis runs every 7 days

**Check registry:** "Show my projects"
**Check preferences:** "Show my preferences"
```

### Applying Cross-Project Suggestions

**User says:** "Apply suggestion 1" or "Propagate strict mode to scripts and tools"

**Steps:**

1. **Identify target projects:**
   - Parse suggestion or command
   - Get project paths from registry

2. **For each target project:**
   a. Check if `.claude/project-preferences.json` exists
   b. If not, create from template
   c. Add/update the relevant override
   d. Set reason: "Applied from cross-project suggestion"

3. **Update tracking:**
   - Move suggestion to history with status "applied"
   - Record affected projects and timestamp

4. **Confirm to user**

**Response:**

```markdown
✅ Applied Cross-Project Suggestion

**Pattern:** TypeScript strict mode
**Applied to:**

| Project | Status |
|---------|--------|
| scripts | ✓ Created project-preferences.json |
| tools | ✓ Updated existing preferences |

**Changes made:**
```json
{
  "overrides": {
    "skillSpecificPreferences": {
      "standards-enforcer": {
        "typescriptStrictMode": true,
        "_reason": "Applied from cross-project suggestion (80% adoption)"
      }
    }
  }
}
```

**Remaining suggestions:** 2
```

### Propagate to All Projects

**User says:** "Propagate [setting] to all projects"

**Response:**

```markdown
## Propagate Setting to All Projects

**Setting:** Conventional commits
**Current adoption:** 9/10 projects (90%)

**This will update:**

| Project | Current | New |
|---------|---------|-----|
| legacy-app | simple | conventional |

**Confirm:** "Yes, propagate to all"
**Cancel:** "Cancel propagation"
```

### Excluding Projects from Analysis

**User says:** "Ignore [project] for cross-project analysis"

**Steps:**
1. Add project to exclusion list in user preferences
2. Remove from future pattern calculations

**Response:**

```markdown
✅ Excluded from Cross-Project Analysis

**Project:** prototype
**Reason:** User requested exclusion

This project will be:
- ❌ Excluded from pattern aggregation
- ❌ Excluded from consistency reports
- ❌ Not suggested for propagation

**To re-include:** "Include prototype in cross-project analysis"
```

### Configuration

Users can adjust cross-project behavior in `~/.claude/user-preferences.json`:

```json
{
  "crossProjectLearning": {
    "enabled": true,
    "aggregationIntervalDays": 7,
    "thresholds": {
      "minProjectsForPattern": 3,
      "divergenceAlertThreshold": 0.3,
      "propagateConfidence": 0.8,
      "minProjectsForAnalysis": 3
    }
  }
}
```

**Configurable options:**

| Setting | Default | Description |
|---------|---------|-------------|
| enabled | true | Enable/disable cross-project analysis |
| aggregationIntervalDays | 7 | Days between auto-analyses |
| minProjectsForPattern | 3 | Min projects to establish a pattern |
| divergenceAlertThreshold | 0.3 | Alert if >30% diverge |
| propagateConfidence | 0.8 | Min adoption to suggest propagation |
| minProjectsForAnalysis | 3 | Min projects before enabling analysis |

### Integration with Projects Registry

Cross-Project Intelligence uses the Projects Registry (v3.2.0) to:

1. **Enumerate projects:** Get list of all registered projects
2. **Resolve paths:** Find project directories for preference files
3. **Get metadata:** Use tags for severity scoring (production > staging > personal)
4. **Track status:** Consider project update status in recommendations

**Registry location:** `~/.claude/projects-registry.json`

### Integration with Project Preferences (v3.9.0)

When propagating patterns, Operation 8 uses the merge logic from v3.9.0:

1. **Read existing:** Load current project-preferences.json (if exists)
2. **Merge pattern:** Add new override using sparse format
3. **Document reason:** Include why override was added
4. **Preserve custom:** Don't overwrite user's explicit overrides

---

## Operation 9: Import/Export Preferences (v3.13.0)

### Overview

Export your carefully tuned preferences for backup, sharing, or transfer to new machines. Import preferences from exports with validation, preview, and merge strategies.

### User Queries

**Export:**
- "Export my preferences"
- "Export preferences to [path]"
- "Create a preferences backup"
- "Export preferences as template"
- "Export anonymized preferences"

**Import:**
- "Import preferences from [file]"
- "Import preferences"
- "Restore preferences from backup"
- "Restore from last backup"

**Management:**
- "Show export/import history"
- "Compare my preferences with [file]"
- "Show preference diff with [file]"

### Export Types

| Type | Contents | Use Case |
|------|----------|----------|
| **full** | All settings + analytics + history | Personal backup |
| **partial** | User-selected sections only | Share specific settings |
| **anonymized** | Settings without history/timestamps | Team sharing |
| **template** | Core settings only (no learned data) | Reusable starter config |

### Export Algorithm

```
1. DETERMINE EXPORT TYPE
   - Check user request for type specification
   - Default: "full" if not specified

2. GATHER CONTENTS
   - Read ~/.claude/user-preferences.json
   - Apply filter based on export type:
     - full: Include everything
     - partial: Prompt user for sections to include
     - anonymized: Strip analytics, learningHistory, timestamps
     - template: Keep only profile, thresholds, skillSpecificPreferences

3. BUILD EXPORT STRUCTURE
   {
     "$schema": "claude-preferences-export-v1",
     "exportVersion": "1.0.0",
     "exportedAt": "<ISO timestamp>",
     "sourceVersion": "<current version>",
     "exportType": "<type>",
     "compatibility": {
       "minVersion": "3.8.0",
       "maxVersion": "<current version>"
     },
     "contents": { <filtered preferences> },
     "metadata": {
       "checksum": "<sha256 of contents>",
       "exportOptions": { <options used> }
     }
   }

4. WRITE EXPORT FILE
   - Use user-specified path or default (~/.claude/claude-preferences-export.json)
   - Format with 2-space indentation for readability

5. UPDATE TRACKING
   - Add entry to importExport.exportHistory
   - Set importExport.lastExportAt

6. RETURN CONFIRMATION
   - Show export summary
   - Provide import instructions
```

### Import Algorithm

```
1. VALIDATE FILE
   - Check file exists at specified path
   - Parse JSON and validate structure
   - Check $schema matches "claude-preferences-export-v1"
   - Verify version compatibility (minVersion <= current <= maxVersion)

2. CHECK SAFETY LIMITS
   - If safetySettings.maxImportsPerDay exceeded, warn and require override
   - Count today's imports from importHistory

3. CREATE BACKUP
   - If safetySettings.createBackupBeforeImport is true
   - Copy current preferences to timestamped backup
   - Record backup path for potential rollback

4. DETERMINE MERGE STRATEGY
   - Ask user if not specified:
     - "overwrite": Replace all matching sections entirely
     - "merge": Deep merge (import values win on conflict)
     - "selective": User chooses per-section

5. PREVIEW CHANGES
   - Show diff of what will change
   - Highlight conflicts (current vs import values)
   - List new items that will be added
   - Show items that will be removed (overwrite mode)

6. REQUIRE CONFIRMATION
   - If safetySettings.requireConfirmation is true
   - Wait for explicit user approval

7. APPLY IMPORT
   - Execute merge based on strategy
   - Preserve importExport section (never overwrite tracking)
   - Preserve backup section

8. UPDATE TRACKING
   - Add entry to importExport.importHistory
   - Set importExport.lastImportAt
   - Record merge strategy and sections imported

9. RETURN CONFIRMATION
   - Show what was imported
   - Provide rollback command
   - Show backup location
```

### Response Templates

#### Export Success

```markdown
## Export Successful

**Export Type:** Full
**File:** ~/claude-preferences-export.json
**Exported At:** 2025-12-16 10:30:00
**Size:** 4.2 KB

### Contents Exported

| Section | Items | Status |
|---------|-------|--------|
| Profile | 5 settings | ✅ Included |
| Confidence Thresholds | 4 settings | ✅ Included |
| Learned Preferences | 12 items | ✅ Included |
| Skill Preferences | 5 skills | ✅ Included |
| Skipped Recommendations | 3 items | ✅ Included |
| Analytics | 156 decisions | ✅ Included |
| Learning History | 100 events | ❌ Excluded |
| Tuning Suggestions | 2 pending | ✅ Included |
| Cross-Project Patterns | 8 patterns | ✅ Included |

**Checksum:** sha256:a1b2c3...

---

### To Import on Another Machine

1. Copy file to new machine
2. Run: "Import preferences from ~/claude-preferences-export.json"

### Other Export Options

- **Template:** "Export preferences as template"
- **Anonymized:** "Export anonymized preferences"
- **Partial:** "Export only [section] preferences"
```

#### Export as Template

```markdown
## Template Export Successful

**Export Type:** Template
**File:** ~/claude-preferences-template.json

### Contents (Clean Template)

| Section | Items | Included |
|---------|-------|----------|
| Profile | 5 settings | ✅ |
| Confidence Thresholds | 4 settings | ✅ |
| Skill Preferences | 5 skills | ✅ |
| Analytics | - | ❌ (template mode) |
| Learning History | - | ❌ (template mode) |
| Learned Preferences | - | ❌ (template mode) |

**Perfect for:** New team members, new machines, sharing best practices

---

**To use template:**
"Import preferences from ~/claude-preferences-template.json"
```

#### Import Preview

```markdown
## Import Preview

**Source:** ~/claude-preferences-export.json
**Source Version:** 3.12.0 ✅ Compatible
**Merge Strategy:** merge

---

### Changes to Apply

| Setting | Current | Import | Action |
|---------|---------|--------|--------|
| profile.proactivityLevel | medium | high | 🔄 Update |
| confidenceThresholds.autoApply | 95 | 90 | 🔄 Update |
| learnedPreferences.workflow.commit-style | conventional | conventional | ✓ Same |
| skillSpecificPreferences.test-generator.coverageTarget | 80 | 90 | 🔄 Update |

### New Items (will be added)

- learnedPreferences.coding-style.early-returns (acceptanceRate: 0.85)
- skillSpecificPreferences.custom-skill (new configuration)

### Conflicts (import wins in merge mode)

| Setting | Your Value | Import Value |
|---------|------------|--------------|
| confidenceThresholds.autoApply | 95 | 90 |

---

**Backup will be created at:** ~/.claude/user-preferences.json.backup.2025-12-16

**Proceed?**
- "Yes, apply import" - Apply these changes
- "No, cancel" - Cancel import
- "Use selective merge" - Choose per section
- "Show full diff" - More details
```

#### Import Success

```markdown
## Import Successful

**Source:** ~/claude-preferences-export.json
**Strategy:** merge
**Imported At:** 2025-12-16 10:35:00

### Summary

| Category | Imported | Unchanged | Conflicts |
|----------|----------|-----------|-----------|
| Profile | 2 | 3 | 0 |
| Thresholds | 3 | 1 | 1 |
| Learned Preferences | 8 | 4 | 0 |
| Skill Preferences | 2 | 3 | 0 |
| **Total** | **15** | **11** | **1** |

---

**Backup available:** ~/.claude/user-preferences.json.backup.2025-12-16

**To rollback:** "Restore preferences from backup"
**To view changes:** "Show my preferences"
```

#### Import Validation Error

```markdown
## Import Failed: Validation Error

**File:** ~/old-preferences.json
**Error:** Version incompatible

### Details

| Check | Status |
|-------|--------|
| File exists | ✅ |
| Valid JSON | ✅ |
| Schema match | ✅ |
| Version compatible | ❌ |

**Problem:** Export version 2.5.0 is below minimum supported (3.8.0)

### Options

1. **Export fresh:** "Export my preferences" from the source machine
2. **Manual migration:** Copy specific settings by hand
3. **Force import:** "Import preferences from [file] --force" (may cause issues)
```

#### Restore from Backup

```markdown
## Restore from Backup

**Available Backups:**

| # | Date | Size | Reason |
|---|------|------|--------|
| 1 | 2025-12-16 10:30 | 4.1 KB | Pre-import backup |
| 2 | 2025-12-15 14:22 | 3.9 KB | Pre-import backup |
| 3 | 2025-12-14 09:15 | 3.8 KB | Manual backup |

**Select backup to restore:**
- "Restore backup 1" - Most recent
- "Restore backup from 2025-12-15"
- "Show backup 1 contents"
```

#### Backup Restored

```markdown
## Backup Restored

**Restored from:** ~/.claude/user-preferences.json.backup.2025-12-16
**Original date:** 2025-12-16 10:30:00

### What Changed

| Category | Restored Values |
|----------|-----------------|
| Thresholds | autoApply: 95 (was 90) |
| Profile | proactivityLevel: medium (was high) |

**Current backup created:** ~/.claude/user-preferences.json.backup.restore.2025-12-16

Your preferences are back to the state before the last import.
```

#### Show History

```markdown
## Import/Export History

### Recent Exports

| Date | Type | File | Sections |
|------|------|------|----------|
| 2025-12-16 10:30 | full | ~/claude-preferences-export.json | 9 sections |
| 2025-12-10 15:45 | template | ~/team-template.json | 3 sections |
| 2025-12-05 09:00 | anonymized | ~/shared-prefs.json | 6 sections |

### Recent Imports

| Date | Source | Strategy | Imported |
|------|--------|----------|----------|
| 2025-12-16 10:35 | export.json | merge | 15 settings |
| 2025-12-08 14:20 | team-prefs.json | selective | 8 settings |

**Today's imports:** 1 of 5 allowed

---

**Actions:**
- "Export my preferences" - Create new export
- "Clear export history" - Remove history entries
```

#### Compare/Diff

```markdown
## Preferences Comparison

**Current** vs **~/other-preferences.json**

### Differences Found: 8

#### Profile

| Setting | Current | Other |
|---------|---------|-------|
| proactivityLevel | medium | high |
| experienceLevel | intermediate | advanced |

#### Confidence Thresholds

| Setting | Current | Other |
|---------|---------|-------|
| autoApply | 95 | 90 |
| suggestProminently | 75 | 70 |

#### Learned Preferences

| Setting | Current | Other |
|---------|---------|-------|
| commit-style | conventional | semantic |

### Only in Current (3 items)
- skillSpecificPreferences.custom-skill
- learnedPreferences.coding-style.early-returns
- skippedRecommendations.item-xyz

### Only in Other (2 items)
- learnedPreferences.workflow.auto-stage
- skillSpecificPreferences.other-skill

---

**Actions:**
- "Import preferences from ~/other-preferences.json" - Apply these
- "Import only thresholds from ~/other-preferences.json" - Partial import
```

### Configuration

Users can configure import/export behavior in `~/.claude/user-preferences.json`:

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
      "includeLearningHistory": false,
      "includeProjectPatterns": true
    }
  }
}
```

### Export File Format

```json
{
  "$schema": "claude-preferences-export-v1",
  "exportVersion": "1.0.0",
  "exportedAt": "2025-12-16T10:30:00Z",
  "exportedBy": "personalization-engine",
  "sourceVersion": "3.13.0",

  "exportType": "full",

  "compatibility": {
    "minVersion": "3.8.0",
    "maxVersion": "3.13.0",
    "breakingChanges": []
  },

  "contents": {
    "profile": { },
    "confidenceThresholds": { },
    "learnedPreferences": { },
    "skillSpecificPreferences": { },
    "skippedRecommendations": { },
    "dontShowAgain": { }
  },

  "optionalContents": {
    "analytics": { },
    "learningHistory": { },
    "tuningSuggestions": { },
    "crossProjectLearning": { }
  },

  "metadata": {
    "checksum": "sha256:...",
    "exportOptions": {
      "includeAnalytics": true,
      "includeLearningHistory": false,
      "includeProjectPatterns": true
    }
  }
}
```

### Best Practices

**For Backups:**
- Export weekly for regular backups
- Use "full" type to capture everything
- Store exports in cloud storage for safety

**For Team Sharing:**
- Use "anonymized" to share without personal data
- Use "template" for onboarding new team members
- Document which settings are included

**For Machine Migration:**
- Export "full" from old machine
- Import with "merge" on new machine
- Review diff before applying

---

## Operation 10: Preference Templates (v3.14.0)

### Overview

Apply pre-built preference configurations for common use cases. Templates provide curated starting points so new users can get optimized defaults immediately.

### User Queries

**List/Browse:**
- "Show available templates"
- "List preference templates"
- "What templates are available?"

**Apply:**
- "Apply [template-name] template"
- "Apply balanced template"
- "Apply security-first template"
- "Use the learning-mode template"

**Help/Compare:**
- "Help me choose a template"
- "Compare templates"
- "Compare balanced and speed-focused"
- "What's the difference between templates?"

### Available Templates

| Template | Description | Best For |
|----------|-------------|----------|
| **balanced** | Sensible defaults - good suggestions without overwhelm | Most developers |
| **security-first** | Conservative automation, thorough security scanning | Security-conscious |
| **speed-focused** | Maximum automation, fewer interruptions | Experienced devs |
| **learning-mode** | Maximum guidance and suggestions | Beginners |
| **minimal** | Minimal interruptions, maximum autonomy | Experts |

### Template Locations

Templates are stored in: `templates/preference-templates/`

- `balanced.json` - Default recommended template
- `security-first.json` - Security-focused configuration
- `speed-focused.json` - Productivity-optimized configuration
- `learning-mode.json` - Beginner-friendly configuration
- `minimal.json` - Expert/minimal configuration

### Algorithm

```
1. LIST TEMPLATES
   - Read template files from templates/preference-templates/
   - Extract templateMetadata from each
   - Show name, description, recommendedFor
   - Highlight recommended template based on user's experienceLevel

2. RECOMMEND TEMPLATE
   If user asks "help me choose":
   - Read current profile.experienceLevel (if exists)
   - Match to template.recommendedFor
   - Ask clarifying question if needed:
     - "Do you prioritize speed or security?"
     - "How much guidance do you want?"
   - Recommend matching template with explanation

3. APPLY TEMPLATE
   - Load selected template file
   - Use Operation 9 import mechanism
   - Default merge strategy: "merge" (preserves learned preferences)
   - Show preview of changes
   - Create backup before applying
   - Update template tracking in importExport.templates

4. COMPARE TEMPLATES
   - Load both template files
   - Show side-by-side comparison table
   - Highlight key differences
   - Explain trade-offs in plain language
```

### Response Templates

#### List Templates

```markdown
## Available Preference Templates

| Template | Description | Best For |
|----------|-------------|----------|
| **balanced** | Sensible defaults | Most developers |
| **security-first** | Conservative automation | Security-conscious |
| **speed-focused** | Maximum automation | Experienced devs |
| **learning-mode** | Maximum guidance | Beginners |
| **minimal** | Minimal interruptions | Experts |

---

**Your profile:** intermediate
**Recommended:** balanced

---

**Actions:**
- "Apply balanced template"
- "Compare balanced and speed-focused"
- "Help me choose a template"
```

#### Help Choose Template

```markdown
## Help Me Choose a Template

Based on your profile and preferences, I have a few questions:

### 1. Experience Level

What's your experience with Claude Code?
- **Beginner** → learning-mode
- **Intermediate** → balanced
- **Advanced/Expert** → speed-focused or minimal

### 2. Priority

What matters more to you?
- **Safety & thoroughness** → security-first
- **Speed & minimal interruptions** → speed-focused
- **Balance of both** → balanced

### 3. Learning

Do you want to learn from suggestions?
- **Yes, show me everything** → learning-mode
- **Some guidance is fine** → balanced
- **I know what I'm doing** → minimal

---

**Based on typical intermediate developers:**

**Recommended: balanced**

Sensible defaults that provide helpful suggestions without being overwhelming.

**Apply:** "Apply balanced template"
```

#### Apply Template Preview

```markdown
## Apply Template: Balanced Developer

**Template:** balanced
**Description:** Sensible defaults - good suggestions without overwhelm
**Version:** 1.0.0

### Changes to Apply

| Setting | Current | Template | Action |
|---------|---------|----------|--------|
| experienceLevel | - | intermediate | Set |
| proactivityLevel | - | medium | Set |
| autoApply | - | 95 | Set |
| suggestProminently | - | 75 | Set |
| showAsOptional | - | 50 | Set |
| hideBelow | - | 30 | Set |

### Skill Preferences

| Skill | Setting | Value |
|-------|---------|-------|
| security-scanner | showInfoLevel | false |
| test-generator | coverageReminders | true |
| commit-readiness | conventionalCommits | true |

**Merge strategy:** merge
- Template values applied to matching settings
- Your existing learned preferences preserved
- Analytics and history unchanged

---

**Backup will be created at:** ~/.claude/user-preferences.json.backup

**Proceed?**
- "Yes, apply template"
- "No, cancel"
- "Show other templates"
```

#### Template Applied

```markdown
## Template Applied Successfully

**Template:** balanced
**Applied At:** 2025-12-16 11:00:00

### Summary

| Category | Settings Applied |
|----------|------------------|
| Profile | 3 settings |
| Thresholds | 4 settings |
| Skill Preferences | 3 skills |
| **Total** | **10 settings** |

**Backup created:** ~/.claude/user-preferences.json.backup

---

**Your preferences are now configured!**

The balanced template provides:
- Medium proactivity (helpful but not overwhelming)
- Conservative auto-apply (95% confidence required)
- Changelog and conventional commits enabled
- Security scanning at high level only

**To customize further:** "Show my preferences"
**To try different template:** "Apply speed-focused template"
**To restore backup:** "Restore from backup"
```

#### Compare Templates

```markdown
## Template Comparison

**Comparing:** balanced vs speed-focused

### Profile Settings

| Setting | balanced | speed-focused |
|---------|----------|---------------|
| experienceLevel | intermediate | advanced |
| proactivityLevel | medium | high |
| preferredWorkflow | wizard | automated |

### Confidence Thresholds

| Threshold | balanced | speed-focused |
|-----------|----------|---------------|
| autoApply | 95 | 90 |
| suggestProminently | 75 | 65 |
| showAsOptional | 50 | 40 |
| hideBelow | 30 | 25 |

### Key Differences

**balanced:**
- More conservative automation (95% vs 90% for auto-apply)
- More suggestions shown (lower hideBelow threshold)
- Wizard-guided workflows
- Good for: Most developers, learning Claude Code

**speed-focused:**
- More aggressive automation (90% auto-apply)
- Fewer interruptions (higher hideBelow threshold)
- Automated workflows preferred
- Good for: Experienced devs who want speed

---

**Choose:**
- "Apply balanced template"
- "Apply speed-focused template"
- "Compare other templates"
```

### Integration with Operation 9

Templates are applied using the Operation 9 import mechanism:

1. Template files use the same `claude-preferences-export-v1` schema
2. `exportType: "template"` indicates it's a template
3. Apply uses the same preview/backup/merge flow as regular imports
4. Template tracking recorded in `importExport.templates`

### Template Tracking

Applied templates are tracked in user preferences:

```json
{
  "importExport": {
    "templates": {
      "appliedTemplate": "balanced",
      "appliedAt": "2025-12-16T11:00:00Z",
      "templateHistory": [
        {
          "templateId": "balanced",
          "appliedAt": "2025-12-16T11:00:00Z",
          "mergeStrategy": "merge"
        }
      ]
    }
  }
}
```

### Creating Custom Templates

Users can create their own templates:

1. Configure preferences as desired
2. Export as template: "Export preferences as template"
3. Share the exported file
4. Others can import: "Import preferences from [file]"

Custom templates use the same format as built-in templates.

---

## Version History

- **v3.14.0** (2025-12-16): Preference Templates
  - Operation 10: Pre-built preference configurations
  - Five curated templates: balanced, security-first, speed-focused, learning-mode, minimal
  - Template listing, comparison, and recommendation
  - Integration with Operation 9 import mechanism
  - Template tracking in user preferences

- **v3.13.0** (2025-12-16): Import/Export Preferences
  - Operation 9: Portable configuration management
  - Four export types: full, partial, anonymized, template
  - Three merge strategies: overwrite, merge, selective
  - Version compatibility checking
  - Preview before import with diff view
  - Automatic backup before import
  - Export/import history tracking
  - Rollback capability from backups

- **v3.12.0** (2025-12-16): Cross-Project Intelligence
  - Operation 8: Cross-project pattern aggregation
  - Consistency detection across projects
  - Propagate/standardize/detect-outlier suggestions
  - Integration with Projects Registry
  - Learning leverage across multiple projects

- **v3.10.0** (2025-12-16): AI-Suggested Tuning
  - Operation 7: Intelligent preference tuning
  - Confidence-scored recommendations
  - Apply/dismiss/snooze workflow
  - Tuning suggestions tracking in preferences
  - Analysis algorithm for thresholds, proactivity, skills

- **v3.9.0** (2025-12-15): Project-level preferences
  - Operation 6: Project preferences management
  - Merge logic (project overrides global)
  - project-preferences.json.template
  - Team sharing support (committable to git)
  - Effective preferences view (merged)

- **v3.8.0** (2025-12-15): Initial implementation
  - Core operations: Read, Update, Thresholds, Analytics
  - Integration protocol for skills
  - user-preferences.json schema
  - Privacy-first local storage
