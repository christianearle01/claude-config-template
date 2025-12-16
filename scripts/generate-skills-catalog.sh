#!/bin/bash

# Skills Catalog Generator
# Reads .claude/skills-catalog.json and generates .claude/skills/SKILLS_CATALOG.md
# Usage: ./scripts/generate-skills-catalog.sh

set -e

# Paths
JSON_FILE=".claude/skills-catalog.json"
OUTPUT_FILE=".claude/skills/SKILLS_CATALOG.md"

# Check if JSON file exists
if [ ! -f "$JSON_FILE" ]; then
    echo "Error: $JSON_FILE not found!"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Install with: brew install jq"
    exit 1
fi

# Validate JSON syntax
if ! jq empty "$JSON_FILE" 2>/dev/null; then
    echo "Error: Invalid JSON in $JSON_FILE"
    exit 1
fi

echo "Generating Skills Catalog..."

# Extract metadata
TOTAL_SKILLS=$(jq -r '.metadata.total_skills' "$JSON_FILE")
FOUNDATION_COUNT=$(jq -r '.metadata.foundation' "$JSON_FILE")
OPTIMIZATION_COUNT=$(jq -r '.metadata.optimization' "$JSON_FILE")
STRATEGIC_COUNT=$(jq -r '.metadata.strategic' "$JSON_FILE")
LAST_UPDATED=$(jq -r '.last_updated' "$JSON_FILE")

# Start building markdown
cat > "$OUTPUT_FILE" << 'HEADER'
# Skills Catalog: Choose by Experience Level

> **Help choosing skills?** This catalog organizes all 19 skills by experience level to prevent overwhelm.
> Start with Foundation skills, then add Optimization based on your project type.

HEADER

# Add metadata
cat >> "$OUTPUT_FILE" << EOF
**Last Updated:** $LAST_UPDATED | **Total Skills:** $TOTAL_SKILLS

---

EOF

# ============================================================================
# FOUNDATION SKILLS
# ============================================================================

cat >> "$OUTPUT_FILE" << 'FOUNDATION_HEADER'
## 🆕 Foundation Skills (Start Here)

**For:** First-time users, essential for all projects
**Count:** 5 skills
**Time to setup:** 10 minutes
**Token savings:** ~60% (collective)

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
FOUNDATION_HEADER

# Generate foundation skills table
jq -r '.skills.foundation[] | "| **\(.name)** | \(.description) | \(.activation_patterns[0]) | \(.roi) |"' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'FOUNDATION_FOOTER'

**Quick Start:**
```bash
# Enable foundation skills (recommended for all projects)
# Skills auto-activate when you ask relevant questions
```

**Why Foundation skills?**
- High-value, immediate ROI (save tokens/time in first session)
- Low complexity (deterministic, clear inputs/outputs)
- No prerequisites (work standalone)
- Universal applicability (95%+ of projects)

---

FOUNDATION_FOOTER

# ============================================================================
# OPTIMIZATION SKILLS
# ============================================================================

cat >> "$OUTPUT_FILE" << 'OPTIMIZATION_HEADER'
## ⚡ Optimization Skills (Level Up)

**For:** Intermediate users, workflow-specific improvements
**Count:** 8 skills
**Choose:** Based on your project type

### For Projects with Domain Memory (features.json)

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
OPTIMIZATION_HEADER

# Project analyzer (domain memory)
jq -r '.skills.optimization[] | select(.name == "project-analyzer") | "| **\(.name)** | \(.description) | \(.activation_patterns[0]) | \(.roi) |"' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'TDD_HEADER'

### For Test-Driven Development

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
TDD_HEADER

# Testing skills
jq -r '.skills.optimization[] | select(.name == "testing-workflow" or .name == "test-generator") | "| **\(.name)** | \(.description) | \(.activation_patterns[0]) | \(.roi) |"' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'API_HEADER'

### For API Projects

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
API_HEADER

# API skills
jq -r '.skills.optimization[] | select(.name == "api-debugging" or .name == "security-scanner") | "| **\(.name)** | \(.description) | \(.activation_patterns[0]) | \(.roi) |"' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'TEAM_HEADER'

### For Team Projects

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
TEAM_HEADER

# Team skills
jq -r '.skills.optimization[] | select(.name == "standards-enforcer" or .name == "mode-selector") | "| **\(.name)** | \(.description) | \(.activation_patterns[0]) | \(.roi) |"' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'OPTIMIZATION_FOOTER'

**Why Optimization skills?**
- Workflow-specific value (boost productivity in specific contexts)
- Moderate complexity (requires understanding domain patterns)
- Project-type specific (choose based on your needs)
- Clear ROI metrics (measurable token/time savings)

---

OPTIMIZATION_FOOTER

# ============================================================================
# STRATEGIC SKILLS
# ============================================================================

cat >> "$OUTPUT_FILE" << 'STRATEGIC_HEADER'
## 🚀 Strategic Skills (Power Users)

**For:** Advanced users, meta-skills and automation
**Count:** 6 skills
**When:** After mastering foundation & optimization

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
STRATEGIC_HEADER

# Generate strategic skills table
jq -r '.skills.strategic[] | "| **\(.name)** | \(.description) | \(.activation_patterns[0]) | \(.roi) |"' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'STRATEGIC_FOOTER'

**Why Strategic skills?**
- Meta-skills (create/improve other skills)
- Complex orchestration (coordinate multiple tools)
- Personalization and learning (adapt over time)
- Multi-project management and scaffolding

---

STRATEGIC_FOOTER

# ============================================================================
# DECISION TREE
# ============================================================================

cat >> "$OUTPUT_FILE" << 'DECISION_TREE'
## Quick Decision Tree

```
Are you NEW to Claude Code?
├─ YES → Start with Foundation Skills (5 skills, 10 min setup)
└─ NO → Do you have a specific workflow?
    ├─ Domain Memory (features.json) → Add project-analyzer
    ├─ Test-Driven Development → Add testing-workflow + test-generator
    ├─ API Development → Add api-debugging + security-scanner
    ├─ Team Project → Add standards-enforcer + mode-selector
    └─ Want Meta-Skills → Strategic Skills (workflow-analyzer, personalization-engine)
```

---

DECISION_TREE

# ============================================================================
# PROJECT TYPE RECOMMENDATIONS
# ============================================================================

cat >> "$OUTPUT_FILE" << 'PROJECT_TABLE'
## Recommendation by Project Type

| Project Type | Foundation | + Optimization | + Strategic |
|--------------|------------|----------------|-------------|
| **Personal Project** | ✅ All 5 | project-analyzer | workflow-analyzer |
| **Documentation Site** | ✅ All 5 | mermaid-validator, documentation-sync-checker | - |
| **API Backend** | ✅ All 5 | api-debugging, security-scanner | - |
| **Frontend App** | ✅ All 5 | component-finder, testing-workflow | - |
| **Team Codebase** | ✅ All 5 | standards-enforcer, mode-selector | personalization-engine |
| **Template Maintainer** | ✅ All 5 | All optimization | All strategic |

---

PROJECT_TABLE

# ============================================================================
# QUICK START BY USE CASE
# ============================================================================

cat >> "$OUTPUT_FILE" << 'QUICK_START_HEADER'
## Quick Start by Use Case

### First-Time Setup
**Recommended:**
QUICK_START_HEADER

# First-time setup recommendations
jq -r '.quick_start_recommendations.first_time_setup | map("- " + .) | .[]' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'TDD_QUICK_START'

### Test-Driven Development
**Recommended:**
TDD_QUICK_START

jq -r '.quick_start_recommendations.tdd_projects | map("- " + .) | .[]' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'API_QUICK_START'

### API Development
**Recommended:**
API_QUICK_START

jq -r '.quick_start_recommendations.api_projects | map("- " + .) | .[]' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'TEAM_QUICK_START'

### Team Collaboration
**Recommended:**
TEAM_QUICK_START

jq -r '.quick_start_recommendations.team_projects | map("- " + .) | .[]' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'DOC_QUICK_START'

### Documentation Projects
**Recommended:**
DOC_QUICK_START

jq -r '.quick_start_recommendations.documentation_projects | map("- " + .) | .[]' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'TEMPLATE_QUICK_START'

### Template Maintainers
**Recommended:**
TEMPLATE_QUICK_START

jq -r '.quick_start_recommendations.template_maintainers | map("- " + .) | .[]' "$JSON_FILE" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << 'FOOTER'

---

## How to Use Skills

**Skills auto-activate** when you ask relevant questions:
- Just ask naturally: "Is version synced?", "Check my Mermaid diagram", "What's our status?"
- Claude automatically invokes the appropriate skill
- No manual configuration required

**Skill files** are located in `.claude/skills/[skill-name]/SKILL.md`

---

## Success Metrics (Projected)

**After adopting foundation skills:**
- Skill selection time: 10 min → 3 min (70% reduction)
- Setup confidence: Clear recommendations vs overwhelming list
- Token savings: ~60% across version, commit, and documentation tasks

**After adding optimization skills:**
- Workflow-specific efficiency: 50-70% token reduction per use case
- Project-type alignment: Tailored tools for your needs

**After mastering strategic skills:**
- Meta-capabilities: Create your own skills, analyze patterns
- Cross-project efficiency: Multi-project tracking and automation

---

## FAQ

**Q: Do I need all 19 skills?**
A: No! Start with 5 foundation skills, then add optimization based on your project type.

**Q: Can I skip foundation and go straight to strategic?**
A: Foundation skills provide immediate value and are prerequisites for understanding advanced patterns.

**Q: How do skills activate?**
A: Automatically! Just ask questions naturally, and Claude invokes the right skill.

**Q: What if I'm not sure which optimization skills I need?**
A: Check the project type table above, or start with project-analyzer (works for all domain memory projects).

**Q: Can I create my own skills?**
A: Yes! Use the skill-template-generator (strategic level) to scaffold new skills.

---

**Generated from:** `.claude/skills-catalog.json`
**Generator script:** `scripts/generate-skills-catalog.sh`
**Manual edits:** This file is auto-generated. Edit the JSON catalog, then re-run the generator.

FOOTER

echo "✅ Skills catalog generated: $OUTPUT_FILE"
echo "📊 Total skills: $TOTAL_SKILLS (Foundation: $FOUNDATION_COUNT, Optimization: $OPTIMIZATION_COUNT, Strategic: $STRATEGIC_COUNT)"
