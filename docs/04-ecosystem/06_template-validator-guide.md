# Template Validator Guide

**Version:** 4.4.0
**Script:** `scripts/validate-template.sh`
**Purpose:** Validate Claude preferences export template JSON files against schema

---

## What It Does

The Template Validator script (`validate-template.sh`) validates template JSON files to ensure they conform to the Claude preferences export schema. It performs three levels of validation:

1. **Critical (Errors):** Required fields and proper schema compliance
2. **Important (Warnings):** Recommended fields and best practices
3. **Info:** Optional enhancements and features

This ensures templates are valid before sharing them with teams or publishing to catalogs.

---

## When to Use

- **Before sharing templates:** Validate templates before committing to version control
- **CI/CD validation:** Integrate into automated testing workflows
- **Troubleshooting:** Debug template JSON structure issues
- **Catalog maintenance:** Verify all templates in a catalog are valid
- **After manual edits:** Quick check after modifying template JSON

---

## Installation

**Script Location:** `scripts/validate-template.sh`

**Dependencies:**
- **Required:** bash 4.0+
- **Optional:** jq (improves performance)
  - Install: `brew install jq` (macOS) or `apt install jq` (Linux)
- **Fallback:** python3 (used if jq not available)

No installation needed - the script works out of the box with bash and python3.

---

## Usage

### Basic Usage

```bash
# Validate single template
./scripts/validate-template.sh examples/team-templates/gallery-frontend-react.json

# Validate all templates in directory
./scripts/validate-template.sh examples/team-templates/

# Validate catalog file
./scripts/validate-template.sh --catalog examples/team-templates/catalog.json

# Show help
./scripts/validate-template.sh --help
```

### Practical Examples

**Example 1: Validate before git commit**
```bash
# Validate all templates before committing
./scripts/validate-template.sh examples/team-templates/
if [ $? -eq 0 ]; then
  git add examples/team-templates/
  git commit -m "Add new templates"
fi
```

**Example 2: CI/CD integration**
```bash
# In your CI pipeline (e.g., GitHub Actions)
- name: Validate templates
  run: ./scripts/validate-template.sh examples/team-templates/
```

**Example 3: Find broken templates**
```bash
# Validate each template individually to find problematic ones
for file in examples/team-templates/*.json; do
  echo "Checking: $file"
  ./scripts/validate-template.sh "$file" || echo "FAILED: $file"
done
```

---

## Validation Levels

### Level 1: Critical (Errors)

These **must** pass for templates to be valid:

| Check | Required Value | Description |
|-------|----------------|-------------|
| JSON syntax | Valid JSON | Parses without errors |
| `$schema` | `claude-preferences-export-v1` | Correct schema version |
| `exportType` | `template` | Must be a template export |
| `templateMetadata.id` | String (lowercase, hyphens) | Unique template identifier |
| `templateMetadata.name` | String | Human-readable template name |
| `compatibility.minVersion` | Semver string | Minimum Claude Code version |

**If any Critical check fails, the template is REJECTED.**

### Level 2: Important (Warnings)

These **should** pass for best practices:

| Check | Expected Value | Description |
|-------|----------------|-------------|
| `templateMetadata.description` | String (≤100 chars) | Brief description for catalog |
| `templateMetadata.category` | Valid enum | See valid categories below |
| `templateMetadata.version` | Semver (x.y.z) | Template version |
| `contents` | Non-empty object | Actual preferences content |
| `metadata.checksum` | String | Checksum for integrity |

**Valid categories:** `frontend`, `backend`, `fullstack`, `data-science`, `devops`, `mobile`, `security`, `team`

**Warnings allow the template to pass but indicate improvements needed.**

### Level 3: Info (Optional)

These provide additional information:

| Check | Purpose |
|-------|---------|
| `templateMetadata.extends` | Shows inheritance enabled |
| `templateMetadata.parameters` | Shows parameterization |
| `templateMetadata.recommendedFor` | Experience level targeting |

**Info checks don't affect validation result.**

---

## Sample Output

### Successful Validation

```
════════════════════════════════════════════════════════════
  Claude Template Validator v1.0.0
════════════════════════════════════════════════════════════

🔍 Validating: gallery-frontend-react.json

  ✅ JSON syntax valid
  ✅ Schema: claude-preferences-export-v1
  ✅ Export type: template
  ✅ Template ID: gallery-frontend-react
  ✅ Template name: Frontend React
  ✅ Min version: 4.3.0
  ✅ Description present (50 chars)
  ✅ Category: frontend
  ✅ Version: 1.0.0 (semver)
  ✅ Contents object present
  ✅ Checksum: gallery-frontend-react-v1
  ℹ️  Extends: team-standard (inheritance enabled)
  ℹ️  Recommended for: ["intermediate", "advanced"]

────────────────────────────────────────
Result: PASSED
```

### Failed Validation

```
🔍 Validating: broken-template.json

  ❌ Invalid JSON syntax

────────────────────────────────────────
Result: FAILED (JSON parse error)
```

### Validation with Warnings

```
🔍 Validating: incomplete-template.json

  ✅ JSON syntax valid
  ✅ Schema: claude-preferences-export-v1
  ✅ Export type: template
  ✅ Template ID: incomplete-template
  ✅ Template name: Incomplete Template
  ✅ Min version: 4.0.0
  ⚠️  Missing: templateMetadata.description
  ⚠️  Unknown category: 'custom' (valid: frontend backend fullstack...)
  ⚠️  Missing: templateMetadata.version
  ✅ Contents object present
  ⚠️  Missing: metadata.checksum

────────────────────────────────────────
Result: PASSED (4 warnings)
```

### Directory Validation Summary

```
════════════════════════════════════════════════════════════
  Summary
════════════════════════════════════════════════════════════

  Templates validated: 9
  Passed: 9
  Failed: 0
```

---

## Catalog Validation

Use the `--catalog` flag to validate catalog.json files:

```bash
./scripts/validate-template.sh --catalog examples/team-templates/catalog.json
```

**Catalog-specific checks:**
- Schema must be `claude-template-catalog-v1`
- Required fields: `name`, `templates` array
- Duplicate ID detection
- Template count verification (`metadata.totalTemplates` matches actual count)

**Sample output:**
```
🔍 Validating Catalog: catalog.json

  ✅ JSON syntax valid
  ✅ Schema: claude-template-catalog-v1
  ✅ Catalog name: Example Team Templates
  ✅ Total templates: 9
  ✅ Templates array has 9 entries
  ✅ All template IDs are unique

────────────────────────────────────────
Result: PASSED
```

---

## Troubleshooting

### Common Validation Failures

#### 1. JSON Parse Error

**Error:**
```
❌ Invalid JSON syntax
Result: FAILED (JSON parse error)
```

**Causes:**
- Missing comma between fields
- Trailing comma after last field
- Unclosed brackets/braces
- Unescaped quotes in strings

**Fix:** Use a JSON validator or IDE with JSON linting.

#### 2. Missing Required Field

**Error:**
```
❌ Missing required: templateMetadata.id
```

**Fix:** Add the missing field to your template:
```json
{
  "$schema": "claude-preferences-export-v1",
  "exportType": "template",
  "templateMetadata": {
    "id": "my-template",  // ← Add this
    "name": "My Template"
  }
}
```

#### 3. Invalid Schema

**Error:**
```
❌ Schema must be 'claude-preferences-export-v1' (got: 'claude-template-v1')
```

**Fix:** Update the `$schema` field:
```json
{
  "$schema": "claude-preferences-export-v1"  // ← Correct value
}
```

#### 4. Invalid Template ID Format

**Error:**
```
❌ Template ID must be lowercase with hyphens only (got: 'MyTemplate_v1')
```

**Fix:** Use only lowercase letters, numbers, and hyphens:
```json
{
  "templateMetadata": {
    "id": "my-template-v1"  // ← Valid format
  }
}
```

#### 5. Unknown Category

**Warning:**
```
⚠️  Unknown category: 'custom' (valid: frontend backend fullstack...)
```

**Fix:** Use one of the valid categories:
- `frontend`, `backend`, `fullstack`
- `data-science`, `devops`, `mobile`
- `security`, `team`

```json
{
  "templateMetadata": {
    "category": "frontend"  // ← Valid category
  }
}
```

---

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All validations passed |
| 1 | One or more validations failed (errors present) |

**Note:** Warnings don't cause exit code 1. Templates pass with warnings.

---

## Integration Examples

### Pre-commit Hook

Create `.git/hooks/pre-commit`:

```bash
#!/bin/bash

echo "Validating templates..."
./scripts/validate-template.sh examples/team-templates/

if [ $? -ne 0 ]; then
  echo "Template validation failed. Fix errors before committing."
  exit 1
fi

echo "Template validation passed!"
```

### GitHub Actions

```yaml
name: Validate Templates

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Validate templates
        run: ./scripts/validate-template.sh examples/team-templates/
```

### Make Target

```makefile
.PHONY: validate-templates
validate-templates:
	@./scripts/validate-template.sh examples/team-templates/
```

---

## Related Documentation

- **Template Gallery:** See which templates are available → [Template Gallery Guide](../02-optimization/TEMPLATE_GALLERY_GUIDE.md)
- **Template Inheritance:** Understanding `extends` field → Search "Template Inheritance" in QUICK_REFERENCE
- **Template Parameters:** Understanding parameterization → Search "Template Parameters" in QUICK_REFERENCE
- **Creating Templates:** How to create your own templates → Search "Preference Templates" in QUICK_REFERENCE

---

## Navigation

- **Previous:** [Third-Party MCPs Guide](../03-advanced/THIRD_PARTY_MCPS.md)
- **Next:** [Plugins Guide](../03-advanced/PLUGINS_GUIDE.md)
- **Up:** [Documentation Hub](../README.md)
