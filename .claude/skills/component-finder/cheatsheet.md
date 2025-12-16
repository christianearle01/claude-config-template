# Component Finder - Quick Reference

**Quick search patterns and conventions for finding UI components across frameworks.**

---

## Common Search Patterns

### Find React Components

```bash
# By component name
grep -r "export.*ButtonComponent" src/
grep -r "export default.*Button" src/

# By props interface
grep -r "interface.*ButtonProps" src/
grep -r "type.*ButtonProps" src/

# By hook usage
grep -r "useState.*button" src/
grep -r "useEffect" src/components/Button
```

### Find Vue Components

```bash
# SFC components
find src/ -name "*Button*.vue"
glob "**/*Button*.vue"

# Composables
grep -r "export.*useButton" src/composables/
grep -r "defineComponent" src/components/

# Setup script
grep -r "<script setup" src/
```

### Find Angular Components

```bash
# By decorator
grep -r "@Component.*ButtonComponent" src/
grep -r "@Component" src/app/components/

# By selector
grep -r "selector:.*app-button" src/
grep -r "selector:" src/ | grep button

# By template
find src/ -name "*.component.ts"
```

---

## Quick Decision Tree

```
Need to find component?
│
├─ Know exact name?
│  → Use Glob: **/*ComponentName*
│  → Example: **/*Button*.tsx
│
├─ Know what it does?
│  → Use Grep: search for keywords in comments/docs
│  → Example: grep -r "user authentication" src/
│
├─ Know where it's used?
│  → Use Grep: search for import statements
│  → Example: grep -r "import.*Button" src/
│
└─ Don't know anything?
   → Operation 1: Analyze project structure first
   → Identify framework, naming conventions, directory layout
```

---

## Common Mistakes

### ❌ Too Broad

```bash
# Searching for "Button" returns hundreds of results
grep -r "Button" src/
```

### ✅ Specific

```bash
# Searching for specific component or pattern
grep -r "PrimaryButton" src/
grep -r "export.*Button" src/components/
```

---

### ❌ Wrong Directory

```bash
# Looking only in /components
ls src/components/*Button*
```

### ✅ Comprehensive Search

```bash
# Search entire src/ tree (components may be in ui/, shared/, common/)
find src/ -name "*Button*"
glob "src/**/*Button*"
```

---

### ❌ Ignoring Extensions

```bash
# Missing .tsx files when searching .jsx
find src/ -name "*.jsx"
```

### ✅ Framework-Appropriate

```bash
# React: Search both .jsx and .tsx
find src/ -name "*.jsx" -o -name "*.tsx"

# Vue: Search .vue files
find src/ -name "*.vue"

# Angular: Search .component.ts
find src/ -name "*.component.ts"
```

---

## Framework-Specific Conventions

### React

**Component locations:**
- `/components` - Shared components
- `/ui` - UI primitives
- `/views` or `/pages` - Page-level components
- `/features/[feature]/components` - Feature-specific

**File naming:**
- `PascalCase.tsx` - Single component per file
- `PascalCase/index.tsx` - Component with sub-components
- `PascalCase.test.tsx` - Test files

**Export patterns:**
```javascript
// Default export
export default function Button() { }

// Named export
export const Button = () => { }

// Barrel export (index.tsx)
export { Button } from './Button'
```

---

### Vue

**Component locations:**
- `/components` - Shared components
- `/views` - Page-level components
- `/layouts` - Layout components

**File naming:**
- `PascalCase.vue` - Common convention
- `kebab-case.vue` - Alternative style
- Consistent within project

**SFC structure:**
```vue
<template>
  <!-- HTML -->
</template>

<script setup>
// Logic (Composition API)
</script>

<script>
// Legacy Options API
</script>

<style scoped>
/* Styles */
</style>
```

---

### Angular

**Component locations:**
- `/app/components` - Shared components
- `/app/features/[feature]` - Feature modules
- `/app/shared` - Shared utilities

**File naming:**
- `component-name.component.ts` - Component logic
- `component-name.component.html` - Template
- `component-name.component.scss` - Styles
- `component-name.component.spec.ts` - Tests

**Decorator pattern:**
```typescript
@Component({
  selector: 'app-button',
  templateUrl: './button.component.html',
  styleUrls: ['./button.component.scss']
})
export class ButtonComponent { }
```

---

## Time Savers

### 5-Minute Pattern

**For known components:**
1. Use Glob with component name: `**/*Button*.tsx`
2. If not found, broaden search: `**/*Button*`
3. Check alternate directories: `ui/`, `shared/`, `common/`

**For unknown components:**
1. Start with project structure analysis (Operation 1)
2. Identify naming convention (PascalCase vs kebab-case)
3. Search by pattern once convention known

---

### Avoid These Time Wasters

❌ **Manual directory traversal**
- Don't: `cd` into each directory and `ls`
- Do: Use `find` or `glob` to search entire tree

❌ **Searching generated files**
- Don't: Search in `node_modules/`, `dist/`, `build/`
- Do: Use `.gitignore` patterns to exclude

❌ **Overly broad searches**
- Don't: `grep -r "button" src/` (thousands of results)
- Do: `grep -r "export.*Button" src/components/` (specific)

---

## Common Workflows

### Workflow 1: Find by Name

```bash
# Step 1: Try exact match
glob "**/*UserProfile*.tsx"

# Step 2: If not found, try partial match
grep -r "UserProfile" src/

# Step 3: Check imports
grep -r "import.*UserProfile" src/
```

### Workflow 2: Find by Feature

```bash
# Step 1: Search for keywords
grep -r "authentication" src/ --include="*.tsx"

# Step 2: Look for related components
grep -r "Login\|Signup\|Auth" src/components/

# Step 3: Check feature directory
ls src/features/auth/components/
```

### Workflow 3: Find by Usage

```bash
# Step 1: Find where component is imported
grep -r "import.*Button" src/

# Step 2: Trace back to definition
# Look at import paths to find source

# Step 3: Verify location
ls src/components/Button/
```

---

## Pro Tips

### Tip 1: Use IDE Search

Most IDEs (VS Code, WebStorm) have better search than command line:
- **Cmd+P** (VS Code): Quick file finder
- **Cmd+Shift+F** (VS Code): Global search
- **Cmd+Click** (most IDEs): Go to definition

### Tip 2: Read Project README

Many projects document component structure:
```markdown
## Project Structure
- src/components/ - Shared UI components
- src/features/ - Feature-specific components
- src/pages/ - Page-level routing components
```

### Tip 3: Check Import Paths

Look at existing imports to understand structure:
```typescript
// Reveals component locations
import { Button } from '@/components/ui'
import { UserCard } from '@/features/users/components'
```

---

## Troubleshooting

### Problem: "Can't find component but it exists"

**Possible causes:**
1. Component in `node_modules` (third-party)
2. Using alias paths (`@/components`)
3. Different file extension than expected
4. Component inlined in parent file (not separate)

**Solutions:**
1. Check `package.json` for third-party components
2. Check tsconfig.json/jsconfig.json for path aliases
3. Search without extension: `find src/ -name "*Button*"`
4. Search for class/function name inside files

---

### Problem: "Too many results"

**Solutions:**
1. Add file type filter: `--include="*.tsx"`
2. Limit to specific directory: `src/components/`
3. Use more specific search term: `"export default Button"` instead of `"Button"`
4. Exclude test files: `--exclude="*.test.*"`

---

### Problem: "Wrong component found"

**Solutions:**
1. Check component purpose/props to verify it's correct one
2. Look for more specific component (PrimaryButton vs Button)
3. Check feature-specific directories (`features/auth/` vs `components/`)

---

## Reference: Common Search Patterns

| Goal | Command | Example |
|------|---------|---------|
| Find by name | `glob "**/*Name*"` | `glob "**/*Button*.tsx"` |
| Find exports | `grep -r "export.*Name"` | `grep -r "export.*Button" src/` |
| Find imports | `grep -r "import.*Name"` | `grep -r "import.*Button" src/` |
| Find by selector | `grep -r "selector:.*name"` | `grep -r "selector:.*app-button"` |
| Find composables | `grep -r "use[A-Z]"` | `grep -r "useButton" src/` |
| List directory | `ls path/` | `ls src/components/` |
| Recursive find | `find path/ -name "pattern"` | `find src/ -name "*Button*"` |

---

**See [SKILL.md](./SKILL.md) for complete operation details and examples**

---

**Version:** v4.11.0 | **Last Updated:** 2025-12-17
