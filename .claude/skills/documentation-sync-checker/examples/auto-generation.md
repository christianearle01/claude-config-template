# Documentation Auto-Generation Examples

**Purpose:** Practical examples of using documentation-sync-checker's auto-generation features (v4.19.0)

---

## Example 1: Function Documentation Generation

### Scenario
You just wrote a new validation function but haven't documented it yet.

**Code:**
```javascript
// src/validators/config-validator.js
function validateDeploymentConfig(config, environment) {
  if (!config.version) {
    throw new Error('Version required');
  }

  if (environment === 'production' && !config.securityChecks) {
    throw new Error('Security checks required for production');
  }

  return {
    valid: true,
    warnings: config.securityChecks ? [] : ['Security checks disabled']
  };
}
```

### User Query
> "Document the validateDeploymentConfig function"

### Skill Response

```
📝 Documentation Template Generated

Function: validateDeploymentConfig (src/validators/config-validator.js:3)

Suggested docstring:
/**
 * Validates deployment configuration for specified environment
 *
 * Ensures required fields are present and enforces environment-specific
 * requirements (e.g., security checks mandatory for production).
 *
 * @param {Object} config - Deployment configuration object
 * @param {string} config.version - Version string (required)
 * @param {boolean} config.securityChecks - Enable security validation
 * @param {string} environment - Target environment ('development' | 'staging' | 'production')
 * @returns {Object} Validation result
 * @returns {boolean} return.valid - Whether config is valid
 * @returns {string[]} return.warnings - Non-critical warnings
 * @throws {Error} If required fields missing or environment constraints violated
 *
 * @example
 * // Production deployment (security required)
 * const result = validateDeploymentConfig(
 *   { version: '1.0.0', securityChecks: true },
 *   'production'
 * );
 * console.log(result); // { valid: true, warnings: [] }
 *
 * @example
 * // Development deployment (security optional)
 * const result = validateDeploymentConfig(
 *   { version: '1.0.0' },
 *   'development'
 * );
 * console.log(result); // { valid: true, warnings: ['Security checks disabled'] }
 */

Detected:
- 2 parameters (config, environment)
- 1 return value (object with valid/warnings)
- 2 potential throws (version missing, security missing)
- Environment-specific logic (production vs non-production)
- Used in: No usages found yet (new function)

Confidence: 🟢 High (0.87)
- Complete signature analysis
- Error paths identified
- Return structure clear

Next: Copy template above function, adjust param descriptions if needed
```

### Result
Copy-paste the template and you have comprehensive documentation in 2 minutes instead of 15 minutes writing from scratch.

---

## Example 2: New File README Update

### Scenario
You created a new agent file and need to update documentation.

**New File:**
```bash
.claude/agents/deployment-readiness.md (1003 lines)
```

### User Query
> "New agent added, what docs need updating?"

### Skill Response

```
📂 New Files Detected

File: .claude/agents/deployment-readiness.md (1003 lines)
Type: Claude Code agent definition
Purpose: Validates deployment readiness with confidence-scored report

Suggested README update for docs/00-start-here/09_quick-reference.md:

### 8. Deployment-Readiness Agent (NEW in v4.19.0)
**Purpose:** Validate code is ready for deployment

**Usage:**
```bash
@deployment-readiness
# or
"Is this ready to deploy?"
```

**Features:**
- 5 parallel checks: Tests, Security, Documentation, Version, Git State
- Confidence-scored report (0.0-1.0)
- Ready/Conditional/Not-Ready status
- Platform-agnostic pre-deploy validation

**Output:**
✅ Ready (≥85%) - Safe to deploy
⚠️ Conditional (60-84%) - Fix warnings for prod
❌ Not Ready (<60%) - Must fix blockers

**Location:** `.claude/agents/deployment-readiness.md`

Add this section to: docs/00-start-here/09_quick-reference.md
(After "Built-in agents" section, before "Custom Agents")

Also update:
1. version.json - Add "deployment-readiness.md": "4.19.0" to agents section
2. CHANGELOG.md - Add v4.19.0 entry for new agent

Confidence: 🟡 Medium (0.76)
- File structure analyzed
- Integration point identified
- Requires manual review for exact placement

Next: Open QUICK_REFERENCE.md, paste template, adjust formatting
```

### Result
You know exactly what to document and where to add it, saving 15 minutes of decision-making.

---

## Example 3: API Change Documentation

### Scenario
You modified a function signature after code review.

**Git Diff:**
```diff
// scripts/wizard-helpers.sh
-function show_progress() {
-  local current=$1
-  local total=$2
+function show_progress() {
+  local current=$1
+  local total=$2
+  local label="${3:-Progress}"

-  echo "[$current/$total]"
+  printf "[%s: %d/%d]\n" "$label" "$current" "$total"
}
```

### User Query
> "Check if API changes need documentation updates"

### Skill Response

```
⚠️ API Changes Detected

Function: show_progress (scripts/wizard-helpers.sh:45)

Change Summary:
- SIGNATURE: Added optional parameter $3 (label)
- BEHAVIOR: Now displays custom label instead of hardcoded "Progress"
- OUTPUT: Changed from echo to printf for better formatting

Impact: Non-breaking (new optional parameter with default)

Documentation to update:

1. ❌ scripts/progress-bar-guide.md:67
   Current: "show_progress takes 2 arguments: current and total"
   Update to: "show_progress takes 2-3 arguments: current, total, and optional label"

   Add example:
   ```bash
   show_progress 3 5              # Uses default "Progress"
   show_progress 3 5 "Installing" # Custom label: "Installing: 3/5"
   ```

2. ❌ examples/wizard-example.sh:23
   Usage: show_progress $step $total_steps
   Still works (backward compatible) but could use new feature:
   Update to: show_progress $step $total_steps "Setup"

3. ❌ CHANGELOG.md
   Add v4.19.0 entry:
   "Enhanced: show_progress now accepts optional label parameter for custom progress text"

Breaking? No (optional parameter, default behavior preserved)
Backward Compatible? Yes (existing calls work unchanged)

Priority:
- 🔴 High: progress-bar-guide.md (users read this for usage)
- 🟡 Medium: examples/wizard-example.sh (nice to show new feature)
- 🟢 Low: CHANGELOG.md (standard practice)

Confidence: 🟡 Medium (0.72)
- Change detected via git diff
- Breaking/non-breaking analysis complete
- Requires human review for priority judgment

Next: Update progress-bar-guide.md:67 first (most critical)
```

### Result
You know exactly which docs are stale, why they're stale, and what to fix—preventing user confusion.

---

## Example 4: Multi-File Documentation Sweep

### Scenario
You shipped a major feature (v4.19.0) with 3 new files and want to ensure all docs are updated.

### User Query
> "What documentation needs updating for v4.19.0?"

### Skill Response

```
🔍 Documentation Sweep for v4.19.0

New Files Detected: 3
Changed Files: 5
Documentation Status: ⚠️ Incomplete

REQUIRED UPDATES:

1. ❌ .claude/agents/deployment-readiness.md (NEW)
   Status: File created, not documented
   Action: Add to QUICK_REFERENCE.md agents section
   Estimated: 5 minutes

2. ❌ .claude/skills/documentation-sync-checker/SKILL.md (ENHANCED)
   Status: Enhanced with auto-generation, not documented
   Action: Update QUICK_REFERENCE.md skills section
   Estimated: 3 minutes

3. ❌ .claude/commands/release.md (NEW)
   Status: File created, not documented
   Action: Add to QUICK_REFERENCE.md commands section
   Estimated: 4 minutes

4. ⚠️ CHANGELOG.md
   Status: No v4.19.0 entry found
   Action: Add release notes (3 new features)
   Estimated: 10 minutes

5. ⚠️ CLAUDE.md
   Status: Last updated v4.18.0, needs v4.19.0 entry
   Action: Add version history entry
   Estimated: 5 minutes

6. ⚠️ version.json
   Status: Check if all components at v4.19.0
   Action: Run ./scripts/sync-version.sh
   Estimated: 1 minute

OPTIONAL UPDATES:

7. 💡 examples/workflows/
   Suggestion: Add deployment-readiness-workflow.md example
   Value: Shows end-to-end usage
   Estimated: 15 minutes

8. 💡 docs/01-fundamentals/09_decision-framework.md
   Suggestion: Add deployment decision tree
   Value: Helps users choose when to use deployment-readiness
   Estimated: 10 minutes

Total Estimated Time:
- Required: 28 minutes
- Optional: 25 minutes
- Full sweep: 53 minutes

Recommended Order:
1. version.json (1 min - enables automation)
2. CHANGELOG.md (10 min - documents what changed)
3. QUICK_REFERENCE.md (12 min - 3 sections)
4. CLAUDE.md (5 min - version history)
5. Optional: examples + decision framework (25 min)

Confidence: 🟢 High (0.89)
- File detection deterministic (git status)
- Missing docs identified by cross-reference
- Time estimates based on similar updates

Next: Start with version.json → CHANGELOG.md → QUICK_REFERENCE.md
```

### Result
Complete visibility into documentation debt with prioritized action plan. No more "did I update everything?"

---

## Token Savings Breakdown

### Operation 4: Function Documentation (Example 1)
- **Without skill:** 1,200 tokens
  - Read function: 300 tokens
  - Analyze signature/behavior: 400 tokens
  - Draft template: 500 tokens
- **With skill:** 400 tokens
  - Pattern detection + template: 400 tokens
- **Savings:** 800 tokens (67% reduction)
- **Time saved:** 13 minutes (15 min → 2 min)

### Operation 5: New File README (Example 2)
- **Without skill:** 1,000 tokens
  - Explore file structure: 400 tokens
  - Decide where to document: 300 tokens
  - Draft README section: 300 tokens
- **With skill:** 350 tokens
  - File analysis + suggestion: 350 tokens
- **Savings:** 650 tokens (65% reduction)
- **Time saved:** 12 minutes (20 min → 8 min)

### Operation 6: API Change Detection (Example 3)
- **Without skill:** 1,400 tokens
  - Git diff review: 500 tokens
  - Find affected docs: 500 tokens
  - Analyze breaking/non-breaking: 400 tokens
- **With skill:** 450 tokens
  - Change detection + impact analysis: 450 tokens
- **Savings:** 950 tokens (68% reduction)
- **Time saved:** 18 minutes (25 min → 7 min)

### Operation 7: Multi-File Sweep (Example 4)
- **Without skill:** 2,500 tokens
  - Explore all changed files: 1,000 tokens
  - Cross-reference documentation: 800 tokens
  - Build update checklist: 700 tokens
- **With skill:** 600 tokens
  - Automated sweep + prioritization: 600 tokens
- **Savings:** 1,900 tokens (76% reduction)
- **Time saved:** 35 minutes (50 min → 15 min)

---

## When to Use Auto-Generation

**Use auto-generation when:**
- ✅ You just wrote new code (functions, files)
- ✅ You changed API signatures or behavior
- ✅ You're preparing for release (doc completeness check)
- ✅ You're onboarding new team members (ensure docs current)

**Don't use auto-generation when:**
- ❌ Code is still experimental (docs would thrash)
- ❌ Function is trivial (e.g., simple getter/setter)
- ❌ Documentation already exists and is current

**Integration with v4.18.0 Frameworks:**
- **Decision Framework:** "Is my code ready to document?" → Yes if stable, no if experimental
- **Integration Pattern:** Code complete → Documentation-Sync (auto-generate) → Review → Commit

---

## Related Resources

- Main skill: `.claude/skills/documentation-sync-checker/SKILL.md`
- Prompt Patterns: `docs/01-fundamentals/08_prompt-patterns.md`
- Decision Framework: `docs/01-fundamentals/09_decision-framework.md`
- QUICK_REFERENCE: `docs/00-start-here/09_quick-reference.md`

---

**Version:** 4.19.0
**Last Updated:** 2025-12-17
**Part of:** v4.19.0 "Complete Workflows" - From Code to Production
