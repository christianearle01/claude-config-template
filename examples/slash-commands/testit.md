# /testit - Test Suite Runner

**Purpose:** Run project tests with intelligent reporting and error analysis

**Priority:** ⭐ Good-to-have (saves 5-10 minutes per testing cycle)
**Benefit:** Auto-detects test framework, runs tests, explains failures

---

## What It Does

`/testit` automates this workflow:

```bash
# Without /testit (multiple commands + analysis)
npm test  # or pytest, or cargo test
# Read output
# Identify failures
# Search for failing test file
# Read test code
# Search for implementation
# Analyze what's wrong
# ~10 minutes
```

```bash
# With /testit (1 command)
/testit

# Claude automatically:
# - Detects test framework
# - Runs tests
# - Parses output
# - Identifies failures
# - Reads failing test files
# - Analyzes root cause
# - Suggests fixes
# ~2 minutes
```

---

## How to Create This Command

### Step 1: Create Command File

Create `.claude/commands/testit.md` in your project:

```markdown
# Test Suite Runner - /testit

When the user types `/testit`, intelligently run the project's test suite:

## Auto-Detection Logic

1. Check for test framework:
   - If `package.json` has `test` script → run `npm test`
   - If `pytest.ini` or `tests/` directory exists → run `pytest`
   - If `Cargo.toml` exists → run `cargo test`
   - If `go.mod` exists → run `go test ./...`
   - If `.rspec` exists → run `rspec`

2. Run tests and capture output

3. Parse output:
   - Count: Passing, Failing, Skipped
   - Identify: Which tests failed

4. For each failure:
   - Read the failing test file
   - Read the implementation being tested
   - Analyze root cause
   - Suggest specific fix

5. Provide summary:
   - Overall pass rate
   - Critical failures (vs minor)
   - Recommended next steps

## Example Output

\`\`\`
Running tests: npm test

Results:
✅ 47 passing
❌ 2 failing
⏭️  3 skipped

Failures:

1. test/auth/login.test.js - "should validate email format"
   Expected: true
   Actual: false

   Root cause: login.js:42 - Email regex doesn't handle + characters
   Fix: Update regex to /^[^\s@]+@[^\s@]+\.[^\s@]+$/

2. test/api/users.test.js - "should return 404 for missing user"
   Expected: 404
   Actual: 500

   Root cause: users.js:78 - Missing null check before accessing user.id
   Fix: Add: if (!user) return res.status(404).json({error: 'Not found'})

Summary:
- Pass rate: 96% (47/49)
- Critical: 1 (users.js null check - security issue)
- Minor: 1 (login.js email validation - edge case)

Recommended next steps:
1. Fix critical: users.js null check (prevents crashes)
2. Fix minor: login.js regex (improves validation)
3. Re-run: /testit to confirm fixes
\`\`\`
```

---

### Step 2: Test the Command

```bash
# In Claude terminal
/testit

# Claude will auto-detect framework and run tests
```

---

## Usage Examples

### Example 1: All Tests Pass

**User:**
```
/testit
```

**Claude:**
```
Running tests: npm test

Results:
✅ 52 passing
❌ 0 failing

All tests passed! 🎉

Coverage:
- Statements: 87%
- Branches: 82%
- Functions: 91%
- Lines: 86%

Next steps:
✅ Ready to commit
✅ Consider /getit "Add feature with full test coverage"
```

---

### Example 2: Tests Fail (With Analysis)

**User:**
```
/testit
```

**Claude:**
```
Running tests: pytest

Results:
✅ 38 passing
❌ 3 failing

Failures:

1. tests/test_auth.py::test_login_with_invalid_email
   FAILED: assert False

   Reading tests/test_auth.py...
   Reading src/auth.py...

   Root cause: auth.py line 56
   Email validation regex doesn't handle uppercase letters

   Current: r'^[a-z0-9]+@[a-z0-9]+\.[a-z]+'
   Fix: r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+'

   Would you like me to fix this? (yes/no)
```

**User:**
```
yes
```

**Claude fixes, then:**
```
Fixed auth.py line 56.

Re-running tests...

Results:
✅ 41 passing
❌ 0 failing

All tests now pass! 🎉

Should I commit these changes with /getit?
```

---

### Example 3: Specific Test File

**User:**
```
/testit test/auth/login.test.js
```

**Claude:**
```
Running: npm test test/auth/login.test.js

Results:
✅ 12 passing (login.test.js only)
❌ 0 failing

Focused test suite passed!

Note: Full suite has 52 tests total.
Run /testit to test everything.
```

---

### Example 4: Watch Mode

**User:**
```
/testit --watch
```

**Claude:**
```
Starting test watch mode: npm test -- --watch

Tests will re-run automatically on file changes.

Current status:
✅ 52 passing

Watching:
- src/**/*.js
- test/**/*.js

To stop: Ctrl-C in right pane (if split-screen)
```

---

## Advanced Usage

### Add Coverage Thresholds

Modify `.claude/commands/testit.md`:

```markdown
After running tests, check coverage:

If coverage < 80%:
- ⚠️ "Coverage below threshold (78% < 80%)"
- Suggest: "Add tests for: [uncovered files]"

If coverage ≥ 80%:
- ✅ "Coverage meets threshold (87% ≥ 80%)"
```

---

### Add Performance Monitoring

```markdown
Track slow tests:

If any test > 1 second:
- ⚠️ "Slow test detected: test_database_query (2.3s)"
- Suggest: "Consider mocking database calls"
```

---

### Add Flaky Test Detection

```markdown
If test fails intermittently:
- Run test 3 times
- If passes sometimes, fails sometimes:
  - Mark as flaky
  - Suggest: "Test may have race condition or timing issue"
```

---

## Framework-Specific Examples

### JavaScript/TypeScript (Jest, Mocha, Vitest)

**Auto-detected commands:**
```bash
npm test              # package.json "test" script
npm run test:unit     # Unit tests only
npm run test:e2e      # E2E tests only
npx jest --coverage   # With coverage
```

**Common assertions:**
- `expect(x).toBe(y)` - Exact match
- `expect(x).toEqual(y)` - Deep equal
- `expect(fn).toThrow()` - Error thrown

---

### Python (pytest, unittest)

**Auto-detected commands:**
```bash
pytest                     # All tests
pytest tests/             # tests/ directory
pytest -v                 # Verbose
pytest --cov=src          # With coverage
python -m unittest        # unittest
```

**Common assertions:**
- `assert x == y` - Equality
- `assert x in y` - Membership
- `with pytest.raises(ValueError):` - Exception

---

### Rust (cargo test)

**Auto-detected commands:**
```bash
cargo test                # All tests
cargo test --lib          # Library tests
cargo test --doc          # Doc tests
cargo test test_name      # Specific test
```

**Common patterns:**
- `assert_eq!(x, y)` - Equality
- `assert!(condition)` - Boolean
- `#[should_panic]` - Expected panic

---

### Go (go test)

**Auto-detected commands:**
```bash
go test ./...             # All packages
go test -v ./...          # Verbose
go test -cover ./...      # With coverage
go test -run TestName     # Specific test
```

**Common patterns:**
- `if got != want` - Comparison
- `t.Errorf("message")` - Error reporting
- `t.Fatal("message")` - Fatal error

---

## Integration with Other Workflows

### /testit + /verify + /getit

**Pattern: Complete quality workflow**

```
1. Make changes
2. /testit (ensure tests pass)
3. /verify (check security, efficiency)
4. /getit "commit message"
```

**Benefit:** Comprehensive quality checks before commit

---

### /testit + Plan Mode

**Pattern: Test-Driven Development**

```
1. Shift+Tab Shift+Tab (Plan Mode)
2. Plan: "Write tests first, then implementation"
3. /testit (tests fail - expected)
4. Implement feature
5. /testit (tests pass)
6. /getit "Implement [feature] with TDD"
```

**Benefit:** TDD workflow with AI assistance

---

### /testit + Split-Screen

**Pattern: Real-time test feedback**

```
┌──────────────────────┬──────────────────────┐
│   Claude Code        │   /testit --watch    │
│                      │                      │
│ Make changes         │ ✅ 47 passing         │
│                      │ ❌ 1 failing          │
│ Fix issue            │ ✅ 48 passing         │
│                      │ ❌ 0 failing          │
└──────────────────────┴──────────────────────┘
```

**See:** `docs/02-optimization/07_split-screen-setup.md`

---

## Troubleshooting

### "Tests take forever to run"

**Solution 1: Run subset**
```bash
/testit test/auth/  # Just auth tests
```

**Solution 2: Parallelize**
```markdown
# Modify .claude/commands/testit.md
For Jest: npm test -- --maxWorkers=4
For pytest: pytest -n 4
For go: go test -parallel 4 ./...
```

**Solution 3: Skip slow tests**
```bash
pytest -m "not slow"  # pytest with markers
npm test -- --testPathIgnorePatterns=e2e  # Skip E2E
```

---

### "Test output is too verbose"

**Solution:** Filter output

Modify `.claude/commands/testit.md`:
```markdown
Parse test output and show only:
- Summary (pass/fail counts)
- Failures (with file:line)
- Suggestions (how to fix)

Hide:
- Stack traces (unless requested)
- Passing test names
- Setup/teardown logs
```

---

### "Tests fail but Claude can't identify why"

**Solution:** Ask for deep analysis

```
/testit --debug

# Claude will:
# 1. Show full stack trace
# 2. Read all related files
# 3. Check for common patterns (null refs, async issues)
# 4. Suggest debugging steps
```

---

## Limitations

**What /testit CANNOT do:**

❌ Fix all test failures automatically (some require human judgment)
❌ Run E2E tests that require browsers (Selenium, Playwright)
❌ Tests that require external services (unless mocked)
❌ Visual regression tests (screenshot comparison)

**What /testit CAN do:**

✅ Run unit and integration tests
✅ Analyze failures and suggest fixes
✅ Handle most common testing scenarios
✅ Work with major test frameworks

---

## Success Metrics

### How to Know It's Working

**Week 1:**
- ✅ Using `/testit` instead of manual test commands
- ✅ Understanding test failures faster
- ✅ Fixing issues in <5 minutes vs <15 minutes

**Week 2+:**
- ✅ Test pass rate improved (fewer failures)
- ✅ Catching bugs before review
- ✅ TDD workflow feels natural

---

## Related Commands

- **`/verify`** - Post-session verification (`.claude/commands/verify.md`)
- **`/getit`** - Git workflow automation (see `examples/slash-commands/getit.md`)

---

## Summary

**Key Takeaways:**

✅ **Auto-detection:** Works with any test framework
✅ **Intelligent analysis:** Explains WHY tests fail
✅ **Actionable fixes:** Suggests specific changes
✅ **Time savings:** 5-10 minutes per testing cycle

**Recommended Setup:**

1. Create `.claude/commands/testit.md` (copy template above)
2. Test with `/testit`
3. Customize for your framework
4. Integrate into quality workflow (/testit → /verify → /getit)

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.2
**Example Command:** Part of Boris Cherny's workflow automation
