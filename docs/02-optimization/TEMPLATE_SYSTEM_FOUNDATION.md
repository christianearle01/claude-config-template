# Template System Foundation

**Version:** 4.0.0 - 4.2.0
**Location:** Built-in system + `examples/team-templates/`
**Purpose:** Complete guide to Claude Code's template system from basics to advanced features

---

## What Is the Template System?

The Template System allows you to **export, share, and import Claude Code preference configurations** as reusable templates. Instead of manually configuring settings for each project, you can apply battle-tested configurations instantly.

### The Problem It Solves

**Without templates:**
- Manual settings configuration for every new project (20-30 minutes each)
- Inconsistent configurations across team members
- Lost best practices when switching between projects
- No way to share successful configurations

**With templates:**
- Apply proven configurations in seconds
- Consistent team standards across all projects
- Easy switching between project types (frontend → backend → data science)
- Share and discover configurations via git or URLs

### Evolution Timeline

```
v4.0.0 (Import/Export)    Foundation: Create and share templates
         ↓
v4.1.0 (Inheritance)      Composition: Build templates from base configs
         ↓
v4.2.0 (Parameters)       Customization: Dynamic templates with variables
         ↓
v4.3.0 (Gallery)          Discovery: Curated collection of 9 templates
         ↓
v4.4.0 (Validator)        Quality: Automated validation before use
         ↓
v4.5.0 (Application)      Automation: One-command template application
```

This guide covers the foundation (v4.0-v4.2). For advanced features, see [Template Gallery Guide](TEMPLATE_GALLERY_GUIDE.md), [Template Validator Guide](../04-ecosystem/TEMPLATE_VALIDATOR_GUIDE.md), and [Template Application Guide](../04-ecosystem/APPLY_TEMPLATE_GUIDE.md).

---

## Part 1: Import/Export Foundation (v4.0.0)

### What Are Preference Templates?

A **preference template** is a JSON snapshot of your Claude Code settings that can be:
- Exported from your current configuration
- Shared via git repositories or URLs
- Imported into other projects
- Applied with automated tools

**Key concept:** Templates are *shareable configurations*, not just backups.

### Template vs Settings: What's the Difference?

| Feature | Settings (`.claude/settings.json`) | Template (`*.json`) |
|---------|----------------------------------|---------------------|
| Purpose | Active configuration for current project | Shareable blueprint |
| Location | `.claude/` directory | `examples/team-templates/` or remote URL |
| Schema | Internal format | `claude-preferences-export-v1` (portable) |
| Metadata | Minimal | Rich (author, version, description, compatibility) |
| Sharing | Not designed for it | Designed for git/URL distribution |

### Creating Your First Template

**Step 1: Configure your settings**

Start with a working `.claude/settings.json`:
```json
{
  "model": "sonnet",
  "profile": {
    "experienceLevel": "intermediate"
  },
  "confidenceThresholds": {
    "autoApply": 95,
    "suggestProminently": 75
  }
}
```

**Step 2: Wrap as exportable template**

Add template structure:
```json
{
  "$schema": "claude-preferences-export-v1",
  "exportVersion": "1.0.0",
  "exportedAt": "2025-12-16T00:00:00Z",
  "exportedBy": "your-team",
  "sourceVersion": "4.0.0",

  "exportType": "template",

  "templateMetadata": {
    "id": "my-first-template",
    "name": "My First Template",
    "description": "Simple template for team onboarding",
    "category": "team",
    "version": "1.0.0",
    "author": "your-team"
  },

  "compatibility": {
    "minVersion": "3.8.0",
    "maxVersion": "4.0.0"
  },

  "contents": {
    "model": "sonnet",
    "profile": {
      "experienceLevel": "intermediate"
    },
    "confidenceThresholds": {
      "autoApply": 95,
      "suggestProminently": 75
    }
  },

  "metadata": {
    "checksum": "my-first-template-v1",
    "exportOptions": {
      "includeAnalytics": false,
      "includeLearningHistory": false
    }
  }
}
```

**Step 3: Save and share**

Save as `my-first-template.json` in a git repository or shared location.

### Template Structure Explained

#### Required Fields

**1. Schema Declaration**
```json
"$schema": "claude-preferences-export-v1"
```
Identifies this as a v1 template (required for validation).

**2. Export Metadata**
```json
"exportVersion": "1.0.0",
"exportedAt": "2025-12-16T00:00:00Z",
"exportedBy": "your-team",
"sourceVersion": "4.0.0"
```
Tracks when and by whom the template was created.

**3. Template Metadata**
```json
"templateMetadata": {
  "id": "unique-identifier",           // Used for references and inheritance
  "name": "Human-Readable Name",       // Displayed in UIs
  "description": "What this template does",
  "category": "team|frontend|backend|security|...",
  "version": "1.0.0",
  "author": "your-team"
}
```

**4. Contents (The Actual Settings)**
```json
"contents": {
  // Your actual Claude Code settings go here
  "model": "sonnet",
  "profile": { ... },
  "confidenceThresholds": { ... }
}
```

#### Optional Fields

**Compatibility Constraints**
```json
"compatibility": {
  "minVersion": "3.8.0",    // Won't work below this
  "maxVersion": "4.0.0"     // null = no upper limit
}
```

**Metadata**
```json
"metadata": {
  "checksum": "template-checksum",     // Verification hash
  "exportOptions": {
    "includeAnalytics": false,         // Exclude usage data
    "includeLearningHistory": false    // Exclude learned patterns
  }
}
```

### Applying Templates

#### Manual Method (Understanding the Process)

1. **Backup current settings:**
   ```bash
   cp .claude/settings.json .claude/settings.json.backup
   ```

2. **Extract contents from template:**
   ```bash
   cat my-first-template.json | jq '.contents' > .claude/settings.json
   ```

3. **Verify it works:**
   ```bash
   # Test Claude Code with new settings
   ```

#### Automated Method (Recommended)

Use the `apply-template.sh` script (v4.5.0):
```bash
./scripts/apply-template.sh my-first-template
```

The script handles:
- Finding the template by ID
- Extracting contents
- Showing preview diff
- Creating backup
- Applying changes

See [Template Application Guide](../04-ecosystem/APPLY_TEMPLATE_GUIDE.md) for details.

### Merge Strategies

When applying a template to existing settings:

**1. Replace (default):** Overwrite entire settings with template contents
```bash
./scripts/apply-template.sh template-name
```

**2. Merge:** Keep existing settings, add new ones from template
- Requires manual JSON merging
- Useful for additive changes

**3. Selective:** Cherry-pick specific sections
- Manual extraction with `jq`:
  ```bash
  cat template.json | jq '.contents.profile' > profile.json
  ```

### Backup & Rollback

**Automatic backups:**
```bash
# apply-template.sh creates this automatically
.claude/settings.json.backup
```

**Manual rollback:**
```bash
mv .claude/settings.json.backup .claude/settings.json
```

**Version control:**
```bash
# Commit before applying templates
git add .claude/settings.json
git commit -m "chore: Backup settings before template application"

# Rollback with git
git checkout HEAD~1 .claude/settings.json
```

### Use Cases for Import/Export

**1. Team Onboarding**
```bash
# New team member's first day
./scripts/apply-template.sh team-standard
```
Result: 30 minutes → 30 seconds setup time

**2. Switching Project Types**
```bash
# Working on frontend today
./scripts/apply-template.sh gallery-frontend-react

# Switching to backend tomorrow
./scripts/apply-template.sh gallery-backend-api
```

**3. Sharing Best Practices**
```bash
# Share your winning configuration
git add examples/my-team-template.json
git commit -m "feat: Add team template for ML projects"
git push origin main
```

**4. Configuration Experiments**
```bash
# Try a new configuration without losing current one
cp .claude/settings.json .claude/settings-original.json
./scripts/apply-template.sh experimental-config
# Test it out...
# Rollback if needed
mv .claude/settings-original.json .claude/settings.json
```

---

## Part 2: Template Inheritance (v4.1.0)

### The Problem: Template Duplication

**Scenario:** Your team has multiple project types, but they share 80% of configuration.

Without inheritance:
```
team-frontend.json     → 250 lines (80% duplicate)
team-backend.json      → 250 lines (80% duplicate)
team-data-science.json → 250 lines (80% duplicate)
```

With inheritance:
```
team-standard.json     → 200 lines (base)
team-frontend.json     → 50 lines (extends team-standard)
team-backend.json      → 50 lines (extends team-standard)
team-data-science.json → 50 lines (extends team-standard)
```

**Benefits:**
- **DRY principle:** Define once, reuse everywhere
- **Easier updates:** Change base template, all children inherit
- **Clear structure:** Explicit parent-child relationships

### How Inheritance Works

Add an `extends` field to your template metadata:

**Parent template (`team-standard.json`):**
```json
{
  "$schema": "claude-preferences-export-v1",
  "exportType": "template",
  "templateMetadata": {
    "id": "team-standard",
    "name": "Team Standard",
    "description": "Base configuration for all team projects"
  },
  "contents": {
    "profile": {
      "experienceLevel": "intermediate",
      "proactivityLevel": "medium"
    },
    "confidenceThresholds": {
      "autoApply": 95,
      "suggestProminently": 75
    },
    "learnedPreferences": {
      "workflow": {
        "preferred-commit-style": "conventional"
      }
    }
  }
}
```

**Child template (`team-frontend.json`):**
```json
{
  "$schema": "claude-preferences-export-v1",
  "exportType": "template",
  "templateMetadata": {
    "id": "team-frontend",
    "name": "Team Frontend",
    "description": "Frontend configuration extending team-standard",
    "extends": "team-standard"     // ← This enables inheritance
  },
  "contents": {
    "profile": {
      "primaryLanguages": ["typescript", "javascript"],
      "primaryFrameworks": ["react", "nextjs"]
    },
    "skillSpecificPreferences": {
      "component-finder": {
        "frameworkHints": ["react", "jsx"]
      }
    }
  }
}
```

**Resolved result (what you actually get):**
```json
{
  "profile": {
    "experienceLevel": "intermediate",         // From parent
    "proactivityLevel": "medium",              // From parent
    "primaryLanguages": ["typescript", "javascript"],  // From child
    "primaryFrameworks": ["react", "nextjs"]   // From child
  },
  "confidenceThresholds": {                    // From parent
    "autoApply": 95,
    "suggestProminently": 75
  },
  "learnedPreferences": {                      // From parent
    "workflow": {
      "preferred-commit-style": "conventional"
    }
  },
  "skillSpecificPreferences": {                // From child
    "component-finder": {
      "frameworkHints": ["react", "jsx"]
    }
  }
}
```

### Inheritance Resolution Algorithm

**The deep merge process:**

1. **Load parent template**
   - Find parent by ID (searches `examples/team-templates/`, etc.)
   - If parent also has `extends`, resolve recursively (max depth: 5)

2. **Extract contents**
   - Parent: `parent.contents`
   - Child: `child.contents`

3. **Deep merge**
   - Start with parent contents
   - Overlay child contents
   - **Child overrides parent** for conflicting keys

4. **Return merged result**

**Rules:**
- **Objects merge recursively:** Nested objects combine
- **Arrays replace:** Child array replaces parent array (no concatenation)
- **Primitives replace:** Child value overwrites parent value
- **Max depth: 5 levels** to prevent excessive nesting
- **Cycle detection:** Prevents A→B→A loops

### Inheritance Chain Example

**Real-world example from the gallery:**

```
gallery-frontend-react (child)
  └─ extends team-standard (parent)
```

**Before merge:**

**team-standard.json contents:**
```json
{
  "profile": {
    "experienceLevel": "intermediate",
    "proactivityLevel": "medium",
    "preferredWorkflow": "wizard"
  },
  "confidenceThresholds": {
    "autoApply": 95,
    "suggestProminently": 75,
    "showAsOptional": 50
  },
  "learnedPreferences": {
    "workflow": {
      "preferred-commit-style": "conventional",
      "preferred-branch-naming": "feature/"
    },
    "quality": {
      "security-scan-threshold": "high",
      "test-coverage-target": 80
    }
  }
}
```

**gallery-frontend-react.json contents (only differences):**
```json
{
  "profile": {
    "primaryLanguages": ["typescript", "javascript"],
    "primaryFrameworks": ["react", "nextjs", "tailwind"]
  },
  "learnedPreferences": {
    "workflow": {
      "component-driven": true,
      "hot-reload": true
    },
    "quality": {
      "accessibility-checks": true,
      "responsive-design": true
    }
  },
  "skillSpecificPreferences": {
    "component-finder": {
      "frameworkHints": ["react", "jsx", "tsx"]
    }
  }
}
```

**After merge (resolved result):**
```json
{
  "profile": {
    "experienceLevel": "intermediate",         // from parent
    "proactivityLevel": "medium",              // from parent
    "preferredWorkflow": "wizard",             // from parent
    "primaryLanguages": ["typescript", "javascript"],  // from child
    "primaryFrameworks": ["react", "nextjs", "tailwind"]  // from child
  },
  "confidenceThresholds": {                    // from parent (child didn't override)
    "autoApply": 95,
    "suggestProminently": 75,
    "showAsOptional": 50
  },
  "learnedPreferences": {
    "workflow": {
      "preferred-commit-style": "conventional",  // from parent
      "preferred-branch-naming": "feature/",     // from parent
      "component-driven": true,                  // from child
      "hot-reload": true                         // from child
    },
    "quality": {
      "security-scan-threshold": "high",         // from parent
      "test-coverage-target": 80,                // from parent
      "accessibility-checks": true,              // from child
      "responsive-design": true                  // from child
    }
  },
  "skillSpecificPreferences": {                // from child (new key)
    "component-finder": {
      "frameworkHints": ["react", "jsx", "tsx"]
    }
  }
}
```

**Notice:**
- Objects merged recursively (`learnedPreferences.workflow` combines both)
- Child adds new keys without removing parent keys
- Parent provides defaults, child specializes

### Creating Inheritance Hierarchies

**Best practices for template organization:**

**1. Base Templates** (Foundation Layer)
```
team-standard.json       → General team configuration
team-security.json       → Security-focused base
```

**2. Domain Templates** (Specialization Layer)
```
team-frontend.json       → extends team-standard
team-backend.json        → extends team-standard
team-data-science.json   → extends team-security (for sensitive data)
```

**3. Project Templates** (Implementation Layer)
```
project-ecommerce.json   → extends team-frontend
project-api-gateway.json → extends team-backend
```

**Hierarchy visualization:**
```
team-standard
  ├── team-frontend
  │     ├── project-ecommerce
  │     └── project-dashboard
  ├── team-backend
  │     └── project-api-gateway
  └── team-data-science

team-security
  └── team-data-science (for sensitive ML projects)
```

**Design principles:**
- **Keep base templates stable:** Changes affect all children
- **Use 2-3 levels max:** Deeper = harder to reason about
- **Document inheritance:** Add `_extendsHint` in metadata
- **Test inheritance chains:** Apply and verify merged result

### Troubleshooting Inheritance

#### Error: Circular inheritance detected

**Symptom:**
```
❌ Circular inheritance detected: template-a → template-b → template-a
```

**Cause:** Template A extends B, B extends A (infinite loop)

**Fix:** Break the cycle:
```json
// Remove one of the extends references
{
  "templateMetadata": {
    "id": "template-b",
    "extends": "template-a"  // ← Remove this
  }
}
```

#### Error: Parent template not found

**Symptom:**
```
❌ Parent template not found: team-standard
```

**Cause:** The `extends` ID doesn't match any existing template

**Fix:** Verify parent exists:
```bash
# Check template locations
ls examples/team-templates/team-standard.json
ls examples/preference-templates/team-standard.json

# Or fix the extends reference
{
  "templateMetadata": {
    "extends": "correct-template-id"
  }
}
```

#### Error: Max depth exceeded

**Symptom:**
```
❌ Max inheritance depth exceeded (5 levels)
```

**Cause:** Inheritance chain is too deep: A→B→C→D→E→F

**Fix:** Flatten your hierarchy:
```
Before: A → B → C → D → E → F (6 levels)
After:  A → B → C (3 levels)
        A → D (2 levels)
```

---

## Part 3: Template Parameters (v4.2.0)

### The Problem: One Template, Many Configurations

**Scenario:** You want one full-stack template, but teams use different stacks.

Without parameters:
```
fullstack-react-express.json        → Hardcoded "react" + "express"
fullstack-vue-fastapi.json          → Hardcoded "vue" + "fastapi"
fullstack-svelte-django.json        → Hardcoded "svelte" + "django"
```
Result: 10+ templates for every combination.

With parameters:
```
fullstack.json → Uses ${frontendFramework} and ${backendFramework}
```
Result: 1 template, infinite combinations.

**Benefits:**
- **Reduced duplication:** One template for many configurations
- **User choice:** Customize at application time
- **Maintenance:** Update once, applies to all uses

### How Parameters Work

**Step 1: Define parameters in metadata**

```json
{
  "templateMetadata": {
    "id": "fullstack",
    "name": "Full-Stack Parameterized",
    "parameters": {
      "frontendFramework": {
        "type": "string",
        "required": true,
        "description": "Frontend framework (react, vue, svelte, angular)"
      },
      "backendFramework": {
        "type": "string",
        "required": true,
        "description": "Backend framework (express, fastapi, django, rails)"
      },
      "database": {
        "type": "string",
        "default": "postgresql",
        "description": "Database (postgresql, mysql, mongodb, sqlite)"
      },
      "testCoverage": {
        "type": "number",
        "default": 80,
        "description": "Test coverage target percentage (0-100)"
      },
      "useTypeScript": {
        "type": "boolean",
        "default": true,
        "description": "Use TypeScript for type safety"
      }
    }
  }
}
```

**Step 2: Use parameters in contents with `${varName}` syntax**

```json
{
  "contents": {
    "profile": {
      "primaryFrameworks": ["${frontendFramework}", "${backendFramework}"]
    },
    "learnedPreferences": {
      "quality": {
        "test-coverage-target": "${testCoverage}",
        "database-preference": "${database}",
        "typescript-enabled": "${useTypeScript}"
      }
    }
  }
}
```

**Step 3: Provide values when applying**

**CLI mode:**
```bash
./scripts/apply-template.sh fullstack \
    --param frontendFramework=react \
    --param backendFramework=fastapi \
    --param database=postgresql \
    --param testCoverage=90 \
    --param useTypeScript=true
```

**Interactive mode:**
```bash
./scripts/apply-template.sh fullstack
# Script prompts:
# frontendFramework (required) - Frontend framework (react, vue, svelte, angular)
# Value: react
# backendFramework (required) - Backend framework (express, fastapi, django, rails)
# Value: fastapi
# database [postgresql] - Database (postgresql, mysql, mongodb, sqlite)
# Value: [Enter for default]
# ...
```

**Result after substitution:**
```json
{
  "profile": {
    "primaryFrameworks": ["react", "fastapi"]
  },
  "learnedPreferences": {
    "quality": {
      "test-coverage-target": 90,
      "database-preference": "postgresql",
      "typescript-enabled": true
    }
  }
}
```

### Parameter Types

**String** - Text values
```json
"company": {
  "type": "string",
  "required": true,
  "description": "Company name for git config"
}
```
Usage: `"companyName": "${company}"`

**Number** - Numeric values
```json
"testCoverage": {
  "type": "number",
  "default": 80,
  "description": "Test coverage target (0-100)"
}
```
Usage: `"coverageTarget": "${testCoverage}"`

**Boolean** - True/false flags
```json
"useTypeScript": {
  "type": "boolean",
  "default": true,
  "description": "Enable TypeScript"
}
```
Usage: `"typescriptEnabled": "${useTypeScript}"`

### Default Values

**Inline defaults in parameter definition:**
```json
"database": {
  "type": "string",
  "default": "postgresql",    // ← Used if not provided
  "description": "Database system"
}
```

**Inline defaults in template contents (legacy syntax):**
```json
"databaseUrl": "postgresql://localhost/${database:mydb}"
```
This uses `mydb` if `${database}` isn't provided.

### Required vs Optional Parameters

**Required:** Must be provided or template application fails
```json
"frontendFramework": {
  "type": "string",
  "required": true,        // ← Must provide
  "description": "Frontend framework"
}
```

**Optional:** Can be omitted, uses default
```json
"testCoverage": {
  "type": "number",
  "default": 80,           // ← Optional, defaults to 80
  "description": "Test coverage target"
}
```

### Parameter Resolution Modes

#### CLI Mode (Non-Interactive)

**Advantages:**
- Scriptable (CI/CD pipelines)
- Fast (no prompts)
- Version-controllable (document in scripts)

**Usage:**
```bash
./scripts/apply-template.sh template-name \
    --param key1=value1 \
    --param key2=value2 \
    --param key3=value3
```

**Example:**
```bash
./scripts/apply-template.sh gallery-fullstack \
    --param frontendFramework=react \
    --param backendFramework=fastapi \
    --param database=postgresql \
    --param testCoverage=85 \
    --param useTypeScript=true
```

#### Interactive Mode (Prompts)

**Advantages:**
- Guided experience
- Descriptions shown inline
- Default values suggested
- Type validation

**Usage:**
```bash
./scripts/apply-template.sh template-name
# Script detects parameters and prompts
```

**Example session:**
```
Parameter: frontendFramework (required)
Description: Frontend framework (react, vue, svelte, angular)
Value: react

Parameter: backendFramework (required)
Description: Backend framework (express, fastapi, django, rails)
Value: fastapi

Parameter: database [postgresql]
Description: Database (postgresql, mysql, mongodb, sqlite)
Value: [press Enter to use default]

Parameter: testCoverage [80]
Description: Test coverage target percentage (0-100)
Value: 85

Parameter: useTypeScript [true]
Description: Use TypeScript for type safety
Value: [press Enter to use default]
```

### Creating Parameterized Templates

**Step-by-step guide:**

**1. Start with a working template**
```json
{
  "templateMetadata": {
    "id": "my-custom-stack",
    "name": "My Custom Stack"
  },
  "contents": {
    "profile": {
      "primaryFrameworks": ["react", "express"]
    }
  }
}
```

**2. Identify values to parameterize**
- Values that change between uses: "react", "express"
- User-specific values: Company name, team name
- Environment values: URLs, ports

**3. Define parameters in metadata**
```json
{
  "templateMetadata": {
    "id": "my-custom-stack",
    "name": "My Custom Stack",
    "parameters": {
      "frontend": {
        "type": "string",
        "required": true,
        "description": "Frontend framework"
      },
      "backend": {
        "type": "string",
        "required": true,
        "description": "Backend framework"
      }
    }
  }
}
```

**4. Replace hardcoded values with `${varName}`**
```json
{
  "contents": {
    "profile": {
      "primaryFrameworks": ["${frontend}", "${backend}"]
    }
  }
}
```

**5. Test with different parameter values**
```bash
# Test with react + express
./scripts/apply-template.sh my-custom-stack \
    --param frontend=react \
    --param backend=express

# Test with vue + django
./scripts/apply-template.sh my-custom-stack \
    --param frontend=vue \
    --param backend=django
```

### Troubleshooting Parameters

#### Error: Missing required parameter

**Symptom:**
```
❌ Missing required parameter: frontendFramework
```

**Cause:** Template requires a parameter but you didn't provide it

**Fix Option 1 - Provide via CLI:**
```bash
./scripts/apply-template.sh template-name --param frontendFramework=react
```

**Fix Option 2 - Run interactive mode:**
```bash
./scripts/apply-template.sh template-name
# Script will prompt for missing parameters
```

**Fix Option 3 - Make parameter optional:**
```json
"frontendFramework": {
  "type": "string",
  "default": "react",  // ← Add default
  "description": "Frontend framework"
}
```

#### Error: Invalid parameter type

**Symptom:**
```
❌ Invalid value for parameter testCoverage: expected number, got "eighty"
```

**Cause:** Provided string where number was expected

**Fix:** Use correct type:
```bash
# Wrong:
--param testCoverage=eighty

# Correct:
--param testCoverage=80
```

#### Error: Syntax error in ${} reference

**Symptom:**
```
❌ Syntax error: Unmatched ${varName} in template
```

**Cause:** Typo in variable name or missing closing brace

**Fix:** Verify syntax:
```json
// Wrong:
"value": "${testCoverage"       // Missing }
"value": "#{testCoverage}"      // Wrong delimiter #{}
"value": "${test Coverage}"     // Space in name

// Correct:
"value": "${testCoverage}"
```

---

## Complete Example: Building a Template Hierarchy

Let's create a complete template system for a fictional company "Acme Corp" with multiple project types.

### Step 1: Base Template (Foundation)

**File:** `acme-standard.json`

```json
{
  "$schema": "claude-preferences-export-v1",
  "exportVersion": "1.0.0",
  "exportedAt": "2025-12-16T00:00:00Z",
  "exportedBy": "acme-corp",
  "sourceVersion": "4.2.0",

  "exportType": "template",

  "templateMetadata": {
    "id": "acme-standard",
    "name": "Acme Corp Standard",
    "description": "Base configuration for all Acme projects",
    "category": "team",
    "version": "1.0.0",
    "author": "acme-corp"
  },

  "compatibility": {
    "minVersion": "4.0.0",
    "maxVersion": null
  },

  "contents": {
    "profile": {
      "experienceLevel": "intermediate",
      "proactivityLevel": "medium",
      "preferredWorkflow": "wizard"
    },

    "confidenceThresholds": {
      "autoApply": 95,
      "suggestProminently": 75,
      "showAsOptional": 50,
      "hideBelow": 30
    },

    "learnedPreferences": {
      "workflow": {
        "preferred-commit-style": "conventional",
        "preferred-branch-naming": "feature/",
        "require-pr-reviews": true
      },
      "quality": {
        "security-scan-threshold": "high",
        "test-coverage-target": 85,
        "lint-on-commit": true
      },
      "documentation": {
        "auto-update-changelog": true,
        "require-jsdoc": true
      }
    },

    "skillSpecificPreferences": {
      "commit-readiness-checker": {
        "requireChangelog": true,
        "requireTests": true,
        "conventionalCommits": true
      }
    }
  },

  "metadata": {
    "checksum": "acme-standard-v1",
    "exportOptions": {
      "includeAnalytics": false,
      "includeLearningHistory": false
    }
  }
}
```

### Step 2: Domain Template with Inheritance

**File:** `acme-frontend.json`

```json
{
  "$schema": "claude-preferences-export-v1",
  "exportVersion": "1.0.0",
  "exportedAt": "2025-12-16T00:00:00Z",
  "exportedBy": "acme-corp",
  "sourceVersion": "4.2.0",

  "exportType": "template",

  "templateMetadata": {
    "id": "acme-frontend",
    "name": "Acme Frontend",
    "description": "Frontend configuration extending acme-standard",
    "category": "frontend",
    "version": "1.0.0",
    "author": "acme-corp",
    "extends": "acme-standard",                    // ← Inherits base config
    "_extendsHint": "Inherits all Acme standards, adds frontend specifics"
  },

  "compatibility": {
    "minVersion": "4.1.0",
    "maxVersion": null
  },

  "contents": {
    "profile": {
      "primaryLanguages": ["typescript", "javascript"],
      "primaryFrameworks": ["react", "nextjs", "tailwind"]
    },

    "learnedPreferences": {
      "workflow": {
        "component-driven": true,
        "hot-reload": true,
        "storybook-enabled": true
      },
      "quality": {
        "accessibility-checks": true,
        "responsive-design": true,
        "lighthouse-score-min": 90
      }
    },

    "skillSpecificPreferences": {
      "component-finder": {
        "frameworkHints": ["react", "jsx", "tsx"],
        "componentPatterns": ["src/components/**", "app/**"],
        "stateManagement": ["useState", "zustand"]
      },
      "test-generator": {
        "testFramework": "vitest",
        "testingLibrary": "testing-library/react",
        "coverageTarget": 85,
        "snapshotTesting": true
      }
    }
  },

  "metadata": {
    "checksum": "acme-frontend-v1"
  }
}
```

### Step 3: Parameterized Project Template

**File:** `acme-ecommerce.json`

```json
{
  "$schema": "claude-preferences-export-v1",
  "exportVersion": "1.0.0",
  "exportedAt": "2025-12-16T00:00:00Z",
  "exportedBy": "acme-corp",
  "sourceVersion": "4.2.0",

  "exportType": "template",

  "templateMetadata": {
    "id": "acme-ecommerce",
    "name": "Acme E-Commerce Project",
    "description": "E-commerce project with customizable payment and analytics providers",
    "category": "project",
    "version": "1.0.0",
    "author": "acme-corp",
    "extends": "acme-frontend",                    // ← Inherits frontend config
    "parameters": {                                 // ← Adds parameters
      "paymentProvider": {
        "type": "string",
        "required": true,
        "description": "Payment provider (stripe, paypal, square)"
      },
      "analyticsProvider": {
        "type": "string",
        "default": "google-analytics",
        "description": "Analytics provider (google-analytics, mixpanel, amplitude)"
      },
      "enableABTesting": {
        "type": "boolean",
        "default": false,
        "description": "Enable A/B testing features"
      },
      "maxCartItems": {
        "type": "number",
        "default": 100,
        "description": "Maximum items allowed in cart"
      }
    },
    "_parametersHint": "Required: paymentProvider. Optional: analyticsProvider, enableABTesting, maxCartItems"
  },

  "compatibility": {
    "minVersion": "4.2.0",
    "maxVersion": null
  },

  "contents": {
    "profile": {
      "projectType": "ecommerce",
      "integrations": ["${paymentProvider}", "${analyticsProvider}"]
    },

    "learnedPreferences": {
      "workflow": {
        "payment-integration": "${paymentProvider}",
        "analytics-integration": "${analyticsProvider}",
        "ab-testing-enabled": "${enableABTesting}"
      },
      "quality": {
        "payment-security-checks": true,
        "pci-compliance": true,
        "gdpr-compliance": true,
        "max-cart-size": "${maxCartItems}"
      }
    },

    "skillSpecificPreferences": {
      "security-scanner": {
        "paymentEndpointChecks": true,
        "sessionManagementChecks": true
      },
      "test-generator": {
        "includePaymentMocks": true,
        "includeCheckoutFlowTests": true
      }
    }
  },

  "metadata": {
    "checksum": "acme-ecommerce-v1"
  }
}
```

### Applying the Complete Hierarchy

**Applying base template:**
```bash
./scripts/apply-template.sh acme-standard
```
Result: General Acme configuration

**Applying domain template (with inheritance):**
```bash
./scripts/apply-template.sh acme-frontend
```
Result: Acme standard + frontend specifics

**Applying project template (with inheritance + parameters):**
```bash
./scripts/apply-template.sh acme-ecommerce \
    --param paymentProvider=stripe \
    --param analyticsProvider=mixpanel \
    --param enableABTesting=true \
    --param maxCartItems=150
```
Result: Acme standard + frontend + e-commerce + custom configuration

**Inheritance chain resolved:**
```
acme-ecommerce
  extends acme-frontend
    extends acme-standard
      = Final merged result with parameters substituted
```

---

## Template Lifecycle

The complete template workflow from creation to application:

```
1. Create/Export (v4.0.0)
   ├─ Configure settings manually
   ├─ Export as template JSON
   └─ Share via git or URL

2. Add Inheritance (v4.1.0)
   ├─ Identify base template
   ├─ Add "extends" field
   └─ Test merged result

3. Add Parameters (v4.2.0)
   ├─ Identify variable values
   ├─ Define parameters in metadata
   ├─ Replace values with ${varName}
   └─ Test with different parameter sets

4. Validate (v4.4.0)
   ├─ Run: ./scripts/validate-template.sh
   ├─ Check JSON syntax
   ├─ Verify schema compliance
   └─ Validate catalog entries

5. Apply (v4.5.0)
   ├─ Run: ./scripts/apply-template.sh
   ├─ Resolve inheritance chains
   ├─ Substitute parameters
   ├─ Preview with diff
   ├─ Confirm changes
   └─ Apply to project
```

---

## Next Steps

**You now understand the foundation. Continue your journey:**

### Explore Ready-to-Use Templates
[Template Gallery Guide](TEMPLATE_GALLERY_GUIDE.md) - Browse 9 curated templates for different domains (frontend, backend, data science, devops, full-stack)

### Validate Your Templates
[Template Validator Guide](../04-ecosystem/TEMPLATE_VALIDATOR_GUIDE.md) - Ensure your templates are correctly structured before sharing

### Apply Templates to Projects
[Template Application Guide](../04-ecosystem/APPLY_TEMPLATE_GUIDE.md) - Automated template application with inheritance resolution and parameter substitution

### Advanced Topics
- **Team Template Sharing** - Distribute templates via git repositories
- **Template Catalogs** - Create discoverable template collections
- **CI/CD Integration** - Validate templates in automated pipelines
- **Template Versioning** - Manage template versions over time

---

## Reference

### Schema Versions

| Schema | Purpose | Version |
|--------|---------|---------|
| `claude-preferences-export-v1` | Template format | v1 (current) |
| `claude-template-catalog-v1` | Catalog format | v1 (current) |

### Template Structure Fields

| Field | Required | Description |
|-------|----------|-------------|
| `$schema` | Yes | Schema identifier |
| `exportType` | Yes | Must be "template" |
| `templateMetadata` | Yes | Template identification and inheritance |
| `templateMetadata.id` | Yes | Unique identifier |
| `templateMetadata.name` | Yes | Display name |
| `templateMetadata.extends` | No | Parent template ID (v4.1.0) |
| `templateMetadata.parameters` | No | Parameter definitions (v4.2.0) |
| `contents` | Yes | Actual settings to apply |
| `compatibility` | No | Version constraints |
| `metadata` | No | Additional metadata |

### Related Features

| Feature | Version | Documentation |
|---------|---------|---------------|
| Template Gallery | v4.3.0 | [Template Gallery Guide](TEMPLATE_GALLERY_GUIDE.md) |
| Template Validator | v4.4.0 | [Template Validator Guide](../04-ecosystem/TEMPLATE_VALIDATOR_GUIDE.md) |
| Template Application | v4.5.0 | [Template Application Guide](../04-ecosystem/APPLY_TEMPLATE_GUIDE.md) |

### Keywords

template, inheritance, parameters, import, export, preferences, extends, settings, configuration, team, sharing, composition, customization

---

## Navigation

- **Previous:** [MCP Optimization Guide](MCP_OPTIMIZATION_GUIDE.md)
- **Next:** [Template Gallery Guide](TEMPLATE_GALLERY_GUIDE.md)
- **Up:** [02-optimization README](README.md)
