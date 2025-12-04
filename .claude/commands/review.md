---
name: review
description: Review code against project standards
---

Review code changes against project standards.

**First, ask the user:**
"What files or changes should I review?"

**Options:**
1. Specific files (provide file paths)
2. Recent git changes (review uncommitted changes)
3. Specific git commit or branch
4. All files in a directory

**Once scope is determined, review against standards from CLAUDE.md:**

## Code Review Checklist

### ✓ Code Style & Conventions
- [ ] Follows naming conventions (check CLAUDE.md)
- [ ] Correct indentation (spaces/tabs as specified)
- [ ] Import order matches project standards
- [ ] Line length within limits
- [ ] Comments only where logic is non-obvious

### ✓ Algorithm & Performance
- [ ] Big O complexity is acceptable (O(n) or better)
- [ ] No unnecessary nested loops
- [ ] Efficient data structures used (HashMap/Set for lookups)
- [ ] Edge cases handled (n=0, large n, null/undefined)

### ✓ Security
- [ ] No hardcoded credentials or API keys
- [ ] No SQL injection vulnerabilities (uses parameterized queries)
- [ ] No XSS vulnerabilities (sanitized user input)
- [ ] Sensitive data not logged
- [ ] Environment variables used correctly

### ✓ Testing
- [ ] Has appropriate test coverage
- [ ] Tests are meaningful (not just coverage targets)
- [ ] Edge cases tested
- [ ] Error cases tested

### ✓ Error Handling
- [ ] Proper error handling in place
- [ ] Errors logged appropriately
- [ ] User-friendly error messages
- [ ] No silent failures

### ✓ Project-Specific Standards
- [ ] Follows project patterns (check CLAUDE.md "Agent Optimization Notes")
- [ ] Matches existing code style in similar files
- [ ] Uses project-standard response patterns
- [ ] External API usage follows documented patterns

**Output Format:**

```
## Code Review: [file or scope]

### ✅ Looks Good
- Follows naming conventions consistently
- Efficient O(n) algorithm for data processing
- Good error handling with meaningful messages

### ⚠️  Suggestions
1. [file:line] - Consider using HashMap instead of Array.find() for O(1) lookup
2. [file:line] - Add edge case handling for empty input
3. [file:line] - Extract magic number to named constant

### ❌ Issues (Must Fix)
1. [file:line] - SQL query uses string concatenation (SQL injection risk)
   Fix: Use parameterized queries with ? placeholders
2. [file:line] - API key hardcoded in source
   Fix: Move to environment variable

### 📊 Overall Assessment
[Summary of code quality and adherence to standards]
```

**Provide constructive feedback with:**
- Specific file:line references
- Clear explanation of why something should change
- Suggestion for how to fix it
- Priority (nice-to-have vs must-fix)

**Do NOT make changes** unless user explicitly requests fixes after review.
