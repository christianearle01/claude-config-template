# Quick Reference: Testing Workflow

**Just-in-Time Help** for test result insights

---

## Most Common Queries (90% usage)

### 1. "What tests failed?"
```
→ Lists all failed tests with details
→ Shows: file path, test name, error message, duration
→ Groups by module for pattern recognition
→ Provides file locations with line numbers
```

**Quick answer:** X tests failed with fix starting points

---

### 2. "How are my tests doing?"
```
→ High-level overview (pass/fail/skip counts)
→ Pass rate percentage
→ Total duration
→ Quick health check
```

**Use when:** Just want to know if tests are generally healthy

---

### 3. "Show me test stats"
```
→ Comprehensive statistics dashboard
→ Total/passed/failed/skipped breakdown
→ By-module statistics
→ Duration analysis (total, average per test)
→ Visual indicators (✅❌⏭️)
```

**Use when:** Need full picture for reporting or optimization

---

### 4. "What tests are slowest?"
```
→ Lists tests >1s duration
→ Shows status (passed/failed)
→ Suggests optimization strategies
→ Compares to average duration
```

**Use when:** Performance optimization focus

---

### 5. "Show auth module tests"
```
→ Filters tests by module name
→ Module-specific statistics
→ Failed tests within module
→ Module-specific run commands
```

**Use when:** Working on specific module, want focused view

---

## Pro Tips

### Test Frameworks Supported
```
✅ Jest (JavaScript/TypeScript)
   Output: test-results.json
   Format: Jest JSON reporter

✅ pytest (Python)
   Output: test-results.json
   Format: --json-report plugin

✅ RSpec (Ruby)
   Output: test-results.json
   Format: --format json
```

**All frameworks work** - skill adapts to format!

---

### Speed Commands

#### Jest
```bash
# Run all tests
npm test

# Run specific file
npm test -- auth/login.test.js

# Run with coverage
npm test -- --coverage

# Run only failed tests
npm test -- --onlyFailures

# Generate JSON results
npm test -- --json --outputFile=test-results.json
```

#### pytest
```bash
# Run all tests
pytest

# Run specific module
pytest tests/auth/

# Run specific test
pytest tests/auth/test_login.py::test_invalid_credentials

# Run only failed tests
pytest --lf

# Generate JSON results
pytest --json-report --json-report-file=test-results.json
```

#### RSpec
```bash
# Run all tests
rspec

# Run specific file
rspec spec/auth/login_spec.rb

# Run specific test (by line number)
rspec spec/auth/login_spec.rb:45

# Run only failed tests
rspec --only-failures

# Generate JSON results
rspec --format json --out test-results.json
```

---

## Quick Decision Tree

```
Need to... | Ask...
-----------|-------
See failures | "What tests failed?"
Quick health check | "How are my tests doing?"
Full statistics | "Show me test stats"
Optimize performance | "What tests are slowest?"
Module focus | "Show [module] tests"
Track progress | "What tests are newly passing?"
```

---

## Common Scenarios

### Scenario 1: CI Pipeline Failed
**Problem:** "CI shows red, what broke?"

**Solution:**
```
Ask: "What tests failed?"
→ See 3 failures in auth module
→ All 3 related to API status codes
→ Likely single root cause: auth service misconfigured
→ Fix auth service, not 3 separate tests
```

**Time saved:** 30 minutes of debugging each test individually

---

### Scenario 2: Test Suite Too Slow
**Problem:** "Tests take 5 minutes, blocking fast iteration"

**Solution:**
```
Ask: "What tests are slowest?"
→ See: integration/api-e2e.test.js takes 5.2s
→ Recommendation: Mock external API
→ After fix: Re-run "What tests are slowest?"
→ Verify: 5.2s saved per run
```

**Time saved:** 5.2s per test run = 52s per hour (10 runs)

---

### Scenario 3: Module Refactoring
**Problem:** "Refactored auth module, did I break anything?"

**Solution:**
```
Ask: "Show auth module tests"
→ See: 45 tests, 42 passed, 3 failed
→ Drill into failures: "What tests failed?"
→ Fix issues, re-run: npm test -- auth
→ Confirm: "Show auth module tests" (all green)
```

**Time saved:** Focused testing vs running full suite (8.5s vs 42.3s)

---

### Scenario 4: Progress Tracking
**Problem:** "Spent 2 hours fixing tests, what did I accomplish?"

**Solution:**
```
Ask: "What tests are newly passing?"
→ See: 3 tests fixed in last 2 hours
→ Celebrate progress!
→ Share with team: "Fixed 3 auth tests today"
```

**Psychological benefit:** Positive reinforcement for continued work

---

### Scenario 5: Test Coverage Gaps
**Problem:** "Which modules need more tests?"

**Solution:**
```
Ask: "Show me test stats"
→ See by-module breakdown:
  - auth: 45 tests
  - payments: 30 tests
  - user-profile: 25 tests (low coverage?)
  - api-routes: 45 tests
→ Identify: user-profile might need more coverage
```

**Action:** Add tests to under-covered modules

---

## Integration with Skills

### Testing Workflow Skill
Automatic test result analysis without parsing output manually:

```
You ask: "What tests failed?"
Skill activates automatically:
→ Reads test results JSON
→ Parses failures
→ Formats with file locations
```

**Token savings:** 62% (800 → 300 tokens per query)

### Related Skills
- **api-debugging:** Debug API-related test failures
- **component-finder:** Find components tested by failing tests
- **workflow-analyzer:** Analyze testing patterns over time

---

## Test Output Interpretation

### Pass Rate Benchmarks
```
✅ Excellent: 98-100% (1-2 failures max)
✅ Good: 95-98% (maintenance needed)
⚠️  Fair: 90-95% (prioritize fixes)
❌ Poor: <90% (significant issues)
```

### Duration Benchmarks
```
⚡ Fast: <0.5s per test average
✅ Good: 0.5-1.0s per test
⚠️  Slow: 1.0-2.0s per test
❌ Very Slow: >2.0s per test
```

**Goal:** 98%+ pass rate, <0.5s per test

---

## Troubleshooting

### Issue: "Test results file not found"
**Cause:** Tests not run with JSON output flag

**Fix:**
```bash
# Jest
npm test -- --json --outputFile=test-results.json

# pytest
pytest --json-report --json-report-file=test-results.json

# RSpec
rspec --format json --out test-results.json
```

---

### Issue: "Results seem stale"
**Cause:** Looking at old test results file

**Fix:**
```
Check file timestamp:
ls -lh test-results.json

If old (e.g., 3 days):
→ Re-run tests with JSON output
→ Ask skill again for fresh data
```

---

### Issue: "Skill doesn't recognize test format"
**Cause:** Custom test output format not supported

**Fix:**
```
Supported formats:
- Jest JSON reporter
- pytest JSON report plugin
- RSpec JSON format

If using custom format:
→ Convert to one of supported formats
→ Or open issue: github.com/christianearle01/claude-config-template
```

---

### Issue: "Module filtering doesn't work"
**Cause:** Tests not organized by module/directory

**Fix:**
```
Organize tests:
tests/
  auth/          ← Module name
    login.test.js
    signup.test.js
  payments/      ← Module name
    checkout.test.js

Skill uses directory name as module!
```

---

## Performance Optimization Guide

### Common Slow Test Causes

#### 1. External API Calls
```
Problem: Tests call real Stripe/AWS/etc APIs
Solution: Mock external services
Time saved: 2-5s per test
```

#### 2. Database Setup/Teardown
```
Problem: Each test creates/destroys database
Solution: Use transactions or in-memory database
Time saved: 1-3s per test
```

#### 3. Heavy Computation
```
Problem: Tests run expensive algorithms
Solution: Mock computation or use smaller datasets
Time saved: 1-2s per test
```

#### 4. Sleep/Wait Calls
```
Problem: Tests use sleep(2) for async operations
Solution: Use proper async/await or test utilities
Time saved: 2s per test (exactly the sleep time!)
```

---

## Test Failure Pattern Recognition

### Pattern 1: Same Error, Multiple Tests
```
3 tests failed with: "Expected 401, got 500"

Likely cause: API endpoint misconfigured
Fix: Check auth/routes.js, not individual tests
```

### Pattern 2: Flaky Tests
```
Test passes sometimes, fails others

Likely cause: Race condition, timing issue
Fix: Add proper async handling, not sleeps
```

### Pattern 3: Module-Wide Failures
```
All 45 auth tests failed

Likely cause: Auth service down, config missing
Fix: Check auth service, not tests
```

### Pattern 4: Slow + Failed
```
Test takes 5s AND fails

Likely cause: Timeout waiting for service
Fix: Check service availability, increase timeout
```

---

## Additional Resources

- **Skill Documentation:** `.claude/skills/testing-workflow/SKILL.md`
- **Jest Docs:** https://jestjs.io/docs/cli
- **pytest Docs:** https://docs.pytest.org/
- **RSpec Docs:** https://rspec.info/documentation/
- **Testing Best Practices:** (project-specific docs)

---

**Last Updated:** 2025-12-15 (v3.5.0)
**Skill:** testing-workflow
**Audience:** QA engineers, backend/frontend developers
