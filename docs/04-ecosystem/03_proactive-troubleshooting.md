# Proactive Troubleshooting Guide

**Purpose:** Common failure modes in skills ecosystem, detection patterns, and resolution steps

**Last Updated:** 2025-12-21 (v4.21.0)

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

## Issue 7: Agent Parse Errors in `/doctor`

### Detection Patterns
```
/doctor output shows:
- "Agent Parse Errors"
- "Failed to parse N agent file(s)"
- "Missing required 'name' field in frontmatter"
- Specific agents listed (e.g., initializer.md, coder.md)
```

### Causes
1. **Missing Version Field**
   - Agent frontmatter lacks `version:` field
   - Some agents require version for proper parsing
   - Error message is misleading (says "missing name" but name exists)

2. **Oversized Frontmatter**
   - Large `structured_output` schemas in frontmatter (100+ lines)
   - YAML parser may have size/complexity limits
   - Frontmatter should be minimal metadata only

3. **Malformed YAML Syntax**
   - Indentation errors in nested structures
   - Missing colons, incorrect spacing
   - Frontmatter not properly delimited with `---`

4. **Required Field Inconsistency**
   - Different agents have different required fields
   - Working agents may have fields that failing agents lack
   - Claude Code parser expectations not fully documented

### Resolution Steps

**Step 1: Add Version Field (Quickest Fix)**
```yaml
---
name: agent-name
description: What this agent does
color: blue
model: sonnet
version: 4.21.0  ← Add this line
---
```

**Why this works:**
- Agents like `adversarial-validator.md` include `version:` and parse successfully
- Missing version field may cause parser to fail early with misleading error
- Adding version is minimal change with high success rate

**Step 2: Verify All Required Fields**
```bash
head -10 .claude/agents/your-agent.md

# Should include:
# name: agent-name (required)
# description: text (required)
# model: opus/sonnet/haiku (recommended)
# version: x.x.x (recommended for complex agents)
# color: blue/green/red/yellow (optional)
```

**Step 3: Validate YAML Syntax**
```bash
# Extract frontmatter (between first two ---)
sed -n '/^---$/,/^---$/p' .claude/agents/your-agent.md | head -n -1 | tail -n +2 > /tmp/frontmatter.yml

# Check for syntax errors
python3 -c "import yaml; yaml.safe_load(open('/tmp/frontmatter.yml'))"

# If error: Fix indentation/syntax issues
```

**Step 4: Simplify Large Frontmatter (If Version Didn't Fix)**
```yaml
# If agent has large structured_output schema (100+ lines)
# Consider moving schema documentation to agent body instead

Before:
---
name: agent
structured_output:
  schema:
    type: object
    properties: ...  ← 100+ lines
---

After:
---
name: agent
version: 4.21.0
---

## Structured Output Format

The agent returns JSON with the following schema:
...schema docs here...
```

**Step 5: Run `/doctor` to Verify Fix**
```bash
# In Claude Code terminal
/doctor

# Look for:
# ✅ Agent Parse Errors: No errors
# (or absence of "Agent Parse Errors" section = success)
```

### Prevention
- **Always include version field** for custom agents with structured output
- **Keep frontmatter minimal** (metadata only, not documentation)
- **Test after creation:** Run `/doctor` immediately after creating new agent
- **Follow working examples:** Copy frontmatter structure from `project-planner.md` or `adversarial-validator.md`

### Real-World Example
```
Problem: initializer.md and coder.md showing parse errors
Symptom: "Missing required 'name' field" but name IS present
Root cause: Missing version: field in frontmatter
Solution: Added version: 4.21.0 to both files
Result: ✅ Parse errors resolved
```

---

## Issue 8: MCP Context Token Warnings in `/doctor`

### Detection Patterns
```
/doctor output shows:
- "Context Usage Warnings"
- "⚠ Large MCP tools context (~35,985 tokens > 25,000)"
- List of MCP servers with token counts
- github: 26 tools (~18,123 tokens)
- filesystem: 14 tools (~9,220 tokens)
```

### Causes
1. **Multiple MCP Servers Enabled**
   - Each MCP server adds tools to context
   - Tools include documentation, schemas, examples
   - Total context can exceed recommended threshold

2. **Large Tool Schemas**
   - Some MCP tools have extensive documentation
   - GitHub MCP: 26 tools with rich schemas
   - Filesystem MCP: 14 tools with detailed parameters

3. **Token Budget Impact**
   - MCP context loaded on every request
   - Reduces available tokens for conversation
   - May impact response quality if context is too large

4. **Not Actually a Problem**
   - Warning threshold is conservative (25,000 tokens)
   - Real issues start around 50,000+ tokens
   - 35,985 tokens is elevated but functional

### Resolution Steps

**Step 1: Assess If Action Needed**
```
Token Count    Status      Action
<25,000       ✅ Optimal    None needed
25,000-40,000 ⚠️  Elevated  Monitor, no immediate action
40,000-50,000 ⚠️  High      Consider optimization
>50,000       🔴 Critical   Immediate optimization
```

**Your case: 35,985 tokens = Elevated but functional**
- System still works normally
- No immediate action required
- Monitor if it grows over time

**Step 2: Identify Unused MCP Servers (If Optimization Needed)**
```bash
# Check which MCP servers you actually use
# Review .claude/settings.json

# Example:
cat .claude/settings.json | grep -A 5 "mcpServers"

# Ask yourself:
# - Do I use GitHub MCP? (if not using GitHub features)
# - Do I use Memory MCP? (if not using knowledge graph)
# - Do I use Sequential-Thinking? (if not doing complex reasoning)
```

**Step 3: Disable Unused MCPs (Optional)**
```json
// .claude/settings.json
{
  "mcpServers": {
    "github": {
      "disabled": true  ← Add this to disable
    },
    "memory": {
      "disabled": false  ← Keep enabled ones
    }
  }
}
```

**Step 4: Use Selective MCP Activation**
```
Instead of: All MCPs enabled globally
Try: Enable MCPs per-project basis

Global settings (~/.claude/settings.json):
- Only essential MCPs (filesystem, IDE)

Project settings (.claude/settings.json):
- Add project-specific MCPs (github for OSS projects)
```

**Step 5: Verify Token Reduction**
```bash
# After disabling MCPs
/doctor

# Check new MCP context size
# Should see reduced token count
```

### Prevention
- **Enable MCPs intentionally:** Don't enable "because it exists"
- **Review quarterly:** Check `/doctor` every 3 months, disable unused MCPs
- **Project-specific MCPs:** Use global for essentials, project for specialized
- **Token budget awareness:** Know your MCP overhead before adding new servers

### When to Worry vs. When to Ignore

**✅ Safe to ignore warning if:**
- Token count 25,000-40,000 (elevated but functional)
- You actively use all enabled MCP servers
- System responds normally
- No performance degradation

**⚠️ Take action if:**
- Token count >50,000 (critical)
- MCPs enabled but never used
- Noticeable slowness in responses
- Context limit errors appearing

**🔴 Immediate action if:**
- Token count >75,000 (severe)
- Context overflow errors
- Responses truncated or incomplete
- "Token limit exceeded" messages

### Real-World Example
```
Scenario: 35,985 tokens from 5 MCP servers
Analysis:
- github: 18,123 tokens (needed for PRs/issues)
- filesystem: 9,220 tokens (essential)
- memory: 5,795 tokens (using knowledge graph)
- sequential-thinking: 1,554 tokens (complex reasoning)
- ide: 1,293 tokens (editor integration)

Decision: Keep all enabled
Rationale: All actively used, 35K is elevated but functional
Action: Monitor, revisit if grows >40K
```

### Optimization Strategy (If Needed)

**Tier 1 Removal (Least Impact):**
- Disable `memory` if not using knowledge graph
- Disable `sequential-thinking` if not doing complex analysis
- Savings: 5,000-7,000 tokens

**Tier 2 Removal (Moderate Impact):**
- Disable `github` if working locally only
- Use `gh` CLI commands via Bash tool instead
- Savings: 18,000 tokens

**Tier 3 Removal (High Impact):**
- Disable `filesystem` MCP, use native Read/Write tools
- Last resort, significant workflow impact
- Savings: 9,000 tokens

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
- **Skills Paradigm:** `docs/01-fundamentals/02_skills-paradigm.md`
- **GitHub Issues:** https://github.com/christianearle01/claude-config-template/issues

---

**Troubleshooting Version:** 4.21.0
**Covers:** 8 common failure modes + TODO discovery + escalation paths + `/doctor` diagnostics
**Maintained By:** claude-config-template project
**Last Updated:** 2025-12-21
