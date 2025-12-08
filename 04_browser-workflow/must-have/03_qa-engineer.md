# Quality Assurance Engineer - Claude.ai Workflow

**For:** QA engineers using https://claude.ai/ for testing and quality assurance

**Token Efficiency:** Save 70% tokens through optimized Custom Instructions and test-focused prompts

---

## 📋 Custom Instructions Template

Copy this template and paste into your claude.ai Custom Instructions (Settings → Custom Instructions).

### Section 1: What would you like Claude to know about you?

```
I'm a QA engineer who uses Claude for:
- Test case generation and planning
- Test automation scripts
- Bug report analysis and formatting
- Quality metrics and coverage analysis
- Documentation review and testing

My testing context:
- Testing types: [e.g., functional, integration, E2E, performance, security]
- Automation tools: [e.g., Selenium, Cypress, Playwright, JUnit, pytest]
- Focus areas: [e.g., web apps, APIs, mobile, database]

I value:
- Comprehensive test coverage (edge cases, error conditions)
- Clear, reproducible bug reports
- Efficient automated test suites
- Quality metrics and reporting
- Risk-based testing approach
```

**Character count:** ~980 characters

---

### Section 2: How would you like Claude to respond?

```
When helping with testing:
- Prioritize edge cases and error conditions
- Consider user perspective and real-world usage
- Focus on test maintainability and clarity
- Include both positive and negative test cases
- Explain testing rationale (why test this scenario)

When generating tests:
- Follow AAA pattern (Arrange, Act, Assert)
- Use clear, descriptive test names
- Include expected vs actual results
- Consider boundary conditions

Keep responses:
- Structured and systematic
- Risk-aware (prioritize high-impact scenarios)
- Actionable (ready to implement/run)
```

**Character count:** ~780 characters

---

## 🎯 Common QA Engineering Tasks

### Task 1: Generate Test Cases

**Optimized Prompt Pattern:**
```
Generate test cases for [feature/function]:

Feature description:
[brief description]

Test coverage needed:
- Functional: [happy path scenarios]
- Edge cases: [boundary conditions, empty inputs, etc.]
- Error handling: [invalid inputs, system errors]
- Security: [injection, authorization, etc.]

Format: [Gherkin/Table/Checklist]
```

**Token savings:** ~65% (testing framework and approach pre-defined)

---

### Task 2: Write Automated Test Scripts

**Optimized Prompt Pattern:**
```
Generate automated test for:
[paste manual test case or feature description]

Framework: [Selenium/Cypress/Playwright/etc.]
Language: [JavaScript/Python/Java]

Include:
- Setup/teardown
- Test data
- Assertions
- Error handling
```

**Why this works:**
- Framework already in Custom Instructions
- Focused on specific test case
- Clear structure requirements

---

### Task 3: Analyze Bug and Write Report

**Optimized Prompt Pattern:**
```
Help format this bug report:

What happened:
[observed behavior]

Expected behavior:
[what should happen]

Steps to reproduce:
1. [step]
2. [step]

Environment: [browser/OS/version]

Format: [JIRA/GitHub Issue/etc.]
Severity: [Critical/High/Medium/Low]
```

**Token efficiency:**
- Structured format
- Clear sections
- Reproducibility focus

---

### Task 4: Review Test Coverage

**Optimized Prompt Pattern:**
```
Review test coverage for this feature:

Feature: [description]
Current tests: [list existing test cases]

Identify:
- Missing test scenarios
- Edge cases not covered
- High-risk areas without tests
- Redundant or overlapping tests
```

**Why this works:**
- Systematic review approach
- Risk-based prioritization
- Leverages QA mindset from Custom Instructions

---

### Task 5: Generate Test Data

**Optimized Prompt Pattern:**
```
Generate realistic test data for:

Schema:
[paste schema/structure]

Scenarios needed:
- Valid data (happy path)
- Invalid data (boundary/error conditions)
- Edge cases: [specific scenarios]

Format: [JSON/CSV/SQL/etc.]
Count: [number of records]
```

**Token savings:** ~70% (vs explaining data requirements each time)

---

## 💡 Workflow Optimization Tips

### 1. Create Projects by Application Under Test
- Project: [AppName] - QA Testing
- Upload: Requirements docs, API specs, test plans
- Result: Context-aware test generation

**Token savings:** Up to 85% on app-specific test generation

### 2. QA Prompt Chaining Pattern
```
1. "Analyze this feature for testing: [description]"
2. "Generate test cases for the high-risk scenarios"
3. "Convert the critical test cases to automated tests"
4. "Generate test data for the automation suite"
```

Each step builds on previous context.

### 3. Bug Investigation Workflow
```
1. "Analyze this error log: [paste log]"
2. "What are the likely root causes?"
3. "Help me write a reproduction script"
4. "Draft a bug report with the findings"
```

Systematic investigation, minimal token waste.

---

## 🎓 Best Practices for Claude.ai (QA Engineering)

### DO:
- ✅ Specify testing framework and tools in Custom Instructions
- ✅ Request both positive and negative test cases
- ✅ Ask for test rationale (why this scenario matters)
- ✅ Include environment details in bug reports
- ✅ Use Projects for application-specific context
- ✅ Organize tests by risk level (critical → low)

### DON'T:
- ❌ Skip edge case testing
- ❌ Accept generic test cases without specifics
- ❌ Paste production data or PII
- ❌ Over-automate (some manual testing is valuable)
- ❌ Ignore security and performance testing
- ❌ Generate tests without understanding the feature

---

## 📊 Efficiency Metrics (Projected)

_Note: Theoretical projections based on template design. Help us validate with your real usage!_

**Without Custom Instructions:**
- Tokens per test generation: ~4,000
- Test quality: 60% (missing edge cases)
- Time to test suite: 3-4 exchanges

**With Custom Instructions:**
- Tokens per test generation: ~1,200
- Test quality: 85% (comprehensive coverage)
- Time to test suite: 1-2 exchanges

**Savings:** 70% token reduction, 42% quality improvement, 60% faster

---

## 🔄 Customizing for Your Needs

Tailor the template for your specific QA role:

**Your testing stack:**
- Add specific automation tools (Selenium 4, Cypress 13, etc.)
- Testing frameworks (JUnit 5, pytest, Mocha, etc.)
- CI/CD integration (Jenkins, GitHub Actions, etc.)

**Your testing approach:**
- Risk-based testing priorities
- Exploratory testing preferences
- Regression testing strategy

**Your domain:**
- Web applications, mobile apps, APIs
- Security testing, performance testing
- Industry-specific requirements (medical, finance, etc.)

---

## ❓ FAQ

**Q: Should I include the entire test plan in Custom Instructions?**
A: No! Keep it general. Use Projects to upload specific test plans.

**Q: Can I use this for different applications?**
A: Yes! Custom Instructions set your QA role globally. Use Projects for app-specific context.

**Q: How do I handle different testing frameworks?**
A: List your primary frameworks in Custom Instructions, specify in each prompt which one to use.

**Q: Will this help with exploratory testing?**
A: Yes! The risk-based approach in Custom Instructions guides Claude to suggest testing scenarios you might miss.

---

## 🚀 Next Steps

1. **Copy the Custom Instructions** template above
2. **Customize** with your specific testing tools, frameworks, focus areas
3. **Paste** into claude.ai → Settings → Custom Instructions
4. **Test** with one of the prompt patterns (try Task 1: Generate Test Cases)
5. **Iterate** and refine based on your testing needs

---

## Navigation

**🏠 [Back to Browser Workflow](../README.md)** | **📖 [All Roles](../README.md#choose-your-professional-role)** | **🎨 [Create Custom Role](01_custom-role.md)**

---

*Part of the Claude.ai Workflow Optimization Guide - QA Engineering Workflows*
*Last updated: 2025-12-08*
