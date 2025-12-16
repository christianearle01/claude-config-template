# Template Application Guide

**Version:** 4.5.0
**Script:** `scripts/apply-template.sh`
**Purpose:** Apply Claude preferences templates with inheritance resolution and parameter substitution

---

## What It Does

The Template Application script (`apply-template.sh`) applies preference templates to your Claude Code project, automatically resolving template inheritance chains and substituting parameters.

**Key capabilities:**
- **Finds templates** by ID (e.g., `gallery-frontend-react`) or file path
- **Resolves inheritance** chains (e.g., gallery-frontend-react → team-standard)
- **Substitutes parameters** like `${frontendFramework}` with actual values
- **Shows preview** with diff before applying changes
- **Creates backups** of existing settings

This completes the template lifecycle: Create → Validate → Apply.

---

## When to Use

- **Setting up new projects:** Apply team-standard template to new projects
- **Adopting team configurations:** Use shared templates from your team's catalog
- **Switching domains:** Apply domain-specific templates (frontend, backend, data-science)
- **Testing gallery templates:** Try out pre-built configurations from v4.3.0 gallery
- **Onboarding:** New team members can apply standard configs in seconds

---

## Installation

**Script Location:** `scripts/apply-template.sh`

**Dependencies:**
- **Required:** bash 4.0+
- **Optional:** jq (improves performance, auto-falls back to python3)
- **Fallback:** python3 (used if jq not available)

No installation needed - script is executable and ready to use.

---

## Usage

### Basic Usage

```bash
# Find template by ID
./scripts/apply-template.sh template-name

# Use full file path
./scripts/apply-template.sh path/to/template.json

# Show help
./scripts/apply-template.sh --help
```

### Simple Template (No Parameters)

```bash
./scripts/apply-template.sh team-standard
```

**What happens:**
1. Finds team-standard.json in examples/team-templates/
2. Validates JSON syntax and schema
3. Shows preview of settings to apply
4. Asks: "Apply these changes? (y/n)"
5. Creates backup → applies template

### Template with Inheritance

```bash
./scripts/apply-template.sh gallery-frontend-react
```

**What happens:**
1. Finds gallery-frontend-react.json
2. Detects `extends: team-standard`
3. Recursively resolves parent (team-standard)
4. Deep merges parent + child settings
5. Shows combined preview → confirms → applies

### Parameterized Template (CLI Arguments)

```bash
./scripts/apply-template.sh gallery-fullstack \
    --param frontendFramework=react \
    --param backendFramework=fastapi \
    --param database=postgresql \
    --param testCoverage=90 \
    --param useTypeScript=true
```

**What happens:**
1. Finds gallery-fullstack.json
2. Discovers all `${varName}` references
3. Substitutes with CLI-provided values
4. Shows resolved preview → confirms → applies

### Interactive Mode (Prompts for Parameters)

```bash
./scripts/apply-template.sh gallery-fullstack
```

**What happens:**
1. Finds template with parameters
2. Prompts for each parameter:
   ```
   frontendFramework - Frontend framework (react, vue, svelte, angular) (required)
   Value: _
   ```
3. Uses defaults if you press Enter without value
4. Shows resolved preview → confirms → applies

---

## How It Works

### Inheritance Resolution

Templates can extend other templates using the `extends` field:

```json
{
  "templateMetadata": {
    "id": "gallery-frontend-react",
    "extends": "team-standard"
  }
}
```

**Resolution process:**
1. Read child template (gallery-frontend-react)
2. Find parent template (team-standard)
3. Recursively resolve parent's inheritance
4. Deep merge parent.contents with child.contents
5. Child overrides parent for conflicting keys

**Example chain:**
```
gallery-frontend-react (child)
  extends team-standard (parent)
    = merged result
```

**Safety features:**
- **Cycle detection:** Prevents A→B→A loops
- **Max depth:** 5 levels maximum
- **Error handling:** Clear messages if parent not found

### Parameter Substitution

Templates can include placeholders that get replaced:

**Syntax:**
- `${varName}` - Simple variable
- `${varName:default}` - Variable with inline default

**Parameter discovery:**
The script scans the resolved template for all `${...}` references and collects them.

**Parameter collection:**
1. Check CLI args first (`--param key=value`)
2. If not in CLI, prompt interactively
3. If no value and has default, use default
4. If required and missing, error

**Example:**
```json
{
  "profile": {
    "primaryFrameworks": ["${frontendFramework}", "${backendFramework}"]
  }
}
```

After substitution with `--param frontendFramework=react --param backendFramework=fastapi`:
```json
{
  "profile": {
    "primaryFrameworks": ["react", "fastapi"]
  }
}
```

---

## Preview & Confirmation Workflow

**Step 1: Preview Generation**
- Script writes resolved template to `.claude/settings.preview.json`
- Extracts only the `contents` field (not metadata)

**Step 2: Diff Display**
```
Changes to be applied:
--- .claude/settings.json
+++ .claude/settings.preview.json
@@ -1,5 +1,10 @@
-  "model": "sonnet"
+  "profile": {
+    "primaryFrameworks": ["react", "nextjs"]
+  }

+45 additions, -12 deletions
```

**Step 3: User Confirmation**
```
────────────────────────────────────────
Apply these changes? (y/n): _
```

**Step 4: Backup & Apply**
- If yes: Creates `.claude/settings.json.backup`
- Moves preview to `.claude/settings.json`
- Success message

- If no: Keeps preview file for review

**Step 5: Preview saved to `.claude/settings.preview.json`**

---

## Practical Examples

### Example 1: Team Onboarding

**Scenario:** New developer joins team, needs standard config

```bash
cd my-new-project
./scripts/apply-template.sh team-standard
```

**Result:** Team's standard preferences applied in 10 seconds.

### Example 2: Frontend Project Setup

**Scenario:** Starting React + TypeScript project

```bash
./scripts/apply-template.sh gallery-frontend-react
```

**Result:**
- Inherits team-standard base settings
- Adds React/TypeScript/Tailwind specific preferences
- Configures component-finder and test-generator skills

### Example 3: Full-Stack with Custom Stack

**Scenario:** Full-stack project with Vue + Django

```bash
./scripts/apply-template.sh gallery-fullstack \
    --param frontendFramework=vue \
    --param backendFramework=django \
    --param database=postgresql \
    --param testCoverage=85 \
    --param useTypeScript=false
```

**Result:** Customized full-stack configuration matching your stack.

### Example 4: Interactive Exploration

**Scenario:** Want to try different parameters interactively

```bash
./scripts/apply-template.sh gallery-fullstack
# Script prompts for each parameter
# Try different values, see preview
# Say 'n' to not apply if you want to experiment
```

---

## Troubleshooting

### Template Not Found

**Error:**
```
❌ Template not found: my-template
```

**Cause:** Template ID doesn't exist or file path is wrong

**Fix:**
```bash
# List available templates
ls examples/team-templates/*.json | xargs -n1 basename | sed 's/\.json$//'

# Or check catalog
cat examples/team-templates/catalog.json | jq '.templates[].id'

# Use correct ID or full path
./scripts/apply-template.sh team-standard
./scripts/apply-template.sh ./path/to/template.json
```

### Invalid JSON Syntax

**Error:**
```
❌ Invalid JSON syntax
```

**Cause:** Template JSON is malformed

**Fix:**
```bash
# Validate template first
./scripts/validate-template.sh my-template.json

# Fix JSON errors shown in validation output
```

### Circular Inheritance Detected

**Error:**
```
❌ Circular inheritance detected: template-a → template-b → template-a
```

**Cause:** Template inheritance chain loops back on itself

**Fix:** Remove the circular `extends` reference. Each template should only extend one parent, and the chain should end at a base template.

### Max Inheritance Depth Exceeded

**Error:**
```
❌ Max inheritance depth exceeded (5 levels)
```

**Cause:** Inheritance chain is deeper than 5 levels

**Fix:** Flatten your inheritance hierarchy. 5 levels should be sufficient for most use cases.

### Missing Required Parameter

**Error:**
```
❌ Missing required parameter: frontendFramework
```

**Cause:** Template requires a parameter but you didn't provide it

**Fix:**
```bash
# Provide via CLI
./scripts/apply-template.sh gallery-fullstack --param frontendFramework=react

# Or run without --param to get interactive prompts
./scripts/apply-template.sh gallery-fullstack
```

### Parent Template Not Found

**Error:**
```
❌ Parent template not found: team-standard
```

**Cause:** Template extends a parent that doesn't exist

**Fix:** Ensure the parent template exists in one of the search directories:
- `examples/team-templates/`
- `examples/preference-templates/`
- `templates/`

---

## Best Practices

1. **Validate before applying:**
   ```bash
   ./scripts/validate-template.sh my-template.json
   ./scripts/apply-template.sh my-template
   ```

2. **Review the preview carefully:** Check the diff to understand what will change

3. **Keep backups:** The script creates `.claude/settings.json.backup` automatically

4. **Test with gallery templates:** Try gallery templates first to understand capabilities

5. **Use interactive mode for exploration:** Run without `--param` to see all parameters and their descriptions

6. **Create team templates:** Extend base templates for your team's specific needs

7. **Version your templates:** Use git to version control your template files

---

## Template Search Locations

The script searches for templates in this order:

1. **Direct file path** (if argument is an existing file)
2. `examples/team-templates/{id}.json`
3. `examples/preference-templates/{id}.json`
4. `templates/{id}.json`

**Example:**
```bash
# These all work:
./scripts/apply-template.sh team-standard                    # Search by ID
./scripts/apply-template.sh examples/team-templates/team-standard.json  # Full path
./scripts/apply-template.sh ./my-custom-template.json       # Relative path
```

---

## Related Documentation

- **Template Gallery:** Browse available templates → [Template Gallery Guide](../02-optimization/TEMPLATE_GALLERY_GUIDE.md)
- **Template Validator:** Validate templates before applying → [Template Validator Guide](TEMPLATE_VALIDATOR_GUIDE.md)
- **Template Inheritance (v4.1.0):** Understanding `extends` → Search "Template Inheritance" in QUICK_REFERENCE
- **Template Parameters (v4.2.0):** Understanding parameterization → Search "Template Parameters" in QUICK_REFERENCE
- **Import/Export (v4.0.0):** Template system foundation → Search "Import Export" in QUICK_REFERENCE

---

## Navigation

- **Previous:** [Template Gallery Guide](../02-optimization/TEMPLATE_GALLERY_GUIDE.md)
- **Next:** [Update Guide](UPDATE_GUIDE.md)
- **Up:** [Documentation Hub](../README.md)
