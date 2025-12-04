---
name: test
description: Run project tests with proper reporting
---

Run the test suite for this project:

1. **Find test command:**
   - Check CLAUDE.md "Common Commands" section for test command
   - If not found, check package.json "scripts.test" or look for test configs

2. **Run tests:**
   - Execute the test command
   - Capture full output

3. **Report results:**
   - ✅ **Passed:** [X tests passed]
   - ❌ **Failed:** [X tests failed]
   - 📊 **Coverage:** [X%] (if available)

   **If tests failed:**
   - Show which tests failed
   - Show error messages
   - Offer to help debug the failures

   **If tests passed:**
   - Confirm all tests passed
   - Show coverage percentage if available

4. **Common issues to check:**
   - Missing environment variables
   - Database not running
   - Dependencies not installed
   - Port conflicts

**Example output format:**
```
✅ Test Suite Results

Passed: 127/130 tests
Failed: 3/130 tests
Coverage: 85%

❌ Failed Tests:
1. UserService.createUser - "Database connection timeout"
2. PaymentController.processPayment - "Stripe API key not configured"
3. EmailHelper.sendEmail - "SendGrid credentials missing"

Would you like help debugging these failures?
```

**IMPORTANT:** Only run tests. Do NOT make any code changes unless explicitly asked.
