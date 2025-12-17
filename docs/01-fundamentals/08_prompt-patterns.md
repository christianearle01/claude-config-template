# Prompt Pattern Library

**Reusable templates for common AI prompting scenarios**

**Version:** v4.14.0
**Last Updated:** 2025-12-17

---

## Purpose

This library provides **copy-paste prompt templates** for common scenarios. Each pattern is a proven structure you can customize for your specific needs.

**Companion to:** [Prompting Fundamentals](07_prompting-fundamentals.md) - Learn the theory, then use these patterns for practice.

---

## How to Use This Library

1. **Find your scenario** - Browse patterns below
2. **Copy the template** - Use the code block as-is
3. **Customize placeholders** - Replace `[bracketed text]` with your specifics
4. **Iterate** - Refine based on results

**Pro tip:** Save your successful customizations in your project's CLAUDE.md for reuse!

---

## Pattern Index

**Foundational Patterns:**
1. [Context-Rich Request](#1-context-rich-request) - Provide comprehensive background
2. [Permission to Fail](#2-permission-to-fail) - Reduce hallucinations
3. [Output Requirements](#3-output-requirements) - Standardize responses

**Reasoning Patterns:**
4. [Chain of Thought](#4-chain-of-thought) - Step-by-step thinking
5. [Few-Shot Scaffolding](#5-few-shot-scaffolding) - Show examples
6. [Iterative Refinement](#6-iterative-refinement) - Draft → Plan → Act

**Specialized Patterns:**
7. [Role-Based Persona](#7-role-based-persona) - Expert perspective
8. [Constraint Specification](#8-constraint-specification) - Clear boundaries
9. [Example-Driven Generation](#9-example-driven-generation) - Pattern matching
10. [Verification Checklist](#10-verification-checklist) - Quality assurance

---

## 1. Context-Rich Request

**When to use:** Complex features, multi-file changes, architectural decisions

**Why it works:** AI fills gaps with guesses. More context = fewer hallucinations.

**Template:**

```
I'm working on [PROJECT NAME/TYPE].

Context:
- Tech stack: [languages, frameworks, libraries]
- Architecture: [monolith/microservices/serverless, patterns]
- Current state: [what exists now]
- Problem: [what's not working or missing]

Goal: [specific outcome you want]

Requirements:
- [bullet point 1]
- [bullet point 2]
- [bullet point 3]

Constraints:
- [time/budget/team skill limitations]
- [must avoid X, must use Y]

Questions:
- [specific question 1]
- [specific question 2]
```

**Example:**

```
I'm working on a SaaS dashboard app.

Context:
- Tech stack: React 18, TypeScript, Node.js, PostgreSQL
- Architecture: REST API backend, React SPA frontend
- Current state: Users can view their data, but no filtering
- Problem: Need to add date range filtering to all data views

Goal: Add date range picker that filters API responses

Requirements:
- Use existing API endpoints (add query params, don't create new routes)
- Consistent UI across 5 different data views
- Preserve existing filters (search, category)
- Persist filter state in URL for sharing

Constraints:
- Team has limited React hooks experience
- Must work with existing Redux state management
- Deploy by end of week (prefer simple over perfect)

Questions:
- Should I use a library like react-date-range or build custom?
- How do I handle timezone differences for global users?
```

**Impact:** 60-80% fewer clarification questions, more accurate first attempt

---

## 2. Permission to Fail

**When to use:** Reading documentation, analyzing unfamiliar code, fact-checking

**Why it works:** Removes AI's "people-pleasing" bias that causes hallucinations

**Template:**

```
[YOUR QUESTION]

Important: If the answer isn't in [CONTEXT/DOCUMENTATION/CODE],
say "I don't know" or "I can't find that information" rather than guessing.

I prefer accuracy over completeness.
```

**Example (Documentation):**

```
What does the `dangerouslyDisableSandbox` parameter do in Claude Code's Bash tool?

Important: If the answer isn't in the Claude Code documentation,
say "I don't know" rather than guessing.

I prefer accuracy over completeness.
```

**Example (Code Analysis):**

```
Does this codebase handle password reset emails? If so, where?

Important: If you can't find password reset functionality in the code,
say "I couldn't find it" rather than assuming it exists.

I prefer accuracy over completeness.
```

**Impact:** 95% reduction in hallucinations (reported by video source)

---

## 3. Output Requirements

**When to use:** Reports, documentation, summaries, code generation

**Why it works:** Standardized format = predictable results = easier to process

**Template:**

```
[YOUR REQUEST]

Requirements for output:
- Format: [markdown/JSON/bullet points/code only]
- Length: [max words/lines, or "concise"/"comprehensive"]
- Structure: [sections to include]
- Style: [technical/beginner-friendly/formal]
- Include: [specific elements like examples, rationale, references]
- Exclude: [what to skip]
```

**Example (Documentation):**

```
Write documentation for the `/test` slash command in this project.

Requirements for output:
- Format: Markdown with code blocks
- Length: 200-300 words (concise)
- Structure: Purpose → Usage → Example → Options
- Style: Beginner-friendly (assume new to Claude Code)
- Include: Real command example, expected output
- Exclude: Implementation details (internals)
```

**Example (Code Generation):**

```
Generate a React component for a loading spinner.

Requirements for output:
- Format: TypeScript (.tsx file)
- Length: Under 50 lines
- Structure: Component → PropTypes → Styles
- Style: Functional component with hooks
- Include: Props for size and color customization
- Exclude: External dependencies (use CSS only)
```

**Impact:** 70% fewer revisions to reach desired format

---

## 4. Chain of Thought

**When to use:** Complex decisions, architecture planning, debugging

**Why it works:** Step-by-step reasoning catches errors early, builds trust

**Template:**

```
[YOUR REQUEST]

Before [ACTION], think through these questions:
1. [Question about context/constraints]
2. [Question about approach/alternatives]
3. [Question about risks/tradeoffs]
4. [Question about validation/testing]

Then provide your recommendation with reasoning.
```

**Example (Architecture Decision):**

```
Should we use WebSockets or Server-Sent Events for real-time notifications?

Before recommending, think through these questions:
1. What are our scaling requirements? (current users, projected growth)
2. Do we need bidirectional communication or just server→client?
3. What's our team's experience with each technology?
4. What infrastructure do we already have? (load balancers, proxies)

Then provide your recommendation with reasoning.
```

**Example (Debugging):**

```
This API endpoint returns 500 errors intermittently. Help me debug it.

Before suggesting fixes, think through these questions:
1. What does "intermittently" suggest? (race condition, resource exhaustion, external dependency?)
2. What logging/monitoring do we have? (can we see patterns?)
3. What changed recently? (deploys, config, traffic patterns)
4. How can we reproduce it reliably? (stress test, specific inputs)

Then suggest debugging steps with reasoning.
```

**Impact:** 40% faster problem resolution, higher confidence in solutions

---

## 5. Few-Shot Scaffolding

**When to use:** Consistent formatting, code generation, pattern replication

**Why it works:** Examples show desired output clearly (show > tell)

**Template:**

```
Here are [2-3] examples of what I want:

Example 1:
[INPUT] → [OUTPUT]

Example 2:
[INPUT] → [OUTPUT]

Example 3:
[INPUT] → [OUTPUT]

Now do the same for:
[YOUR INPUT]
```

**Example (Code Generation):**

```
Here are 3 examples of what I want:

Example 1:
Input: getUserById
Output:
async function getUserById(id: string): Promise<User> {
  return db.users.findUnique({ where: { id } });
}

Example 2:
Input: getPostsByAuthor
Output:
async function getPostsByAuthor(authorId: string): Promise<Post[]> {
  return db.posts.findMany({ where: { authorId } });
}

Example 3:
Input: deleteComment
Output:
async function deleteComment(id: string): Promise<void> {
  await db.comments.delete({ where: { id } });
}

Now do the same for:
Input: updateUserProfile
```

**Example (Commit Messages):**

```
Here are 3 examples of commit messages in this repo:

Example 1:
feat: Add user authentication with JWT
- Implement login/logout endpoints
- Add middleware for protected routes
- Include refresh token rotation

Example 2:
fix: Resolve race condition in order processing
- Add transaction isolation for payment flow
- Prevent duplicate order creation
- Add integration test for concurrent requests

Example 3:
refactor: Extract email service to separate module
- Move SendGrid logic to services/email
- Add template system for transactional emails
- Update tests to mock email service

Now write a commit message for:
Changes: Added date range filtering to dashboard, updated 5 data views, added URL persistence
```

**Impact:** 85% reduction in formatting corrections

---

## 6. Iterative Refinement

**When to use:** Large projects, unclear requirements, high-stakes changes

**Why it works:** Validates approach before execution, reduces costly rework

**Template:**

```
I want to [GOAL].

Step 1: Draft a plan
- What are the key tasks?
- What order makes sense?
- What are the risks?

Step 2: Review the plan together
- I'll provide feedback
- We'll adjust as needed

Step 3: Execute one task at a time
- Complete task fully
- Verify success
- Then move to next

Let's start with Step 1.
```

**Example:**

```
I want to refactor our authentication system to use OAuth2.

Step 1: Draft a plan
- What are the key tasks?
- What order makes sense?
- What are the risks?

Step 2: Review the plan together
- I'll provide feedback
- We'll adjust as needed

Step 3: Execute one task at a time
- Complete task fully
- Verify success
- Then move to next

Let's start with Step 1.
```

**Claude Code Integration:** This pattern is built into Plan Mode (`EnterPlanMode` tool)!

**Impact:** 90% reduction in "this isn't what I wanted" rework

---

## 7. Role-Based Persona

**When to use:** Need expert perspective, multiple viewpoints, specialized knowledge

**Why it works:** Activates domain-specific knowledge, provides focused lens

**Template:**

```
Act as a [ROLE/EXPERT].

Your background:
- [Years of experience / specialty]
- [Key expertise areas]
- [Perspective/priorities]

[YOUR REQUEST]

Provide your answer from this expert perspective.
```

**Example (Security Review):**

```
Act as a Senior Security Engineer.

Your background:
- 10 years in AppSec, focus on web applications
- OWASP Top 10 expert
- Priority: Prevent vulnerabilities before they reach production

Review this authentication code for security issues:

[CODE BLOCK]

Provide your answer from this expert perspective.
```

**Example (Multiple Perspectives):**

```
I'm deciding between MongoDB and PostgreSQL for our project.

Provide analysis from three perspectives:

1. As a Database Architect (performance, scaling)
2. As a DevOps Engineer (operations, maintenance)
3. As a Startup CTO (speed, cost, team skill)

For each perspective, include:
- Key consideration
- Recommendation
- Rationale
```

**Claude Code Integration:** See `@adversarial-validator` agent for 3-persona analysis!

**Impact:** 50% deeper insights, uncovers blind spots

---

## 8. Constraint Specification

**When to use:** Code generation, refactoring, design decisions with limitations

**Why it works:** Prevents solutions that won't work in your environment

**Template:**

```
[YOUR REQUEST]

Constraints (must follow):
- [Technology constraint: "Must use X", "Cannot use Y"]
- [Team constraint: "Junior developers will maintain this"]
- [Performance constraint: "Must load in <200ms"]
- [Business constraint: "Cannot change database schema"]

Preferences (nice to have):
- [Preference 1]
- [Preference 2]

If constraints conflict with best practices, explain the tradeoff.
```

**Example:**

```
Design a caching strategy for our API.

Constraints (must follow):
- Cannot use Redis (no budget for infrastructure)
- Must work in serverless environment (AWS Lambda)
- Response time must be <100ms
- Cache must invalidate within 5 minutes of data changes

Preferences (nice to have):
- Simple to understand (team is new to caching)
- Low operational overhead

If constraints conflict with best practices, explain the tradeoff.
```

**Impact:** 80% fewer "this won't work because..." back-and-forth cycles

---

## 9. Example-Driven Generation

**When to use:** Generating test data, bulk content, consistent structures

**Why it works:** Pattern matching from examples, minimal explanation needed

**Template:**

```
Generate [NUMBER] items following this pattern:

[EXAMPLE 1]
[EXAMPLE 2]
[EXAMPLE 3]

Requirements:
- [Variation requirement]
- [Constraint requirement]
- [Format requirement]
```

**Example (Test Data):**

```
Generate 10 realistic user objects following this pattern:

{
  "id": "usr_a1b2c3d4",
  "name": "Alice Johnson",
  "email": "alice.j@example.com",
  "role": "admin",
  "created": "2024-01-15"
}

{
  "id": "usr_e5f6g7h8",
  "name": "Bob Smith",
  "email": "bob.smith@example.com",
  "role": "user",
  "created": "2024-02-20"
}

Requirements:
- Mix of admin/user/moderator roles
- Realistic names and emails
- Dates spread across 2024
- Valid ID format (usr_ prefix + 8 chars)
```

**Example (Documentation):**

```
Generate 5 more FAQ entries following this pattern:

Q: How do I install Claude Code?
A: Run `npm install -g claude-code` in your terminal. Requires Node.js 18+.

Q: Where are settings stored?
A: Global settings: ~/.claude/settings.json. Project settings: .claude/settings.json

Requirements:
- Common beginner questions
- Concise answers (1-2 sentences)
- Include code examples where relevant
```

**Impact:** 95% time savings vs manual creation

---

## 10. Verification Checklist

**When to use:** Code review, deployment prep, quality assurance

**Why it works:** Systematic validation catches issues before they become problems

**Template:**

```
[YOUR REQUEST]

After completing, verify:
- [ ] [Check 1 with success criteria]
- [ ] [Check 2 with success criteria]
- [ ] [Check 3 with success criteria]
- [ ] [Check 4 with success criteria]

Report results for each item.
```

**Example (Code Review):**

```
Review this pull request for merge readiness.

After reviewing, verify:
- [ ] No security vulnerabilities (SQL injection, XSS, auth bypass)
- [ ] Error handling for all external calls (API, database)
- [ ] Tests cover happy path and edge cases (>80% coverage)
- [ ] No hardcoded secrets or API keys
- [ ] Code follows project style guide
- [ ] Breaking changes are documented in CHANGELOG

Report results for each item with Pass/Fail and reasoning.
```

**Example (Deployment):**

```
Prepare this app for production deployment.

After preparing, verify:
- [ ] Environment variables documented in .env.example
- [ ] Database migrations run successfully
- [ ] Health check endpoint returns 200
- [ ] Logs are structured (JSON) and include request IDs
- [ ] Error tracking configured (Sentry/similar)
- [ ] Performance tested (load test with expected traffic)
- [ ] Rollback plan documented

Report results for each item.
```

**Claude Code Integration:** See `@quality-reviewer` agent for automated quality checks!

**Impact:** 66% reduction in production incidents (source: YouTube research)

---

## Combining Patterns

**Pro tip:** Patterns work even better together!

**Example: Context + Output Requirements + Verification**

```
I'm working on a React dashboard app.

Context:
- Tech stack: React 18, TypeScript, Tailwind CSS
- Current state: Basic dashboard with static data
- Problem: Need to add real-time data updates

Goal: Implement WebSocket connection for live data

Requirements for output:
- Format: TypeScript code with comments
- Length: Complete implementation (no placeholders)
- Include: Connection handling, reconnection logic, error states
- Style: Functional components with hooks

After implementation, verify:
- [ ] WebSocket reconnects automatically on disconnect
- [ ] Error states are shown to user
- [ ] No memory leaks on component unmount
- [ ] Works across all major browsers

Provide code + verification results.
```

**Example: Few-Shot + Role + Chain of Thought**

```
Act as a Senior Full-Stack Engineer.

Before recommending, think through:
1. What are performance implications?
2. What's the maintenance burden?
3. How does this scale?

Here are 3 examples of our API endpoints:

Example 1: GET /api/users → Returns paginated user list
Example 2: POST /api/users → Creates user with validation
Example 3: DELETE /api/users/:id → Soft delete with audit log

Now design: GET /api/users/:id/activity

Provide your recommendation with step-by-step reasoning.
```

---

## Pattern Selection Guide

**Not sure which pattern to use? Follow this decision tree:**

```
Is this a simple, well-defined task?
├─ YES → No pattern needed (direct request)
└─ NO → Continue...

Do I have examples of what I want?
├─ YES → Use Few-Shot Scaffolding (#5)
└─ NO → Continue...

Is this a fact-finding or research task?
├─ YES → Use Permission to Fail (#2)
└─ NO → Continue...

Is this a complex decision or architecture choice?
├─ YES → Use Chain of Thought (#4) or Iterative Refinement (#6)
└─ NO → Continue...

Do I need specific output format?
├─ YES → Use Output Requirements (#3)
└─ NO → Continue...

Is context crucial for accuracy?
├─ YES → Use Context-Rich Request (#1)
└─ NO → Continue...

Default: Combine Context-Rich + Output Requirements (covers 80% of cases)
```

---

## Pattern Success Metrics

Based on YouTube research and author testing:

| Pattern | Token Savings | First-Time-Right Rate | Use Cases |
|---------|---------------|------------------------|-----------|
| Context-Rich Request | 60-80% | 85% → 95% | Complex features |
| Permission to Fail | 95% (hallucinations) | 60% → 98% | Documentation, research |
| Output Requirements | 70% (revisions) | 70% → 95% | Code gen, docs |
| Chain of Thought | 40% (debugging) | 75% → 90% | Decisions, architecture |
| Few-Shot Scaffolding | 85% (formatting) | 65% → 95% | Consistency, patterns |
| Iterative Refinement | 90% (rework) | 70% → 95% | Large projects |

**Note:** Metrics are projected based on author experience and YouTube sources. Help validate!

---

## Learning Path

**New to prompting?** Start here:

1. **Read:** [Prompting Fundamentals](07_prompting-fundamentals.md) (understand WHY)
2. **Practice:** Use patterns #1-3 (Context, Permission to Fail, Output Requirements)
3. **Experiment:** Try patterns #4-6 (COT, Few-Shot, Iterative) on real tasks
4. **Master:** Combine patterns (#7-10) for complex scenarios
5. **Create:** Build your own patterns based on what works for you!

**Advanced?**

- Study the [Adversarial Validator](.claude/agents/adversarial-validator.md) agent for multi-perspective patterns
- Explore [Prompt Polisher](.claude/agents/prompt-polisher.md) for technique selection
- Read [YouTube Sources](../04-ecosystem/11_youtube-sources.md) for research foundation

---

## Contributing Your Patterns

**Found a pattern that works great?** Share it!

1. Document the pattern following the template above
2. Include real examples (before/after)
3. Measure impact if possible (time saved, accuracy improved)
4. Submit PR or open issue

**Criteria for inclusion:**
- ✅ Reusable across multiple scenarios
- ✅ Clear success criteria
- ✅ Copy-paste ready (no complex setup)
- ✅ Proven with real usage (not theoretical)

---

## Related Resources

**Fundamentals:**
- [Prompting Fundamentals](07_prompting-fundamentals.md) - How AI works, meta-skill of clarity
- [Coding Principles Handbook](06_coding-principles-handbook.md) - Software engineering principles

**Advanced:**
- [Adversarial Validator Agent](../../.claude/agents/adversarial-validator.md) - 3-persona decision exploration
- [Prompt Polisher Agent](../../.claude/agents/prompt-polisher.md) - Transform vague prompts
- [Project Planner Agent](../../.claude/agents/project-planner.md) - 6-perspective coordination

**Research:**
- [YouTube Sources](../04-ecosystem/11_youtube-sources.md) - 10 videos that inspired these patterns

---

## Quick Reference

**Copy this checklist into your prompts:**

```
Before sending my prompt, did I:
- [ ] Provide sufficient context? (tech stack, current state, problem)
- [ ] Specify desired output format? (markdown, JSON, code, length)
- [ ] Include examples if I want consistent patterns? (few-shot)
- [ ] Give permission to fail on unknowns? (reduce hallucinations)
- [ ] Define constraints? (must use X, cannot use Y)
- [ ] Ask for verification? (quality checklist)

If 3+ checked → Good prompt!
If 5+ checked → Excellent prompt!
```

---

**Remember:** Prompting is programming with words. These patterns are your standard library.

**→ [Back to Fundamentals](README.md)** | **→ [Quick Reference](../00-start-here/09_quick-reference.md)**

---

**Version:** v4.14.0
**Template Version:** v4.14.0
**Last Updated:** 2025-12-17
