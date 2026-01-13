# Post-Session Verification

**Purpose:** Review all changes made in this session for security, efficiency, and best practices before ending.

---

## Verification Checklist

Please systematically review all changes made in this session against the following criteria:

### 1. Security Review (OWASP Top 10)

**Check for:**
- [ ] **No hardcoded secrets** (API keys, passwords, tokens)
  - All sensitive data uses environment variables
  - No credentials in code comments or logs

- [ ] **Input validation** on all user-supplied data
  - All inputs validated before use
  - Type checking and sanitization applied

- [ ] **SQL injection prevention** (if database queries were modified)
  - All queries use parameterized statements (NOT string concatenation)
  - ORM methods used correctly (no raw SQL unless necessary)

- [ ] **XSS protection** (if HTML output was added/modified)
  - All user content properly escaped/sanitized
  - Content Security Policy headers considered

- [ ] **Authentication & Authorization** (if auth logic was modified)
  - Proper authentication checks in place
  - Authorization verified before sensitive operations

- [ ] **Sensitive Data Exposure** (if handling sensitive data)
  - No sensitive data in error messages or logs
  - Appropriate data encryption where needed

### 2. Code Efficiency Review

**Check for:**
- [ ] **No unnecessary nested loops** on same dataset
  - Algorithmic complexity is reasonable (preferably O(n) or better)
  - Use HashMap/Set for O(1) lookups where applicable

- [ ] **Appropriate data structures** chosen
  - Arrays/Lists for sequential access
  - Maps/Objects for key-value lookups
  - Sets for uniqueness checks

- [ ] **No redundant operations**
  - Results cached when computation is expensive
  - Avoid repeated work in loops

- [ ] **Database queries optimized** (if database code modified)
  - No N+1 query problems
  - Appropriate indexes considered
  - Batch operations used where possible

- [ ] **No memory leaks** (if applicable)
  - Event listeners cleaned up
  - Resources properly closed/released

### 3. Code Quality Review

**Check for:**
- [ ] **No overly complex code**
  - Functions are focused and single-purpose
  - Logic is clear and self-documenting
  - Appropriate comments where logic is non-obvious

- [ ] **Consistent naming conventions**
  - Variables/functions follow project naming style
  - Names are descriptive and meaningful

- [ ] **Error handling implemented**
  - Expected errors are caught and handled appropriately
  - Error messages are helpful and don't expose sensitive info

- [ ] **Edge cases considered**
  - Null/undefined checks where needed
  - Empty array/object handling
  - Boundary conditions tested

### 4. Testing Review

**Check for:**
- [ ] **Sufficient test coverage** for changes
  - New functions have corresponding tests
  - Modified functions have tests updated
  - Edge cases are tested

- [ ] **Tests actually pass**
  - All tests run successfully
  - No tests skipped or marked as pending

- [ ] **Test quality is good**
  - Tests are clear and focused
  - Tests assert meaningful behavior
  - Tests don't just check implementation details

### 5. Documentation Review

**Check for:**
- [ ] **CLAUDE.md updated** (if behavior changed)
  - New features documented
  - Changed workflows updated
  - External APIs documented if added

- [ ] **Code comments added** where logic is non-obvious
  - Complex algorithms explained
  - Business logic rationale documented
  - TODOs marked if incomplete

- [ ] **API documentation updated** (if API changes made)
  - New endpoints documented
  - Request/response formats updated
  - Error codes documented

---

## Verification Output Format

Please provide your verification results in this format:

```markdown
## Session Verification Results

### ✅ Security Check
- [Finding 1]: [Status - Pass/Warning/Fail]
- [Finding 2]: [Status - Pass/Warning/Fail]
- Overall: [Pass/Needs Attention]

### ✅ Efficiency Check
- [Finding 1]: [Status - Pass/Warning/Fail]
- [Finding 2]: [Status - Pass/Warning/Fail]
- Overall: [Pass/Needs Attention]

### ✅ Code Quality Check
- [Finding 1]: [Status - Pass/Warning/Fail]
- [Finding 2]: [Status - Pass/Warning/Fail]
- Overall: [Pass/Needs Attention]

### ✅ Testing Check
- [Finding 1]: [Status - Pass/Warning/Fail]
- [Finding 2]: [Status - Pass/Warning/Fail]
- Overall: [Pass/Needs Attention]

### ✅ Documentation Check
- [Finding 1]: [Status - Pass/Warning/Fail]
- [Finding 2]: [Status - Pass/Warning/Fail]
- Overall: [Pass/Needs Attention]

## Summary
- **Total Issues Found:** [Count]
- **Critical Issues:** [Count - must fix before commit]
- **Warnings:** [Count - should address]
- **Session Quality:** [Excellent/Good/Needs Work]

## Recommendations
[If any issues found, list specific recommendations for fixes]
```

---

## When to Use This Command

**Use `/verify` at the end of every session before:**
- Committing changes
- Creating a pull request
- Ending the work session
- Switching to a different task

**Especially important when:**
- Working with authentication/authorization
- Handling sensitive data
- Writing database queries
- Accepting user input
- Making performance-critical changes

---

## Example Usage

**User:** "/verify"

**Claude:**
```markdown
## Session Verification Results

### ✅ Security Check
- No hardcoded secrets: Pass
- Input validation on new API endpoint: Pass
- SQL queries use parameterized statements: Pass
- Overall: Pass

### ✅ Efficiency Check
- No nested loops on same dataset: Pass
- Used HashMap for user lookup (O(1)): Pass
- Database query fetches only needed fields: Pass
- Overall: Pass

### ✅ Code Quality Check
- Functions are focused and clear: Pass
- Error handling implemented: Pass
- Edge cases considered (empty array handling): Pass
- Overall: Pass

### ✅ Testing Check
- New function has unit tests: Pass
- Edge cases tested: Pass
- All tests passing: Pass
- Overall: Pass

### ✅ Documentation Check
- CLAUDE.md updated with new API endpoint: Warning - Not yet updated
- Code comments added for complex logic: Pass
- Overall: Needs Attention

## Summary
- **Total Issues Found:** 1
- **Critical Issues:** 0
- **Warnings:** 1 (Documentation)
- **Session Quality:** Good

## Recommendations
- Update CLAUDE.md to document the new /api/users/search endpoint
  - Add to "External Services & APIs" section
  - Describe what it does and expected parameters
```

---

## Notes

- This verification is a **systematic checklist**, not a guarantee
- Use your judgment - not all items apply to every session
- If you find critical issues, fix them before committing
- Warnings should be addressed but aren't always blocking
- This command complements code review, doesn't replace it

---

**Based on:** Boris Cherny's (Claude Code creator) recommended workflow
**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.1
