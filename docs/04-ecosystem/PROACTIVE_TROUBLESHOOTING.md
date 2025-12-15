# Proactive Troubleshooting Guide

**Purpose:** Common failure modes in skills ecosystem, detection patterns, and resolution steps

**Last Updated:** 2025-12-15 (v3.5.0)

---

## Overview

This guide helps troubleshoot the most common issues users encounter with skills, confidence scoring, and the JIT help system. Each section includes:
- **Detection:** How to identify the problem
- **Causes:** Why it happens
- **Resolution:** Step-by-step fixes
- **Prevention:** How to avoid it in future

---

## Issue 1: Skills Not Activating

### Detection Patterns
```
User says:
- "The skill didn't work"
- "Nothing happened when I asked about X"
- "No suggestion appeared"
- "Skill didn't trigger"
```

### Causes
1. **Trigger Keyword Mismatch**
   - User query doesn't match activation triggers in SKILL.md description
   - Example: User asks "show repository list" but skill expects "show projects"

2. **Skill File Moved or Deleted**
   - SKILL.md not in expected location (`.claude/skills/<skill-name>/SKILL.md`)
   - Directory structure changed

3. **YAML Frontmatter Error**
   - Malformed YAML prevents skill from loading
   - Missing required fields (name, description, allowed-tools)

4. **Description Field Empty**
   - Skill has no activation triggers documented
   - Claude doesn't know when to activate it

### Resolution Steps

**Step 1: Verify File Existence**
```bash
ls -la .claude/skills/*/SKILL.md

# Should show all skill files
# If missing, check if file was accidentally deleted/moved
```

**Step 2: Validate YAML Frontmatter**
```bash
head -n 10 .claude/skills/projects-registry/SKILL.md

# Should see:
# ---
# name: projects-registry
# description: [text with trigger phrases]
# allowed-tools: Read, Grep
# ---
```

**Step 3: Check Trigger Phrases**
```bash
grep "description:" .claude/skills/projects-registry/SKILL.md

# Verify description includes keywords like:
# "projects", "registry", "status", "versions"
```

**Step 4: Run Health Check**
```bash
./scripts/claude-health-check.sh

# Look for:
# ✅ Activation Triggers: X/X skills have trigger phrases
# If not 100%, fix missing descriptions
```

**Step 5: Test Activation**
```
Ask Claude:
"What projects do I have?"  (should activate projects-registry)
"What tests failed?"        (should activate testing-workflow)
"Am I ready to commit?"     (should activate commit-readiness-checker)
```

### Prevention
- **When creating skills:** Always include trigger keywords in description field
- **When moving files:** Use `git mv` to track moves, don't manually rename
- **Regular validation:** Run health check monthly to catch issues early

---

## Issue 2: Registry File Stale or Corrupted

### Detection Patterns
```
User says:
- "Project not showing in registry"
- "Status shows wrong version"
- "Can't find my project"
- "Registry data is outdated"
```

### Causes
1. **Project Moved Locations**
   - Path in registry points to old location
   - Registry not updated after `mv` command

2. **version.json Changed**
   - Project version bumped but registry not synced
   - Registry shows old version number

3. **Registry File Corrupted**
   - Manual edit introduced JSON syntax error
   - File truncated or partially overwritten

4. **Registry Not Created Yet**
   - User never ran initial registration
   - ~/.claude/projects-registry.json doesn't exist

### Resolution Steps

**Step 1: Check Registry Exists**
```bash
ls -lh ~/.claude/projects-registry.json

# If "No such file": Run ./scripts/register-project.sh
```

**Step 2: Validate JSON Syntax**
```bash
cat ~/.claude/projects-registry.json | python -m json.tool

# If syntax error: Fix JSON or restore from backup
```

**Step 3: Verify Project Path**
```bash
grep "path" ~/.claude/projects-registry.json

# Check if paths match current project locations
# Update if projects moved
```

**Step 4: Re-register Project**
```bash
# Interactive wizard
./scripts/register-project.sh

# Or CLI update
./scripts/claude-projects.sh update <project-id>
```

**Step 5: Sync All Versions**
```bash
# Bulk sync all registered projects
./scripts/claude-projects.sh sync

# Reads version.json from each project
# Updates registry with current versions
```

### Prevention
- **After moving projects:** Immediately update registry
- **After version bumps:** Run `./scripts/claude-projects.sh sync`
- **Backup registry:** `cp ~/.claude/projects-registry.json ~/.claude/projects-registry.json.bak` before manual edits

---

## Issue 3: Confidence Scores Seem Wrong

### Detection Patterns
```
User says:
- "Skill gave 🔴 Low confidence but was correct"
- "Confidence score doesn't match my experience"
- "Why is confidence so low?"
```

### Causes
1. **Ambiguous User Query**
   - Query lacks specificity
   - Multiple interpretations possible
   - Example: "Check status" (status of what?)

2. **Missing Data Dependencies**
   - Skill requires file that doesn't exist
   - Example: test-results.json missing for testing-workflow
   - Confidence drops when data unavailable

3. **Contextual Activation**
   - Skill activated from context, not explicit keywords
   - Lower confidence when implicit activation

4. **Confidence Calibration**
   - Skill author set conservative thresholds
   - Projected confidence may differ from real-world accuracy

### Resolution Steps

**Step 1: Rephrase Query**
```
Instead of: "Check status"
Try: "What's the status of my projects?"  (explicit)

Instead of: "Show me errors"
Try: "What tests failed?"  (specific)
```

**Step 2: Verify Data Availability**
```bash
# For testing-workflow skill
ls -lh test-results.json

# For projects-registry skill
ls -lh ~/.claude/projects-registry.json

# If missing, generate data first
```

**Step 3: Provide More Context**
```
Instead of: "Any issues?"
Try: "Any issues with the authentication module tests?"

More context = higher confidence
```

**Step 4: Check Skill Reasoning**
```
Look at confidence bullet points:
🟡 Medium (0.65)
- Ambiguous query (multiple interpretations)  ← This tells you why
- Missing test results file
- Partial data available
```

### Prevention
- **Be specific:** Include what/where/which in queries
- **Generate data first:** Run tests before asking about test results
- **Trust medium confidence:** 0.5-0.8 is often accurate, just less certain

---

## Issue 4: JIT Cheat Sheets Not Appearing

### Detection Patterns
```
User says:
- "Where's the quick reference?"
- "How do I find the cheat sheet?"
- "Skill didn't show me the shortcut guide"
```

### Causes
1. **CHEAT_SHEET.md Missing**
   - File not created for skill
   - Only 4 skills have cheat sheets currently (projects-registry, commit-readiness-checker, version-management, testing-workflow)

2. **Link Not Added to SKILL.md**
   - Cheat sheet exists but SKILL.md doesn't reference it
   - Missing "JIT Help Available" section

3. **User Not Asking for Help**
   - Skill waits for explicit request or stuck pattern
   - JIT help is proactive but not intrusive

4. **Skill Not Detecting Stuck Pattern**
   - User repeating questions but skill doesn't recognize pattern
   - Threshold not met (e.g., needs 3 similar queries)

### Resolution Steps

**Step 1: Check if Cheat Sheet Exists**
```bash
ls .claude/skills/*/CHEAT_SHEET.md

# Should show:
# commit-readiness-checker/CHEAT_SHEET.md
# projects-registry/CHEAT_SHEET.md
# testing-workflow/CHEAT_SHEET.md
# version-management/CHEAT_SHEET.md
```

**Step 2: Explicitly Request Cheat Sheet**
```
Ask:
"Show me the projects registry quick reference"
"Where's the commit readiness cheat sheet?"
"How do I...?" (triggers JIT help)
```

**Step 3: Check SKILL.md Reference**
```bash
grep "CHEAT_SHEET" .claude/skills/projects-registry/SKILL.md

# Should find:
# **JIT Help Available:**
# For quick reference... see: **[Cheat Sheet](./CHEAT_SHEET.md)**
```

**Step 4: Request Direct File Access**
```
Ask: "Read .claude/skills/projects-registry/CHEAT_SHEET.md"
(Direct file path bypasses activation logic)
```

### Prevention
- **Explicit requests work:** Just ask "Show me the X cheat sheet"
- **Check Available cheat sheets:** Use skills catalog CLI: `./scripts/claude-skills.sh list`
- **Suggest improvements:** If stuck but no JIT help appeared, skill detection logic may need tuning

---

## Issue 5: Cross-Skill Confusion

### Detection Patterns
```
User says:
- "Which skill should I use for X?"
- "Two skills seem to do the same thing"
- "Skills activated at same time, confusing"
```

### Causes
1. **Overlapping Trigger Keywords**
   - Multiple skills respond to same keyword
   - Example: "version" triggers both version-management and commit-readiness-checker

2. **Similar Functionality**
   - Skills have related but distinct purposes
   - Example: version-management (file sync) vs commit-readiness-checker (full validation)

3. **User Unclear on Skill Boundaries**
   - Doesn't know which skill handles which task
   - Multiple skills seem applicable

4. **Skills Lack Clear Differentiation**
   - Descriptions too similar
   - Activation triggers overlap heavily

### Resolution Steps

**Step 1: Use Skills Catalog**
```bash
./scripts/claude-skills.sh list

# Shows all skills with one-line summaries
# Identify correct skill for your task
```

**Step 2: Use Specific Keywords**
```
Instead of: "Check version"  (ambiguous)
Try: "Check version consistency across 7 files"  (version-management)
Or: "Am I ready to commit?"  (commit-readiness-checker includes version check)
```

**Step 3: Review Skill Purposes**
```
version-management:
  → Focus: Version sync across specific 7 files
  → Use when: Checking if sync-version.sh ran correctly

commit-readiness-checker:
  → Focus: Full pre-commit validation (6 categories)
  → Use when: About to commit, want comprehensive check
```

**Step 4: Search Skills Catalog**
```bash
./scripts/claude-skills.sh search "test"

# Shows which skills relate to testing
# Helps narrow down correct skill
```

### Prevention
- **Read skill descriptions:** Understand scope before asking
- **Be explicit:** "Use version-management to check..." clarifies intent
- **Precedence is OK:** If 2 skills activate, both provide value from different angles

---

## Issue 6: Token Efficiency Not Realized

### Detection Patterns
```
User says:
- "Token usage still high despite using skills"
- "Not seeing projected savings"
- "Skills supposed to save tokens but didn't"
```

### Causes
1. **Skills Not Activating**
   - User phrasing doesn't match triggers
   - See Issue #1 for resolution

2. **Skills Activating But Not Being Used**
   - Skill provides answer but user asks follow-up without referencing skill context
   - Claude re-explains instead of building on skill response

3. **Comparative Queries**
   - User asking general questions not suited for skills
   - Example: "Explain React" (not skill-appropriate)

4. **Token Savings Are Projections**
   - Documented savings are theoretical based on testing
   - Real-world usage patterns may differ
   - User workflows may not match assumed patterns

### Resolution Steps

**Step 1: Verify Skills Activated**
```
Check Claude's response for skill-specific formatting:
✅ Projects registry skill activated: Emoji indicators, structured output
❌ Generic response: No skill-specific patterns
```

**Step 2: Use Skill-Specific Queries**
```
Instead of: "Tell me about my codebase"  (generic)
Try: "What projects do I have?"  (triggers projects-registry)
     "What tests failed?"  (triggers testing-workflow)
     "Am I ready to commit?"  (triggers commit-readiness-checker)
```

**Step 3: Build on Skill Context**
```
After skill responds with project list:
Instead of: "Tell me more about projects"
Try: "Show me outdated projects"  (leverages skill context)
```

**Step 4: Check Activation Logs**
```bash
# Run health check to see skill coverage
./scripts/claude-health-check.sh

# Verify skills have activation triggers
# ✅ Activation Triggers: 10/10 skills
```

**Step 5: Measure Your Usage**
```
Track tokens over 1 week:
- Note queries that activate skills (look for structured responses)
- Note queries that don't (generic questions)
- Token savings realized when skills activate frequently
```

### Prevention
- **Phrase queries to match triggers:** Check SKILL.md descriptions
- **Use skills catalog:** Find right skill for task: `./scripts/claude-skills.sh list`
- **Realistic expectations:** Token savings are cumulative over many queries
- **Report usage patterns:** Help validate/update projected savings

---

## TODO Discovery Pattern

When skills encounter issues, they proactively mention TODOs:

### Pattern 1: Missing File
```
Skill detects: test-results.json not found

Response includes:
⚠️  TODO: Generate test results file
→ Run: npm test -- --json --outputFile=test-results.json
```

### Pattern 2: Outdated Version
```
Skill detects: Project using v3.0.0, current is v3.5.0

Response includes:
⚠️  TODO: Update project to v3.5.0
→ Run: cd ~/path/to/project && ./scripts/claude-update.sh --apply
```

### Pattern 3: Incomplete Setup
```
Skill detects: ~/.claude/ directory empty

Response includes:
⚠️  TODO: Complete global setup
→ Run: ./scripts/claude-wizard.sh
```

### How TODOs Help
- **Proactive guidance:** Skill tells you what's missing before you ask
- **Executable commands:** Not just "fix this" but "run this command"
- **Context-aware:** TODO appears at right moment (when data needed)

---

## Escalation Paths

When troubleshooting doesn't resolve the issue:

### Level 1: Skills Catalog Help
```bash
./scripts/claude-skills.sh show <skill-name>

# Shows full SKILL.md content
# Includes examples, troubleshooting, common queries
```

### Level 2: Health Check Diagnosis
```bash
./scripts/claude-health-check.sh

# Identifies ecosystem-wide issues
# 7 comprehensive checks
# Actionable recommendations
```

### Level 3: Documentation
```
Check docs:
- QUICK_REFERENCE.md (searchable feature list)
- SKILL.md files (individual skill documentation)
- CHEAT_SHEET.md files (JIT quick reference)
```

### Level 4: GitHub Issues
```
If issue persists:
1. Run health check, save output
2. Document reproduction steps
3. Open issue: github.com/christianearle01/claude-config-template/issues
4. Include: health check output, skill name, query attempted
```

---

## Common Success Patterns

What works well:

### Pattern 1: Explicit Skill Invocation
```
✅ "Use projects-registry to show my projects"
✅ "Check commit readiness with commit-readiness-checker"

Better than:
❌ "Show me stuff"  (too vague)
```

### Pattern 2: Specific Queries
```
✅ "Which tests in the authentication module failed?"
✅ "Is version synced across all 7 files?"

Better than:
❌ "Any problems?"  (too broad)
```

### Pattern 3: Following Skill Suggestions
```
Skill says: "Next step: Run ./scripts/sync-version.sh"
User runs command
User asks: "Did that work?"  ← Skill validates easily
```

---

## Quick Troubleshooting Checklist

```
Issue: Skills not working as expected

✓ [ ] Run health check: ./scripts/claude-health-check.sh
✓ [ ] Verify files exist: ls .claude/skills/*/SKILL.md
✓ [ ] Check trigger phrases: grep "description:" SKILL.md
✓ [ ] Rephrase query with explicit keywords
✓ [ ] Verify data files exist (test-results.json, version.json, etc.)
✓ [ ] Check YAML frontmatter for syntax errors
✓ [ ] Use skills catalog to find right skill
✓ [ ] Read skill CHEAT_SHEET.md if available
✓ [ ] Open GitHub issue if still stuck
```

---

## Additional Resources

- **Skills Catalog CLI:** `./scripts/claude-skills.sh list`
- **Health Check System:** `./scripts/claude-health-check.sh`
- **Individual Skill Docs:** `.claude/skills/<skill-name>/SKILL.md`
- **JIT Cheat Sheets:** `.claude/skills/<skill-name>/CHEAT_SHEET.md` (4 skills)
- **Skills Paradigm:** `docs/00-start-here/SKILLS_PARADIGM.md`
- **GitHub Issues:** https://github.com/christianearle01/claude-config-template/issues

---

**Troubleshooting Version:** 3.5.0
**Covers:** 6 common failure modes + TODO discovery + escalation paths
**Maintained By:** claude-config-template project
