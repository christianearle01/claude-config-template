# Skill Creation Guide - Build Skills with Claude's Help

**Purpose:** Step-by-step guide for creating custom Claude Code Skills with interactive assistance

**Target Audience:** Developers who want to create skills for their specific workflows

---

## Overview

This guide will help you create a custom skill WITH Claude's assistance. You don't need to know all the details upfront - Claude will guide you through the process.

**What you'll create:**
- A SKILL.md file with proper structure
- Supporting documentation (operations guide, examples)
- Integration with existing tools

**Time required:** 30-60 minutes (with Claude's help)

---

## When to Create a Skill

### Good Candidates

✅ **Frequent queries** (5+ times per week)
- "What tests are failing?"
- "Which components use this API?"
- "What's the status of my branches?"

✅ **READ-only operations** (insights, not modifications)
- Checking status
- Finding patterns
- Filtering/searching data

✅ **Natural language queries** (not just commands)
- Users ask conversationally
- Multiple ways to phrase the same question

✅ **Structured data sources** (JSON, logs, config files)
- Data that can be parsed programmatically
- Consistent format

### Poor Candidates

❌ **One-time operations**
❌ **WRITE operations** (use scripts instead)
❌ **Complex mutations**
❌ **Unstructured data**

---

## The 5-Step Process (With Claude)

### Step 1: Define Your Skill Idea

**Start by telling Claude:**
```
"I want to create a skill for [describe what you do frequently].

For example:
- I often check which tests are failing
- I search for which components use a specific API
- I track which branches need merging

The data source is: [JSON file / log files / git status / etc.]"
```

**Claude will ask you:**
1. What queries will users ask? (give 3-5 examples)
2. What data source does it read?
3. What insights should it provide?
4. How does it complement existing tools?

**Your job:** Answer honestly based on your real workflow

---

### Step 2: Collect Real Examples

**Tell Claude:**
```
"Here are 10 real queries I ask:
1. 'What tests failed?'
2. 'Show me all failing tests in the auth module'
3. 'How many tests passed vs failed?'
...
10. 'Which test suite is slowest?'"
```

**Why this matters:**
- Skills are designed around REAL usage, not guesses
- Examples become your skill documentation
- Patterns emerge that guide design

**Claude will:**
- Identify patterns in your queries
- Group similar questions
- Suggest what operations the skill needs

---

### Step 3: Design the Skill Structure

**Claude will propose:**
```
Skill Name: testing-workflow
Purpose: Provide insights on test execution status
Data Source: test-results.json
Key Operations:
  - List failed tests
  - Filter by module/suite
  - Show statistics
  - Identify slow tests
```

**You review and refine:**
- Does this cover your use cases?
- Any missing operations?
- Is the data source correct?

**Claude will then create:**
- Directory structure
- YAML frontmatter
- Section outline

---

### Step 4: Write the Skill (Assisted)

**Claude will write each section, asking for your input:**

**Purpose & Activation:**
```
Claude: "When should this skill activate?
         When users mention 'tests', 'failures', 'test results'?"
You: "Yes, and also 'coverage', 'passing', 'broken tests'"
```

**Core Knowledge:**
```
Claude: "What's the schema of test-results.json?"
You: [Paste or describe the JSON structure]
Claude: [Documents the schema with field descriptions]
```

**Key Operations:**
```
Claude: "For 'What tests failed?', what should the response look like?"
You: "Show test name, module, error message, and file path"
Claude: [Writes operation with example response]
```

**Examples:**
```
Claude: "Let's add your 10 real queries as examples.
         I'll write the responses based on the operations we defined."
[Creates query/response pairs]
```

---

### Step 5: Test and Refine

**Claude will help you test:**
```
"Ask me one of your real queries, and I'll activate the skill"

You: "What tests failed in the auth module?"
Claude: [Uses the skill, shows response]

You: "That works, but can you also show how long each test took?"
Claude: [Updates skill to include duration]
```

**Iterate until:**
- All your queries work
- Responses are helpful
- Token usage is efficient
- Integration with CLI is clear

---

## Interactive Creation Prompts

### Starting Prompt (Copy This)

```
I want to create a Claude Code Skill. Can you help me?

My workflow: [Describe what you do frequently]
Examples:
1. [Real query you ask]
2. [Another real query]
3. [Another real query]

Data source: [What file/command provides the data]

Let's work through this together!
```

### Follow-Up Prompts

**When Claude asks for examples:**
```
Here are more real queries I ask:
[List 10+ actual questions from your workflow]
```

**When Claude proposes structure:**
```
That looks good!
[or]
Can we add [specific operation]?
[or]
The data source is actually [correction]
```

**When testing:**
```
Let's test with this query: [real question]
```

**When refining:**
```
The response works, but can you also [improvement]?
```

---

## Example: Creating a Testing Workflow Skill

### User Starts

```
User: "I want to create a skill for test results.
       I constantly check which tests are failing."

Claude: "Great! Let's build a testing-workflow skill.

         Questions:
         1. What queries do you ask? (Give me 5-10 examples)
         2. Where do test results come from?
            (JSON file? Jest output? pytest results?)
         3. What info do you need in responses?
            (Test names? Error messages? File paths?)"
```

### User Provides Examples

```
User: "My queries:
       1. What tests failed?
       2. Show failing tests in the auth module
       3. How many tests passed vs failed?
       4. Which test suite is slowest?
       5. What's the overall pass rate?

       Source: test-results.json (Jest output)

       Need: Test name, module, status, duration, error if failed"
```

### Claude Designs

```
Claude: "Perfect! Here's the structure:

Skill: testing-workflow
Purpose: Test execution insights
Data: test-results.json
Operations:
  - List failed tests
  - Filter by module/suite
  - Show statistics (pass/fail counts, duration)
  - Identify slow tests (>1s)
  - Calculate pass rate

Sound good? Any changes?"
```

### User Approves

```
User: "Looks great! Can we also add 'recently fixed tests'
       (tests that were failing last run but pass now)?"

Claude: "Excellent idea! Added that operation.

Now I'll create the skill files. This will take a few minutes..."

[Claude creates:
 - .claude/skills/testing-workflow/SKILL.md
 - .claude/skills/testing-workflow/operations.md
 - .claude/skills/testing-workflow/examples/sample-queries.md
 - .claude/skills/testing-workflow/examples/sample-results.json]

Claude: "Skill created! Try asking: 'What tests failed?'"
```

### User Tests

```
User: "What tests failed in the auth module?"

Claude: [Skill activates]
"3 tests failed in the auth module:

❌ auth/login.test.js - 'handles invalid credentials' (2.3s)
   Error: Expected 401, got 500

❌ auth/signup.test.js - 'validates email format' (1.8s)
   Error: Validation not triggered

❌ auth/token.test.js - 'refreshes expired tokens' (0.5s)
   Error: Token still expired after refresh"

User: "Perfect! Can you also show the file paths?"

Claude: "I'll add file paths to the responses..."
[Updates skill]
```

---

## Skill Template (Reference)

When Claude creates your skill, it will look like this:

```markdown
---
name: your-skill-name
description: Clear description triggering automatic activation
allowed-tools: Read, Grep
---

# Your Skill Name

## Purpose & Activation

What it does, when it activates...

## Core Knowledge

Schema, format, key concepts...

## Key Operations

### Operation 1: Name
**User Query:** "Example question"
**Skill Response:** Example answer

### Operation 2: Name
**User Query:** "Another question"
**Skill Response:** Another answer

## Examples

[10+ real query/response pairs]

## Integration

How it works with CLI tools...

## Token Efficiency

Savings analysis...
```

---

## Common Patterns

### Pattern 1: Status Dashboard Skills

**Purpose:** Aggregated status views

**Examples:**
- Test results overview
- Git branch status
- Dependency vulnerabilities
- Build status

**Data Source:** JSON files, git commands, CLI output

**Token Savings:** 50-70% (dashboards avoid multiple queries)

---

### Pattern 2: Search/Discovery Skills

**Purpose:** Find things quickly

**Examples:**
- Component finder (Frontend)
- API endpoint discovery (Backend)
- Test file location (QA)
- Documentation search

**Data Source:** Filesystem, code analysis, tags

**Token Savings:** 60-80% (avoid manual grep/find)

---

### Pattern 3: Comparison Skills

**Purpose:** Before/after analysis

**Examples:**
- Recently fixed tests
- New vs resolved issues
- Performance regressions
- Dependency changes

**Data Source:** Historical logs, diffs, version control

**Token Savings:** 40-60% (avoid manual diffing)

---

## Tips for Success

### 1. Start Simple

Don't try to build everything at once:
```
Phase 1: Core operation (1 week)
Phase 2: Add filtering (1 week)
Phase 3: Add statistics (1 week)
```

### 2. Use Real Data

Test with actual files from your projects:
```
Good: test-results-2025-12-12.json (real output)
Bad: Made-up example data
```

### 3. Iterate Based on Usage

Track which queries you actually ask:
```
Week 1: Asked "what failed?" 15 times ✅ Keep
Week 1: Asked "test coverage?" 0 times ❌ Remove
```

### 4. Measure Token Savings

Before/after comparison:
```
Before skill: "What tests failed?" = 800 tokens
With skill: "What tests failed?" = 300 tokens
Savings: 500 tokens (62%)
```

### 5. Document for Future You

You'll forget details in 6 months:
```
# Why this operation exists
# Real example that triggered this
# Edge case to watch for
```

---

## Troubleshooting

### "Claude isn't activating my skill"

**Problem:** Skill description doesn't match user language

**Fix:** Add more trigger phrases
```yaml
description: Test execution insights. Activates when users
             ask about tests, failures, passes, test results,
             test status, broken tests, failing specs.
```

---

### "Responses are too verbose"

**Problem:** Skill provides too much information

**Fix:** Use progressive disclosure
```
# First response: Summary only
"3 tests failed. Want details?"

# If user asks for details: Full info
[Show complete error messages]
```

---

### "Token usage isn't improving"

**Problem:** Skill re-explains every time

**Fix:** Use structured, concise formats
```
# Bad (200 tokens)
"I've analyzed your test results and found that
 there are 3 tests that have failed..."

# Good (50 tokens)
"3 tests failed:
 - auth/login: 401 error
 - auth/signup: validation
 - auth/token: refresh failed"
```

---

## Next Steps

**After creating your skill:**

1. **Use it for a week**
   - Track which queries you actually ask
   - Note any missing operations
   - Measure token savings

2. **Refine based on usage**
   - Add frequently-asked queries
   - Remove unused operations
   - Optimize responses

3. **Share with team** (if applicable)
   - Document setup instructions
   - Add team-specific examples
   - Collect feedback

4. **Create complementary skills**
   - Skills work better together
   - Cross-reference between skills
   - Build a skill ecosystem

---

## Getting Help

**If you get stuck, ask Claude:**

```
"I'm creating a [skill-name] skill but I'm stuck on [specific problem].

Here's what I have so far: [description]
Here's what's not working: [specific issue]

Can you help me figure this out?"
```

**Claude can help with:**
- ✅ Designing skill structure
- ✅ Writing YAML frontmatter
- ✅ Creating examples
- ✅ Optimizing responses
- ✅ Measuring token savings
- ✅ Debugging activation issues

---

## Example Skills to Study

### 1. Projects Registry Skill
**Location:** `.claude/skills/projects-registry/`
**Learn:** How to filter, search, provide recommendations

### 2. Testing Workflow Skill (included)
**Location:** `.claude/skills/testing-workflow/`
**Learn:** How to parse test results, show statistics

### 3. API Debugging Skill (included)
**Location:** `.claude/skills/api-debugging/`
**Learn:** How to analyze logs, trace requests

### 4. Component Finder Skill (included)
**Location:** `.claude/skills/component-finder/`
**Learn:** How to search codebases, show dependencies

---

## See Also

- [Skills Paradigm](../../docs/01-fundamentals/02_skills-paradigm.md) - Conceptual overview
- [Projects Registry Skill](projects-registry/SKILL.md) - First reference implementation
- [QUICK_REFERENCE.md](../../docs/00-start-here/09_quick-reference.md#skills) - Quick skill lookup

---

**Ready to create your first skill?**

Just say: "I want to create a Claude Code Skill. Can you help me?" and Claude will guide you through the process!

---

**Version:** 3.3.0
**Last Updated:** 2025-12-12
**Type:** Interactive Guide
