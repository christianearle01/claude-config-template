# Example 2: Production Feature (Vibe Engineering)

## User Message

"We need to add two-factor authentication to our app. We have 10,000 active users and handle sensitive customer data. Timeline is flexible - we can take the time needed to do this right. Our team has 5 engineers."

## Skill Activation

**Trigger detected:** Quality uncertainty (implied: "do this right") + High stakes (authentication, sensitive data)

**Context signals:**
- Permanent (core security feature)
- High risk (security-sensitive, 10k users affected)
- Flexible timeline ("take the time needed")

**Lightweight analysis:**
- Temporary? **No** → Vibe Engineering
- High risk? **Yes** → Vibe Engineering
- Tight timeline? **No** → Vibe Engineering

**Score:** 3/3 signals point to Vibe Engineering

## Skill Response

```
🎯 I noticed you're adding authentication with security and scale considerations.
Let me help you choose the right mode for this task.

Based on what you've described, I recommend: **Strong Vibe Engineering**

Two-factor authentication for 10k users is business-critical and security-sensitive. This absolutely requires comprehensive planning, security review, and extensive testing. Use the full workflow: @prompt-polisher (clarify requirements) → @project-planner (security architecture) → @coder (implementation with tests) → @quality-reviewer (security audit). Taking 4-6 weeks now prevents security breaches later.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

## Expected User Actions

**Vibe Engineering approach:**
- **Week 1:** Requirements analysis + security architecture design
  - TOTP vs SMS vs app-based 2FA decision
  - Backup codes generation and storage
  - Account recovery flow design
  - Security audit of design

- **Week 2-3:** Implementation with comprehensive tests
  - Backend: 2FA enrollment, verification, backup codes
  - Frontend: Setup flow, login flow, recovery flow
  - Unit tests (95%+ coverage)
  - Integration tests (all flows)

- **Week 4:** Security review + staged rollout
  - @quality-reviewer security audit
  - Penetration testing (external firm)
  - Staged rollout: 1% → 10% → 50% → 100%
  - Monitoring/alerting for failures

## Why This Recommendation Is Correct

**Indicators of success:**
- ✅ No security vulnerabilities (audit passed)
- ✅ Zero user lockouts during rollout (tested thoroughly)
- ✅ 10k users secured without incidents (reliable implementation)
- ✅ Team can maintain code (comprehensive documentation)

**If user had chosen Vibe Coding instead:**
- ❌ Security vulnerabilities (SQL injection, session fixation, etc.)
- ❌ Users locked out of accounts (poor error handling)
- ❌ No rollback plan (stuck with broken 2FA)
- ❌ Support ticket flood (didn't test edge cases)

**Lesson:** Security features require Vibe Engineering. Shortcuts = breaches.
