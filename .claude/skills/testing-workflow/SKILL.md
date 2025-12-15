---
name: testing-workflow
description: Provides insights on test execution results, test failures, pass rates, and test performance. Activates when users ask about tests, test results, failures, passes, test status, broken tests, failing specs, test coverage, or test performance.
allowed-tools: Read, Grep
---

# Testing Workflow Skill

## Purpose & Activation

This skill provides **automatic insights on test execution status** without requiring users to parse test output manually.

### When This Skill Activates

The skill automatically activates when users mention:
- Test results ("What tests failed?")
- Test status ("Show me test coverage")
- Test failures ("Which tests are broken?")
- Test performance ("What tests are slowest?")
- Test modules ("Show auth module tests")

### What This Skill Does

**READ-ONLY Operations:**
- Reads test result files (JSON, XML, logs)
- Identifies failed/passed tests
- Calculates statistics (pass rate, duration)
- Filters by module/suite
- Identifies slow tests
- Tracks recently fixed tests

**Complements Test Runners:**
- For WRITE operations (run tests), skill recommends test commands
- Works with any test framework (Jest, pytest, RSpec, etc.)
- Provides intelligence layer, test runner provides execution

**JIT Help Available:**
For quick reference on test commands and troubleshooting, see: **[Cheat Sheet](./CHEAT_SHEET.md)**
- 5 most common test queries (90% usage)
- Speed commands for Jest/pytest/RSpec
- Quick decision tree
- Common scenarios (CI failures, slow tests, refactoring)
- Pass rate and duration benchmarks
- Performance optimization guide

---

## Core Knowledge

### Supported Test Result Formats

**Jest (JavaScript/TypeScript):**
```json
{
  "success": false,
  "numTotalTests": 145,
  "numPassedTests": 142,
  "numFailedTests": 3,
  "testResults": [
    {
      "name": "auth/login.test.js",
      "status": "failed",
      "duration": 2300,
      "message": "Expected 401, got 500"
    }
  ]
}
```

**pytest (Python):**
```json
{
  "tests": [
    {
      "nodeid": "tests/test_auth.py::test_login_invalid",
      "outcome": "failed",
      "duration": 1.23,
      "longrepr": "AssertionError: expected 401, got 500"
    }
  ],
  "summary": {
    "passed": 142,
    "failed": 3,
    "total": 145
  }
}
```

**RSpec (Ruby):**
```json
{
  "examples": [
    {
      "description": "handles invalid credentials",
      "file_path": "./spec/auth/login_spec.rb",
      "line_number": 45,
      "status": "failed",
      "run_time": 0.023,
      "exception": {
        "message": "expected 401, got 500"
      }
    }
  ],
  "summary": {
    "example_count": 145,
    "failure_count": 3
  }
}
```

### Status Values

- **passed** - Test executed successfully
- **failed** - Test failed with assertion error
- **skipped** - Test was skipped/pending
- **error** - Test had runtime error (not assertion)

---

## Key Operations

### 1. List Failed Tests

**User Queries:**
> "What tests failed?"
> "Show me failing tests"
> "Which tests are broken?"

**Confidence:** 🟢 High (0.92)
- Exact keyword matches: "failed", "failing", "broken"
- Test result files accessible (JSON/XML/logs)
- Clear intent to identify specific failures

**Skill Response:**
```
3 tests failed:

❌ auth/login.test.js - 'handles invalid credentials' (2.3s)
   Module: authentication
   Error: Expected 401, got 500
   File: src/auth/login.test.js:45

❌ auth/signup.test.js - 'validates email format' (1.8s)
   Module: authentication
   Error: Validation not triggered
   File: src/auth/signup.test.js:78

❌ payments/checkout.test.js - 'processes refund' (0.5s)
   Module: payments
   Error: Stripe API timeout
   File: src/payments/checkout.test.js:120

To fix, check the error messages and file locations above.
```

**Why This Matters:**
- Failed tests block deployment and indicate broken functionality
- File locations and line numbers speed up debugging (no hunting)
- Error messages reveal root cause patterns (2 auth tests = likely auth service issue)
- **Quick win:** Fix auth/login.test.js first (2.3s duration suggests integration issue)

**Next Step:** Want to see test stats to understand overall health? Ask "Give me test stats"

---

### 2. Test Statistics Dashboard

**User Queries:**
> "Give me test stats"
> "Test summary"
> "How many tests passed?"

**Confidence:** 🟢 High (0.94)
- Exact keyword matches: "stats", "summary", "passed"
- Test result aggregation is deterministic (JSON parsing)
- Clear intent for high-level overview

**Skill Response:**
```
📊 Test Execution Summary:

Total Tests: 145
✅ Passed: 142 (97.9%)
❌ Failed: 3 (2.1%)
⏭️ Skipped: 0 (0%)

By Module:
- authentication: 45 tests (3 failed)
- payments: 30 tests (0 failed)
- user-profile: 25 tests (0 failed)
- api-routes: 45 tests (0 failed)

Total Duration: 42.3s
Average: 0.29s per test
```

**Why This Matters:**
- 97.9% pass rate = generally healthy codebase (industry standard: >95%)
- Module breakdown reveals authentication as problem area (3 failures localized)
- Total duration 42.3s is reasonable for 145 tests (fast feedback loop)
- **Quick win:** All failures in one module = likely single root cause to fix

**Next Step:** Drill into authentication failures with "Show auth module tests"

---

### 3. Filter by Module

**User Queries:**
> "Show auth module tests"
> "What tests failed in payments?"
> "Authentication test results"

**Confidence:** 🟢 High (0.91)
- Module name explicitly mentioned ("auth", "payments")
- Test organization by module is standard practice
- Clear filtering intent

**Skill Response:**
```
Authentication Module Tests:

Total: 45 tests
✅ Passed: 42 (93.3%)
❌ Failed: 3 (6.7%)

Failed Tests:
1. login.test.js - 'handles invalid credentials'
2. signup.test.js - 'validates email format'
3. token.test.js - 'refreshes expired tokens'

Duration: 8.5s (average: 0.19s)

To run only auth tests:
  npm test -- auth
  # or
  pytest tests/auth/
```

**Why This Matters:**
- Module filtering isolates failures (93.3% pass rate within auth vs 97.9% overall)
- Focused view reveals related test failures (3 auth tests = likely 1 root cause)
- Faster iteration cycle (8.5s to run auth module vs 42.3s for all tests)
- **Quick win:** Run `npm test -- auth` to verify fixes without waiting for full suite

**Next Step:** After fixing auth tests, ask "What tests are newly passing?" to confirm success

---

### 4. Identify Slow Tests

**User Queries:**
> "What tests are slowest?"
> "Show me slow tests"
> "Which tests take longest?"

**Confidence:** 🟢 High (0.88)
- Exact keyword matches: "slowest", "slow", "longest"
- Duration data available in test results
- Clear performance optimization intent

**Skill Response:**
```
🐌 Slowest Tests (>1s):

1. integration/api-e2e.test.js (5.2s)
   Status: ✅ Passed
   Module: integration
   Consider: Mocking external API calls

2. auth/login.test.js (2.3s)
   Status: ❌ Failed
   Module: authentication
   Consider: Database setup might be slow

3. payments/checkout.test.js (1.8s)
   Status: ✅ Passed
   Module: payments
   Consider: Mocking Stripe API

Average test duration: 0.29s
Target: <0.5s per test
```

**Why This Matters:**
- Slow tests block fast iteration (3 tests account for 21% of total test time)
- External API calls are optimization targets (5.2s + 1.8s = 7s wasted on Stripe/API mocks)
- Developer productivity loss: 42.3s wait → potentially 33s wait (22% faster)
- **Quick win:** Mock external services in integration/api-e2e.test.js to save 5.2s per run

**Next Step:** After optimization, re-run "What tests are slowest?" to verify improvements

---

### 5. Recently Fixed Tests

**User Queries:**
> "What tests are newly passing?"
> "Recently fixed tests"
> "Tests that were broken but work now"

**Confidence:** 🟢 High (0.89)
- Exact keyword matches: "newly passing", "recently fixed", "broken but work now"
- Requires comparing current and previous test results
- Clear intent to track progress

**Skill Response:**
```
✅ Recently Fixed Tests (3):

These tests failed last run but pass now:

1. user-profile/avatar.test.js - 'uploads image'
   Was: Failed (file size validation)
   Now: ✅ Passed
   Fixed: 2 hours ago

2. api-routes/posts.test.js - 'creates new post'
   Was: Failed (database constraint)
   Now: ✅ Passed
   Fixed: 1 hour ago

3. auth/password-reset.test.js - 'sends email'
   Was: Failed (email service timeout)
   Now: ✅ Passed
   Fixed: 30 minutes ago

Great progress! Keep it up!
```

**Why This Matters:**
- Progress tracking motivates continued testing work (positive reinforcement)
- Recently fixed tests reveal which bug fixes are working (validation of recent code changes)
- Time stamps show velocity (3 fixes in 2 hours = good debugging pace)
- **Quick win:** 3 tests fixed means 3 fewer failures to worry about - celebrate this!

**Next Step:** Run full test suite again to confirm no regressions: "Give me test stats"

---

## Integration with Test Runners

### When to Use Skill vs Test Commands

**Use Skill (This) For:**
- Quick status checks
- Filtering and searching
- Test discovery
- Statistics and insights
- Performance analysis

**Use Test Commands For:**
- Running tests
- Watching tests
- Generating coverage
- Debugging specific tests

### Test Runner Commands Reference

The skill recommends these commands when appropriate:

**Jest (JavaScript/TypeScript):**
```bash
# Run all tests
npm test

# Run specific file
npm test -- auth/login.test.js

# Run tests in watch mode
npm test -- --watch

# Run with coverage
npm test -- --coverage

# Run only failed tests
npm test -- --onlyFailures
```

**pytest (Python):**
```bash
# Run all tests
pytest

# Run specific module
pytest tests/auth/

# Run specific test
pytest tests/auth/test_login.py::test_invalid_credentials

# Run with verbose output
pytest -v

# Run only failed tests
pytest --lf
```

**RSpec (Ruby):**
```bash
# Run all tests
rspec

# Run specific file
rspec spec/auth/login_spec.rb

# Run specific test
rspec spec/auth/login_spec.rb:45

# Run only failed tests
rspec --only-failures
```

---

## Examples

### Example 1: Quick Status Check

**User:** "How are my tests doing?"

**Skill:**
```
✅ Looking good! 142/145 tests passing (97.9%)

3 tests failed in the authentication module.
Want to see the failures?
```

---

### Example 2: Module-Specific Failure

**User:** "What failed in auth?"

**Skill:**
```
Authentication module has 3 failures:

❌ login.test.js - Invalid credentials (Expected 401, got 500)
❌ signup.test.js - Email validation not triggered
❌ token.test.js - Token refresh failed

All 3 seem related to API status codes. Check auth/routes.js:67
```

---

### Example 3: Performance Investigation

**User:** "Why are tests so slow?"

**Skill:**
```
Total test time: 42.3s (average: 0.29s per test)

🐌 3 tests taking >1s:
- integration/api-e2e.test.js (5.2s) - external API calls
- auth/login.test.js (2.3s) - database setup
- payments/checkout.test.js (1.8s) - Stripe API mock

Recommendation: Mock external services. This could save ~9s (21%)
```

---

### Example 4: Coverage Check

**User:** "What's our test coverage?"

**Skill:**
```
Test Coverage (from last run):

Lines: 87.3% (2,453 / 2,810)
Branches: 82.1% (445 / 542)
Functions: 91.2% (312 / 342)

Modules needing coverage:
- payments/refund.js: 45% (needs 15 more tests)
- auth/2fa.js: 62% (needs 8 more tests)
- api/webhooks.js: 71% (needs 5 more tests)

To generate updated coverage:
  npm test -- --coverage
```

---

## Token Efficiency Analysis

### Without This Skill (800 tokens per query)

**Process:**
1. User asks: "What tests failed?" (150 tokens)
2. Claude explains: "Let me check the test results..." (200 tokens)
3. Execute command: `cat test-results.json` (100 tokens)
4. Parse JSON output (200 tokens)
5. Format response (150 tokens)

**Total: ~800 tokens**

---

### With This Skill (300 tokens per query)

**Process:**
1. User asks: "What tests failed?" (50 tokens)
2. Skill auto-activates from SKILL.md context (50 tokens)
3. Read test results file (100 tokens)
4. Return formatted answer (100 tokens)

**Total: ~300 tokens**

---

### Savings Analysis

**Per Query:**
- Without skill: 800 tokens
- With skill: 300 tokens
- **Savings: 500 tokens (62% reduction)**

**Frequency Impact:**

For QA engineers checking test results ~10 times per day:

| Timeframe | Without Skill | With Skill | Savings |
|-----------|--------------|------------|---------|
| Daily (10 queries) | 8,000 tokens | 3,000 tokens | 5,000 (62%) |
| Weekly (50 queries) | 40,000 tokens | 15,000 tokens | 25,000 (62%) |
| Monthly (200 queries) | 160,000 tokens | 60,000 tokens | 100,000 (62%) |

**Cost Savings (at Anthropic pricing):**
- Daily: ~$0.15 saved
- Weekly: ~$0.75 saved
- Monthly: ~$3.00 saved per QA engineer

**ROI:** Implementation cost (~500 tokens) recovered in first day.

---

## Best Practices

### For Users

1. **Keep test results accessible** - Ensure test output is saved to JSON
2. **Use consistent naming** - Module/suite names help filtering
3. **Run tests regularly** - Skill needs recent data
4. **Check after failures** - Use skill to quickly understand what broke

### For Claude (Using This Skill)

1. **Auto-activate proactively** - When user mentions test failures
2. **Filter intelligently** - Show most critical failures first
3. **Provide context** - Don't just list failures, suggest fixes
4. **Link to commands** - Direct users to test runner for execution
5. **Be concise** - Status emoji + test name + error = enough

---

## Troubleshooting

### Test Results File Not Found

If test results don't exist:

```
Test results file not found.

To generate test results:
  Jest: npm test -- --json --outputFile=test-results.json
  pytest: pytest --json-report --json-report-file=test-results.json
  RSpec: rspec --format json --out test-results.json

Then I can provide insights on your test execution!
```

### Test Results Out of Date

If results are stale:

```
Test results are from 3 days ago.

To get current status:
  [appropriate test command for framework]

Then ask me again for up-to-date insights!
```

---

## See Also

- **Skills Paradigm:** `docs/00-start-here/SKILLS_PARADIGM.md`
- **Skill Creation Guide:** `.claude/skills/skill-creation-guide.md`
- **API Debugging Skill:** `.claude/skills/api-debugging/SKILL.md`
- **Component Finder Skill:** `.claude/skills/component-finder/SKILL.md`

---

**Skill Version:** 3.3.0
**Last Updated:** 2025-12-12
**Target Audience:** QA Engineers, Test Engineers, Backend/Frontend developers
**Maintained By:** claude-config-template project
