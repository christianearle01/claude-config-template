# Team Templates Example

**How to create and share preference templates with your team.**

---

## Overview

This directory shows how teams can create a shared template catalog that team members can add as a remote source.

---

## Directory Structure

```
team-templates/
├── catalog.json          # Lists all available templates
├── team-standard.json    # Standard team configuration
├── team-security.json    # Security-focused configuration
└── README.md             # This file
```

---

## How It Works

### 1. Create Your Templates

Create template JSON files using the `claude-preferences-export-v1` schema:

```json
{
  "$schema": "claude-preferences-export-v1",
  "exportType": "template",
  "templateMetadata": {
    "id": "your-template-id",
    "name": "Your Template Name",
    "description": "What this template does"
  },
  "contents": {
    "profile": { ... },
    "confidenceThresholds": { ... },
    "skillSpecificPreferences": { ... }
  }
}
```

### 2. Create a Catalog

Create `catalog.json` listing all your templates:

```json
{
  "$schema": "claude-template-catalog-v1",
  "name": "Your Team Templates",
  "templates": [
    {
      "id": "your-template-id",
      "name": "Your Template Name",
      "sourceUrl": "./your-template.json",
      "version": "1.0.0"
    }
  ]
}
```

### 3. Host on GitHub (or any URL)

Push to a git repository. Team members use the raw URL:

```
https://raw.githubusercontent.com/your-org/templates/main/catalog.json
```

### 4. Team Members Add the Source

```
"Add template source https://raw.githubusercontent.com/your-org/templates/main/catalog.json"
```

---

## Using These Example Templates

### Option A: Copy to Your Repo

1. Copy this directory to your team's repository
2. Modify templates to match your team's conventions
3. Update `sourceUrl` in catalog.json to point to your repo
4. Share the catalog URL with your team

### Option B: Use as Reference

Review these files to understand the structure, then create your own templates from scratch.

---

## Template Customization Guide

### What to Customize

| Setting | Recommendation |
|---------|----------------|
| `confidenceThresholds` | Match your team's risk tolerance |
| `preferred-commit-style` | Use your team's commit convention |
| `security-scan-threshold` | Higher for sensitive projects |
| `test-coverage-target` | Match your CI requirements |
| `conventionalCommits` | True if using semantic release |

### What NOT to Customize

- `$schema` - Must be `claude-preferences-export-v1`
- `exportType` - Must be `template`
- `compatibility.minVersion` - Set to earliest supported version

---

## Best Practices

### Template Naming
- Use lowercase with hyphens: `team-standard`, not `TeamStandard`
- Be descriptive: `frontend-react` not just `frontend`

### Versioning
- Use semantic versioning: `1.0.0`, `1.1.0`, `2.0.0`
- Bump major version for breaking changes
- Document changes in template description

### Security
- Only share via HTTPS URLs
- Consider adding checksums for verification
- Review templates before applying

### Documentation
- Include clear descriptions
- Document what each template is for
- Explain when to use which template

---

## Catalog Schema Reference

```json
{
  "$schema": "claude-template-catalog-v1",
  "version": "1.0.0",                    // Catalog version
  "name": "Catalog Name",                // Display name
  "description": "What's in this catalog",
  "maintainer": "team-name",             // Who maintains it
  "lastUpdated": "ISO-8601 date",

  "templates": [
    {
      "id": "unique-id",                 // Unique identifier
      "name": "Display Name",            // Human readable
      "description": "What it does",     // Under 100 chars
      "category": "general|security|...",
      "recommendedFor": ["intermediate"],
      "sourceUrl": "https://...",        // Template JSON URL
      "version": "1.0.0",                // Template version
      "author": "who-made-it",
      "tags": ["searchable", "keywords"]
    }
  ]
}
```

---

## Troubleshooting

### "Template not found"
- Check the `sourceUrl` is correct and accessible
- Ensure URL returns raw JSON (not HTML page)
- For GitHub, use `raw.githubusercontent.com`

### "Version incompatible"
- Check `compatibility.minVersion` in template
- Update claude-config-template if needed

### "Checksum mismatch"
- Template may have been modified
- Re-download or verify source

---

*v4.0.0 - Team Template Sharing*
