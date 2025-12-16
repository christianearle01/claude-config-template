---
name: component-finder
description: Helps locate React/Vue/Angular components, UI elements, and frontend code. Auto-activates when users ask where components are defined, how to find UI code, or locate specific frontend features. Uses codebase patterns to guide search.
allowed-tools: Read, Grep, Glob
---

# Component Finder Skill

## Purpose & Activation

**What it does:** Helps locate frontend components, UI code, and related files in React, Vue, Angular, or other component-based frameworks.

**When it activates:**
- "Where is the login component?"
- "Find the button code"
- "Locate the dashboard component"
- "Where's the navigation bar defined?"
- "Show me component X"

**How it helps:**
- Identifies component file locations
- Understands framework conventions (React, Vue, Angular)
- Searches across multiple naming patterns
- Finds related files (styles, tests, stories)
- Navigates component hierarchies

**JIT Help Available:**
For quick reference on component search patterns and conventions, see: **[Cheat Sheet](./cheatsheet.md)**

---

## Key Operations

### Operation 1: Find Component by Name

**User Query:**
> "Where is the LoginForm component?"
> "Find the Button component"
> "Locate UserProfile"

**Confidence:** 🟢 High (0.88)
- Explicit component name provided
- Standard naming conventions exist
- Multiple search patterns cover variations

**Skill Response:**
```
🔍 Searching for "LoginForm" component...

**Search Strategy:**
Looking across common patterns:
1. LoginForm.jsx / LoginForm.tsx (React)
2. LoginForm.vue (Vue)
3. login-form.component.ts (Angular)
4. LoginForm/index.js (index pattern)
5. components/LoginForm.* (nested)

**Found:**
📄 src/components/Auth/LoginForm.tsx
   Type: React functional component
   Lines: 45
   Exports: LoginForm (default)

**Related Files:**
📄 src/components/Auth/LoginForm.test.tsx (tests)
📄 src/components/Auth/LoginForm.module.css (styles)
📄 src/components/Auth/LoginForm.stories.tsx (Storybook)

**Quick Navigation:**
```bash
# Open in editor
code src/components/Auth/LoginForm.tsx

# View file
cat src/components/Auth/LoginForm.tsx
```

**Component Usage:**
Found 12 imports of LoginForm:
- src/pages/Login.tsx (line 8)
- src/pages/SignupFlow.tsx (line 15)
- src/components/AuthModal.tsx (line 22)
```

**Why This Matters:**
- Fast location saves 5-10 minutes of manual searching
- Related files (tests, styles) shown immediately
- Usage locations help understand component context
- **Quick win:** Navigate to file now with provided command

**Next Step:** Want to see the component code? Ask "Read LoginForm component"

### Operation 2: Find Component by UI Description

**User Query:**
> "Where's the code for the blue submit button?"
> "Find the header navigation bar"
> "Locate the user avatar dropdown"

**Confidence:** 🟡 Medium (0.65)
- Description-based search (less precise than name)
- Requires understanding UI → code mapping
- May return multiple candidates

**Skill Response:**
```
🔍 Searching for "blue submit button"...

**Search Strategy:**
1. Look for "Button" components with "submit" or "primary" variants
2. Search for "blue" in style files
3. Check common button locations (forms, modals)

**Candidates Found:**

**Option 1: PrimaryButton (Most Likely)**
📄 src/components/ui/Button.tsx
   Variant: "primary" (default blue)
   Props: variant="primary", type="submit"
   Used in: 18 locations

**Option 2: SubmitButton**
📄 src/components/forms/SubmitButton.tsx
   Dedicated submit button wrapper
   Inherits blue color from PrimaryButton
   Used in: 8 locations

**Option 3: FormActions**
📄 src/components/forms/FormActions.tsx
   Container with submit button
   Uses PrimaryButton internally
   Used in: 12 locations

**Narrow Down:**
Which form/page is this button on?
- Login form → src/pages/Login.tsx uses PrimaryButton
- Signup form → src/pages/Signup.tsx uses SubmitButton
- Contact form → src/pages/Contact.tsx uses FormActions

**Quick Search:**
```bash
# Search for "submit" buttons
grep -r "type.*submit" src/components --include="*.tsx"

# Search for "blue" in styles
grep -r "blue" src/components --include="*.css" --include="*.scss"
```
```

**Why This Matters:**
- UI descriptions map to multiple possible components
- Framework shows candidates with usage context
- Narrowing questions save exploration time
- **Quick win:** Check most common location first (PrimaryButton)

**Next Step:** Specify which page/form to narrow down exact component

### Operation 3: Find Component Parent/Child Relationships

**User Query:**
> "What components does Dashboard use?"
> "Where is Header component used?"
> "Show me the component tree for UserProfile"

**Confidence:** 🟢 High (0.82)
- Import/export relationships are deterministic
- grep/search can find all usages
- Component hierarchy is well-defined

**Skill Response:**
```
🌳 Component Hierarchy: Dashboard

**Dashboard Component:**
📄 src/pages/Dashboard.tsx

**Imports (Children):**
1. Header (src/components/layout/Header.tsx)
2. Sidebar (src/components/layout/Sidebar.tsx)
3. StatsCard (src/components/dashboard/StatsCard.tsx) × 4
4. RecentActivity (src/components/dashboard/RecentActivity.tsx)
5. QuickActions (src/components/dashboard/QuickActions.tsx)

**Used By (Parents):**
1. App.tsx (line 45) - Route: /dashboard
2. AuthenticatedLayout.tsx (line 78) - Nested layout

**Component Tree:**
```
App
└── AuthenticatedLayout
    └── Dashboard (YOU ARE HERE)
        ├── Header
        │   ├── Logo
        │   ├── Navigation
        │   └── UserMenu
        ├── Sidebar
        │   ├── NavItem × 6
        │   └── UserProfile
        ├── StatsCard × 4
        ├── RecentActivity
        │   └── ActivityItem × N
        └── QuickActions
            └── ActionButton × 5
```

**Find Commands:**
```bash
# Find all imports in Dashboard
grep "^import" src/pages/Dashboard.tsx

# Find where Dashboard is imported
grep -r "from.*Dashboard" src --include="*.tsx" --include="*.jsx"

# Find all components in same directory
ls src/pages/Dashboard/
```
```

**Why This Matters:**
- Understanding parent/child relationships is critical for refactoring
- Component tree reveals nesting depth (potential performance issue if deep)
- Usage locations show where changes will impact
- **Quick win:** See full tree structure to understand dependencies

**Next Step:** Want to refactor? Ask "How do I safely move Dashboard component?"

---

## Framework-Specific Patterns

### React / React Native
```
**File Extensions:**
- .jsx, .tsx (TypeScript)
- .js (plain JavaScript)

**Naming Conventions:**
- PascalCase: Button.tsx, UserProfile.tsx
- Index pattern: Button/index.tsx
- kebab-case: button.component.tsx (less common)

**Common Locations:**
- src/components/
- src/pages/ or src/views/
- src/features/<feature>/components/

**Search Patterns:**
grep -r "export.*Component" src/components
grep -r "export default function" src/components
```

### Vue.js
```
**File Extensions:**
- .vue (single-file components)

**Naming Conventions:**
- PascalCase: Button.vue, UserProfile.vue
- kebab-case: user-profile.vue (Vue 2 style)

**Common Locations:**
- src/components/
- src/views/
- src/pages/

**Search Patterns:**
grep -r "<template>" src/components --include="*.vue"
grep -r "export default {" src/components --include="*.vue"
```

### Angular
```
**File Extensions:**
- .component.ts (logic)
- .component.html (template)
- .component.css/.scss (styles)

**Naming Conventions:**
- kebab-case: button.component.ts, user-profile.component.ts
- Always includes .component before extension

**Common Locations:**
- src/app/components/
- src/app/shared/
- src/app/features/<feature>/

**Search Patterns:**
grep -r "@Component" src/app --include="*.ts"
grep -r "selector:" src/app --include="*.component.ts"
```

---

## Common Search Scenarios

### Scenario 1: "I see a button on the page, where's the code?"

**Approach:**
1. **Inspect element** (Chrome DevTools)
   - Right-click button → Inspect
   - Look for class names or data attributes
   - Copy class name (e.g., "btn-primary")

2. **Search by class name:**
   ```bash
   grep -r "btn-primary" src --include="*.tsx" --include="*.css"
   ```

3. **Find component file:**
   - Match class name to component file
   - Check import statements to trace up hierarchy

**Quick Win:** DevTools inspection reveals class names to search for

---

### Scenario 2: "Component exists but I can't find where it's used"

**Approach:**
```bash
# Find all imports of ComponentName
grep -r "import.*ComponentName" src --include="*.tsx" --include="*.jsx"

# Alternative: Search for JSX usage
grep -r "<ComponentName" src --include="*.tsx" --include="*.jsx"

# Check if exported from index
grep -r "export.*ComponentName" src/components/index.*
```

**Quick Win:** Exported from index.ts files = used via barrel imports

---

### Scenario 3: "Too many files, can't find the right one"

**Approach:**
```bash
# List all component files
find src -name "*.tsx" -o -name "*.vue" -o -name "*.component.ts"

# Filter by keyword
find src -name "*Button*.tsx"

# Sort by recent modification (likely candidates)
find src -name "*.tsx" -exec ls -lt {} + | head -20
```

**Quick Win:** Recently modified files = actively worked on = likely candidates

---

## Naming Convention Guide

### Component Names vs File Names

**React:**
```
Component: <UserProfile />
File: UserProfile.tsx or UserProfile/index.tsx
Import: import { UserProfile } from './UserProfile'
```

**Vue:**
```
Component: <UserProfile />
File: UserProfile.vue or user-profile.vue
Import: import UserProfile from './UserProfile.vue'
```

**Angular:**
```
Component: app-user-profile selector
File: user-profile.component.ts
Import: import { UserProfileComponent } from './user-profile.component'
```

### Common Variations
```
PascalCase: UserProfile, LoginForm, NavBar
kebab-case: user-profile, login-form, nav-bar
camelCase: userProfile (rare for components)
```

---

## Token Efficiency Analysis

### Without This Skill (1,200 tokens per search)
**Process:**
1. User: "Find LoginForm component" (50 tokens)
2. Claude: "Let me search..." (100 tokens)
3. Run find commands (150 tokens)
4. Explore multiple directories (300 tokens)
5. Read candidate files (400 tokens)
6. Return results (200 tokens)

**Total: ~1,200 tokens**

### With This Skill (400 tokens per search)
**Process:**
1. User: "Find LoginForm component" (50 tokens)
2. Skill activates with search patterns (100 tokens)
3. Execute targeted search (150 tokens)
4. Return results with context (100 tokens)

**Total: ~400 tokens**

**Savings:** 800 tokens per search (67% reduction)

**Frequency:** Developers search for components 10-20 times per week
- Weekly: 8,000-16,000 tokens saved
- Monthly: 32,000-64,000 tokens saved (~$0.96-$1.92/month)

---

## Best Practices

### For Users
1. **Provide component name** - If known, saves search time
2. **Mention framework** - React/Vue/Angular uses different patterns
3. **Describe UI location** - "header", "sidebar", "modal" helps narrow down
4. **Check DevTools first** - Class names reveal component hints
5. **Search codebase** - Use IDE search (Cmd+P) for quick access

### For Claude (Using This Skill)
1. **Try exact name first** - Before fuzzy searching
2. **Show related files** - Tests, styles, stories
3. **Provide navigation commands** - Easy file opening
4. **Explain framework patterns** - Help users learn conventions
5. **Show usage locations** - Where component is imported

---

## Troubleshooting

### Issue: "Component not found"
**Cause:** Name mismatch, wrong directory, or not a component

**Fix:**
```bash
# Broader search
find src -name "*LoginForm*"

# Search file contents
grep -r "LoginForm" src

# Check if it's a sub-component
grep -r "const LoginForm" src --include="*.tsx"
```

### Issue: "Multiple components with same name"
**Cause:** Naming conflicts across features

**Fix:**
- Disambiguate by path: `auth/Button` vs `ui/Button`
- Check imports to see which is used where
- Consider refactoring to unique names

### Issue: "Component exists but imports fail"
**Cause:** Barrel export issues, circular dependencies

**Fix:**
```bash
# Check export statement
grep "export.*ComponentName" src/components/index.ts

# Check import path
# Use relative: import { Button } from './Button'
# Not barrel: import { Button } from '@/components'
```

---

## See Also

- **Grep tool** - For text searching in files
- **Glob tool** - For file pattern matching
- **React Docs:** https://react.dev
- **Vue Docs:** https://vuejs.org
- **Angular Docs:** https://angular.io

---

**Skill Version:** 3.5.0
**Last Updated:** 2025-12-15
**Target Audience:** Frontend developers, UI engineers
**Maintained By:** claude-config-template project
