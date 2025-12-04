---
name: build
description: Build project and report any errors
---

Build the project and report results:

1. **Find build command:**
   - Check CLAUDE.md "Common Commands" section for build command
   - If not found, check package.json "scripts.build" or look for build configs

2. **Run build:**
   - Execute the build command
   - Capture full output including errors and warnings

3. **Report results:**

   **If build succeeded:**
   ```
   ✅ Build Successful

   Output: [build artifacts created]
   Warnings: [X warnings] (if any)
   Time: [build time]
   ```

   **If build failed:**
   ```
   ❌ Build Failed

   Errors: [X errors]
   Warnings: [X warnings]

   Error Details:
   1. [File:line] - [Error message]
   2. [File:line] - [Error message]

   Would you like help fixing these errors?
   ```

4. **Common build issues to check:**
   - TypeScript/compilation errors
   - Missing dependencies
   - Syntax errors
   - Type mismatches
   - Import errors
   - Configuration issues

**IMPORTANT Safety Notes:**
- This command ONLY runs the build
- It does NOT create commits
- It does NOT push to remote
- It does NOT deploy anywhere
- You maintain full control over git operations

**Example output:**
```
✅ Build Successful

Created: dist/server.js (342 KB)
Created: dist/server.js.map (89 KB)

⚠️  2 Warnings:
1. src/utils/helper.ts:45 - Unused variable 'tempData'
2. src/services/payment.ts:120 - console.log statement in production code

Build completed in 8.3s
```

If build fails, offer to help fix the errors, but wait for user approval before making changes.
