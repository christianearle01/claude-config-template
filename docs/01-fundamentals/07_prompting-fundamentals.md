# Prompting Fundamentals: Programming with Words

**The Meta-Skill:** Clarity of thought is the foundation of effective prompting. If your thinking is unclear, your prompt will be unclear, and the AI's output will be garbage.

**Core Realization:** A prompt is not a question—it's a program written with words that instructs the AI exactly what to do.

---

## 📖 Table of Contents

- [How AI Actually Works](#how-ai-actually-works) - Prediction engine, not magic
- [The Meta-Skill of Clarity](#the-meta-skill-of-clarity) - Think clearly → prompt clearly
- [Prompting is Programming](#prompting-is-programming) - Call to action, not question
- [Permission to Fail](#permission-to-fail) - The #1 hallucination fix
- [Context is King](#context-is-king) - Never assume AI knows
- [Few-Shot > Zero-Shot](#few-shot--zero-shot) - Show, don't tell
- [When to Use Chain of Thought](#when-to-use-chain-of-thought) - Decision tree
- [Draft → Plan → Act](#draft--plan--act) - Why plan mode exists
- [Quick Reference](#quick-reference) - Cheat sheet

---

## How AI Actually Works

### The Prediction Engine Model

**What AI Really Is:**
- Large Language Models (LLMs) are **statistical prediction engines**
- They're "super advanced autocomplete" that predicts the most likely next tokens
- Every response is a **guess** based on patterns in training data
- **Not** magic, **not** sentient, **not** your friend

**How Prediction Works:**

```
Your prompt: "Write a function to"
AI predicts: " calculate..." (70% probability)
         or: " validate..." (15% probability)
         or: " fetch..." (10% probability)
         or: [hundreds of other options] (5% total)

AI chooses highest probability path
```

**Why This Matters:**

1. **Vague Input = Random Output**
   - If your prompt is ambiguous, AI guesses from multiple high-probability options
   - You get inconsistent results because different guesses happen each time

2. **Focused Input = Predictable Output**
   - Clear, specific prompts narrow the probability distribution
   - AI has fewer high-probability options → more consistent results

3. **You're "Hacking the Probability"**
   - Good prompting = steering probability toward desired outcome
   - Context, examples, and constraints all shape the probability distribution

**Example:**

```
❌ Bad (vague): "Make this better"
→ AI guesses: Better how? Performance? Readability? Security?
→ 100 possible interpretations

✅ Good (specific): "Refactor this function to reduce time complexity from O(n²) to O(n)"
→ AI knows: Optimize algorithm, focus on Big O, maintain functionality
→ 3-5 likely interpretations
```

**Mental Model Shift:**

| Wrong Mental Model | Correct Mental Model |
|-------------------|---------------------|
| AI "understands" me | AI predicts based on patterns |
| AI is intelligent | AI is a probability calculator |
| AI knows things | AI was trained on text up to cutoff date |
| AI will figure it out | AI will guess if unclear |

**Takeaway:** Treat AI as a powerful but literal tool. It does what you tell it, not what you mean.

---

## The Meta-Skill of Clarity

### Think Clearly → Prompt Clearly

**The Fundamental Problem:**

> "If your thinking is messy, your prompt will be messy, resulting in garbage output."

**Why Clarity Matters:**

- AI can only be as clear as you are
- Unclear thinking → vague prompts → AI guesses → garbage output
- **The skill issue is yours, not the AI's**

**The Clarity Test:**

Before writing any prompt, ask yourself:

1. ✅ **Can I describe exactly what I want to a colleague?**
   - If yes: You have clarity, proceed with prompt
   - If no: Spend time clarifying your thinking first

2. ✅ **Can I describe the desired outcome in concrete terms?**
   - Not: "Make it better" (vague)
   - But: "Reduce function complexity from 50 lines to under 20 while maintaining all functionality" (concrete)

3. ✅ **Do I know what success looks like?**
   - If you can't recognize a good result, neither can AI
   - Define success criteria before prompting

**How to Develop Clarity:**

**Step 1: Red Team Your Own Idea**

Before prompting, write a self-description:

```
Bad process:
1. Have vague idea
2. Immediately ask AI
3. Get vague result
4. Frustrated

Good process:
1. Have vague idea
2. Write down: "What am I trying to accomplish? What does success look like?"
3. Refine until clear
4. NOW prompt AI
5. Get focused result
```

**Step 2: Use the "Explain to a Rubber Duck" Method**

- Pretend you're explaining your task to someone who knows nothing
- If you can't explain it clearly, your thinking isn't clear yet
- This is **why** you struggle with prompting

**Step 3: Break Down Complexity**

Complex tasks need decomposition:

```
❌ Unclear prompt:
"Build a user authentication system"

✅ Clear breakdown:
1. "Design a database schema for users (email, hashed password, created_at)"
2. "Write a registration endpoint that validates email format and password strength"
3. "Implement password hashing with bcrypt"
4. "Create login endpoint that returns JWT token"
5. "Add middleware to verify JWT on protected routes"
```

**Example: From Messy Thinking to Clear Prompt**

**Messy thinking:**
- "I need to make my code faster"
- "Users are complaining"
- "Something is slow"

**Clarifying questions:**
- What specific operation is slow?
- How slow? (2 seconds? 20 seconds?)
- What's the acceptable threshold?
- What causes the slowness? (Database? Algorithm? Network?)

**Clear prompt:**
```
"My user search function takes 15 seconds to return results from a
database with 1M users. The query uses a linear scan through all
records. I need to reduce this to under 2 seconds. Here's the current
code: [code]. Please suggest indexing strategies and query optimizations."
```

**The Clarity Hierarchy:**

1. **Level 1:** "Fix this" (no clarity)
2. **Level 2:** "This is slow, make it faster" (some context)
3. **Level 3:** "Optimize this search function" (clear action)
4. **Level 4:** "Reduce search time from 15s to <2s using indexing" (measurable goal)
5. **Level 5:** "Add B-tree index on email column, refactor linear scan to indexed lookup, maintain <2s response for 1M records" (specific solution direction)

**Aim for Level 4 minimum.** Level 5 is when you already know the solution and just need implementation.

**Takeaway:** Spend 5 minutes clarifying your thinking. Save 50 minutes of back-and-forth with AI.

---

## Prompting is Programming

### Reframe: From Questions to Instructions

**The Mindset Shift:**

| Old Mindset (Questions) | New Mindset (Programming) |
|------------------------|---------------------------|
| "Can you help me?" | "Execute this task:" |
| "What do you think?" | "Analyze using these criteria:" |
| Hoping AI understands | Instructing AI precisely |
| Conversational | Command-driven |

**A Prompt is a Program:**

```javascript
// Traditional programming
function calculateTax(income, rate) {
  return income * rate;
}

// Prompting as programming
"Calculate tax for $50,000 income at 22% rate.
Return: dollar amount rounded to 2 decimals."
```

Both are instructions. Both need precision.

**The Call to Action:**

Every prompt should contain:

1. **Context:** What you're working on
2. **Goal:** What you want to achieve
3. **Constraints:** Requirements, limitations
4. **Output format:** How you want the result

**Examples:**

❌ **Question-based (vague):**
```
"How do I make my React app faster?"
```

✅ **Program-based (precise):**
```
"I'm working on a React dashboard with 10,000 data points rendering in a table.
Goal: Reduce initial render time from 3s to <500ms.
Constraints: Must keep all data visible, can't use pagination.
Suggest: Virtualization techniques with code examples."
```

❌ **Question-based:**
```
"What's wrong with this code?"
```

✅ **Program-based:**
```
"Debug this authentication function. It returns 401 even with valid credentials.
Context: Express.js API, bcrypt password hashing, JWT tokens.
Error: 'Invalid credentials' on line 47.
Expected: Return JWT token on successful login.
Provide: Root cause analysis + fixed code."
```

**Anatomy of a Good Prompt:**

```
[CONTEXT] I'm building a Next.js e-commerce site

[GOAL] Implement product search with autocomplete

[REQUIREMENTS]
- Search must work on title, description, tags
- Show top 5 results as user types
- Debounce input (300ms)
- Highlight matching text

[CONSTRAINTS]
- Must use existing PostgreSQL database
- Cannot add new dependencies
- Response time <200ms

[OUTPUT]
- API endpoint code
- Frontend React component
- Database query optimization
```

**Prompt Templates:**

**For Code Generation:**
```
"Task: [What to build]
Context: [Current tech stack, existing code]
Requirements: [Feature list]
Constraints: [What NOT to do, limitations]
Output: [Code structure, comments, tests?]"
```

**For Code Review:**
```
"Review this [language] code for:
- [Criterion 1: e.g., security vulnerabilities]
- [Criterion 2: e.g., performance issues]
- [Criterion 3: e.g., code style violations]

Code: [paste code]

Return: Issue list with severity (high/medium/low) + fix suggestions"
```

**For Debugging:**
```
"Debug: [What's broken]
Expected behavior: [What should happen]
Actual behavior: [What actually happens]
Error message: [Full error text]
Context: [Relevant code, environment]
Tried: [What you've already attempted]

Provide: Root cause + solution"
```

**Takeaway:** Stop asking questions. Start writing programs with words.

---

## Permission to Fail

### The #1 Hallucination Fix

**The Problem:**

AI is trained to be helpful. If you ask a question and it doesn't know the answer, it **will lie** to please you.

**Why This Happens:**

- AI predicts what a "helpful assistant" would say
- "I don't know" seems unhelpful
- Making something up seems more helpful
- AI has no concept of truth, only patterns

**The Solution:**

**Explicitly give permission to fail:**

```
"If the answer isn't in the context I provide, say 'I don't know'
rather than guessing. Never make up information."
```

**Before vs After:**

❌ **Without permission to fail:**
```
User: "What's the bug fix in version 2.3.7 of our internal library?"
AI: "Version 2.3.7 fixed a memory leak in the cache invalidation module..."
[HALLUCINATION - AI has no access to your internal library]
```

✅ **With permission to fail:**
```
User: "Based on this changelog [paste], what's the bug fix in version 2.3.7?
If it's not in the changelog, say 'I don't know'."

AI: "I don't know - version 2.3.7 is not mentioned in the provided changelog."
[HONEST - AI admits it doesn't have the information]
```

**When to Use Permission to Fail:**

1. **Reading documentation:** "Based ONLY on this README, ..."
2. **Analyzing code:** "Based on the code I've shared, ..."
3. **Factual questions:** "If you're not certain, say 'I don't know'"
4. **Sensitive decisions:** "Only proceed if you find explicit evidence in the context"

**Pattern Library:**

**For Documentation:**
```
"Read this documentation: [paste]

Answer: [question]

IMPORTANT: Base your answer ONLY on the provided documentation.
If the answer isn't explicitly stated, respond with 'I don't know'
rather than inferring or guessing."
```

**For Code Analysis:**
```
"Analyze this code: [paste]

Question: [specific question]

If the answer requires information not present in the code
(like external dependencies or config files), say 'I need to see
[specific file]' rather than assuming."
```

**For Uncertain Scenarios:**
```
"[Task description]

If you're not confident in your answer (>80% certainty),
say so explicitly and explain what additional information
would help you provide a better response."
```

**Building Trust Through Honesty:**

**Bad interaction (leads to distrust):**
```
User: "Does our API support webhooks?"
AI: "Yes, it supports webhooks via POST to /api/webhooks endpoint"
[User tries, doesn't work, loses trust in AI]
```

**Good interaction (builds trust):**
```
User: "Does our API support webhooks? Here's the docs: [paste]"
AI: "I don't see webhook support mentioned in the provided documentation.
To confirm, I'd need to see:
- API endpoint documentation
- Or the API routes file
- Or the OpenAPI/Swagger spec"
[User appreciates honesty, provides more context]
```

**The Honesty Principle:**

> **One honest "I don't know" builds more trust than ten confident hallucinations.**

**Red Flags (AI is probably hallucinating):**

- 🚩 Overly confident about specific version numbers without seeing them
- 🚩 Citing exact file paths you haven't shared
- 🚩 "I checked the database and..." (AI can't check databases)
- 🚩 Specific dates/times when you didn't provide them
- 🚩 Exact error messages you didn't share

**Takeaway:** Always give AI permission to say "I don't know". It's the #1 fix for hallucinations.

---

## Context is King

### Never Assume AI Knows Anything

**The Golden Rule:**

> "Any information you don't provide will be filled in by the AI through guessing"

**Why Context Matters:**

1. **LLMs are frozen in time** - Trained up to a specific date, no knowledge after
2. **LLMs don't see your screen** - Can't see your code, files, errors unless you share
3. **LLMs don't remember everything** - Even in a conversation, context can be lost
4. **LLMs can't access external resources** - Unless given tools like web search

**What AI Doesn't Know (Unless You Tell It):**

❌ Your project structure
❌ Your tech stack version
❌ Your environment (OS, Node version, etc.)
❌ Your constraints (time, budget, team size)
❌ Your existing code
❌ Your data schema
❌ Your company policies
❌ Your past conversations (in a new session)
❌ Current date/time
❌ Current events
❌ Your specific error messages

**The Context Checklist:**

Before every prompt, ask:

- ✅ Did I describe **what** I'm building?
- ✅ Did I specify **which** versions/frameworks?
- ✅ Did I share **relevant code**?
- ✅ Did I explain **why** I need this?
- ✅ Did I state **constraints**?
- ✅ Did I define success criteria?

**Context Levels:**

**Level 1: Minimal (often insufficient)**
```
"Fix this bug"
```

**Level 2: Basic (better, but AI still guesses)**
```
"Fix this authentication bug in my Express app"
```

**Level 3: Good (AI has what it needs)**
```
"Fix this authentication bug in my Express.js v4.18 app.
Bug: Users with valid JWT tokens get 401 on /api/profile
Code: [paste middleware code]
Error: 'Invalid token' even though token signature is valid"
```

**Level 4: Excellent (AI has full picture)**
```
"Fix this authentication bug in my Express.js v4.18 app.

Context:
- Using jsonwebtoken ^9.0.0
- JWT secret stored in .env as JWT_SECRET
- Tokens have 24h expiration
- Using middleware from: [paste code]

Bug:
- Route: GET /api/profile (protected)
- Expected: Return user data for valid JWT
- Actual: 401 "Invalid token"
- Token structure: [paste decoded token]

Environment:
- Node v18.16.0
- Running on macOS
- Both dev and production show same issue

Tried:
- Verified JWT_SECRET matches in .env
- Checked token hasn't expired
- Token signature validates in jwt.io

Need: Root cause + fix"
```

**Context Optimization for This Template:**

**Why CLAUDE.md Exists:**

```
Without CLAUDE.md:
Every session: "What's your tech stack? What are you building?
What's your file structure?" (500+ tokens per session)

With CLAUDE.md:
AI reads: "Here's everything about my project" (200 tokens, once)
```

**How to Provide Context Efficiently:**

1. **Project-level:** Use CLAUDE.md (read once per session)
2. **File-level:** Share relevant code (not entire codebase)
3. **Task-level:** Explain specific problem
4. **Goal-level:** Define success criteria

**Examples of Good Context:**

**For Bug Fixing:**
```
Context: [Paste CLAUDE.md or describe project]
File: src/auth/middleware.js (full code below)
Bug: [Describe issue]
Error: [Paste full error message including stack trace]
Expected vs Actual: [Be specific]
Environment: Node v[x], OS: [x], Browser: [x] (if applicable)
```

**For Feature Building:**
```
Context: Building [what] using [tech stack]
Current state: [Describe existing functionality]
Goal: Add [specific feature]
Requirements: [Bullet list]
Constraints: [What you CAN'T do]
Integration: How this fits with existing code
```

**For Code Review:**
```
Context: [Project type]
Code to review: [Paste code]
Review criteria: [Security? Performance? Style?]
Standards: [Link to or paste coding standards]
Additional context: [Why this code exists, what it does]
```

**The "Assume Nothing" Principle:**

❌ **Assuming AI knows:**
```
"The API isn't working"
```

✅ **Providing context:**
```
"GET request to https://api.example.com/users/123 returns 404
Expected: 200 with user data
API docs: [link or paste]
Request headers: [paste]
My code: [paste fetch/axios call]
curl test: [paste curl command and output]"
```

**Takeaway:** Context is your superpower. The more relevant context you provide, the better the output.

---

## Few-Shot > Zero-Shot

### Show, Don't Tell

**The Problem with Describing:**

When you **describe** what you want (zero-shot):
- AI has to guess the format, style, tone
- You get variations each time
- Often not quite right

When you **show examples** (few-shot):
- AI matches the pattern
- Consistent output
- Much less room to guess

**The Pattern:**

```
Few-shot prompting formula:
1. Show 2-3 examples of desired output
2. Then ask AI to do the same for your input
3. AI pattern-matches rather than guesses
```

**Example: Zero-Shot vs Few-Shot**

❌ **Zero-shot (describing):**
```
"Write commit messages that are concise and follow conventional commits style"

Result:
- "Updated code"
- "feat: add new feature to handle edge cases in authentication"
- "fix issue with login"
[Inconsistent - AI guessed different interpretations]
```

✅ **Few-shot (showing):**
```
"Write commit messages following these examples:

Example 1:
feat: add JWT token refresh endpoint

Example 2:
fix: resolve race condition in user cache

Example 3:
docs: update API authentication guide

Now write a commit message for: Added password reset functionality"

Result:
"feat: add password reset functionality"
[Consistent - AI matched the pattern]
```

**When Few-Shot is Most Valuable:**

1. **Formatting:** Specific output structure
2. **Style:** Tone, verbosity, technical level
3. **Code patterns:** Consistent coding style
4. **Data transformation:** Input → Output examples
5. **Complex structures:** JSON, YAML, specific schemas

**Few-Shot Templates:**

**For Code Generation:**
```
"Generate functions following these examples:

Example 1:
// Input: "validate email"
function validateEmail(email) {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}

Example 2:
// Input: "validate phone"
function validatePhone(phone) {
  const regex = /^\d{3}-\d{3}-\d{4}$/;
  return regex.test(phone);
}

Now generate:
// Input: "validate URL"
[your function here]"
```

**For Data Transformation:**
```
"Transform data following this pattern:

Example 1:
Input: { firstName: "John", lastName: "Doe", age: 30 }
Output: "John Doe (30)"

Example 2:
Input: { firstName: "Jane", lastName: "Smith", age: 25 }
Output: "Jane Smith (25)"

Transform this:
Input: { firstName: "Bob", lastName: "Johnson", age: 45 }
Output: ?"
```

**For Documentation:**
```
"Write API documentation following this style:

Example 1:
**GET /api/users/:id**
Returns user profile data.

Parameters:
- id (integer, required): User ID

Response (200):
{ "id": 1, "name": "John", "email": "john@example.com" }

Response (404):
{ "error": "User not found" }

Now document:
POST /api/users
[Creates new user]"
```

**The Power of Examples:**

**Theory (zero-shot):**
```
"Write concise, technical documentation"
[AI guesses what "concise" and "technical" mean]
```

**Practice (few-shot):**
```
"Documentation example 1: [show example]
Documentation example 2: [show example]
Now write docs for: [your thing]"
[AI sees exactly what you want]
```

**Few-Shot in This Template:**

This template uses few-shot prompting:

- **Agents:** Show structured output examples in system prompts
- **Skills:** Provide operation examples in SKILL.md
- **Cheat sheets:** Show command examples, not just describe them
- **This guide:** Shows examples, not just explains concepts

**How to Build Your Own Few-Shot Examples:**

1. **Do it yourself once** - Create the perfect example manually
2. **Do it 2-3 more times** - Establish the pattern
3. **Now use few-shot** - Let AI replicate your pattern

**Scaling Few-Shot:**

- **2-3 examples:** Usually enough
- **5+ examples:** For very complex patterns
- **1 example:** Better than zero, but less reliable

**Takeaway:** Stop describing what you want. Show 2-3 examples and let AI match the pattern.

---

## When to Use Chain of Thought

### Decision Tree for COT

**What is Chain of Thought (COT)?**

Asking AI to "think step by step" before providing an answer.

**Why It Works:**

- Forces AI to reason through the problem
- Catches errors in logic before final answer
- Increases accuracy for complex tasks
- Makes reasoning visible (trust building)

**The Decision Tree:**

```
Is the task complex?
├─ No (simple, straightforward)
│  → Skip COT (not needed)
│  → Example: "What's 2+2?"
│
└─ Yes (complex, multi-step)
   │
   ├─ Does it require reasoning?
   │  ├─ No → Skip COT
   │  │  → Example: "Copy this code to new file"
   │  │
   │  └─ Yes → Use COT
   │     │
   │     ├─ Multiple correct paths?
   │     │  → Use Trees of Thought (multiple COT)
   │     │
   │     └─ Single correct path?
   │        → Use standard COT
```

**When to Use COT:**

✅ **Yes, use COT:**
- Debugging complex issues
- Architecture decisions
- Algorithm design
- Trade-off analysis
- Multi-step problem solving
- Security review
- Performance optimization
- Refactoring large code

❌ **No, skip COT:**
- Simple CRUD operations
- Straightforward copy/paste tasks
- Obvious transformations
- Well-defined, single-step tasks

**COT Patterns:**

**Pattern 1: Explicit Instruction**
```
"Before answering, think through these steps:
1. Identify the root cause
2. Consider edge cases
3. Evaluate potential solutions
4. Select best approach

Then provide your answer."
```

**Pattern 2: Question-Guided**
```
"Before implementing, answer these questions:
- What could go wrong?
- What are the performance implications?
- Does this break existing functionality?
- Are there security concerns?

Then write the code."
```

**Pattern 3: Comparison COT**
```
"Analyze both approaches:

Approach A: [describe]
- Pros:
- Cons:
- Performance:
- Complexity:

Approach B: [describe]
- Pros:
- Cons:
- Performance:
- Complexity:

Then recommend the best option with reasoning."
```

**Sequential Thinking MCP in This Template:**

This template includes **sequential-thinking MCP** which provides automated COT:

```
When to use sequential-thinking MCP:
- Architecture decisions (Opus model)
- Complex refactoring
- Multi-perspective analysis
- Trade-off evaluation

See: docs/01-fundamentals/03_workflow-integration.md
```

**Example: With vs Without COT**

❌ **Without COT (risky for complex task):**
```
"Refactor this 200-line function to be more maintainable"

[AI jumps straight to code without considering dependencies,
breaking changes, or testing strategy]
```

✅ **With COT (safer):**
```
"Refactor this 200-line function. Before writing code, think through:
1. What does this function do? (analyze dependencies)
2. What are the logical sub-units? (identify split points)
3. What could break? (breaking changes)
4. How will we test? (testing strategy)

Then provide the refactored code."

[AI analyzes first, then codes → better result]
```

**Cost vs Benefit:**

**COT Costs:**
- More tokens (thinking takes space)
- Slightly longer response time

**COT Benefits:**
- Higher accuracy (20-40% improvement on complex tasks)
- Fewer errors to fix later
- Visible reasoning (you can spot mistakes)
- Builds trust (you see the thinking)

**Net Result:** COT usually saves tokens overall by reducing rework.

**Takeaway:** For complex tasks, add "think step by step before answering". For simple tasks, skip it.

---

## Draft → Plan → Act

### Why Plan Mode Exists

**The Most Reliable Path to Quality:**

```
Draft → Plan → Validate → Act
```

**Why This Works:**

1. **Draft (Exploration):** Understand the problem, gather context
2. **Plan (Design):** Design approach, consider alternatives
3. **Validate (Review):** User reviews plan, catches issues BEFORE execution
4. **Act (Execution):** Implement the validated plan

**The Plan Mode Workflow:**

```
┌─────────────────────────────────────────────────┐
│ User Request                                     │
│ "Add user authentication"                       │
└──────────────┬──────────────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────────────┐
│ DRAFT (Exploration)                              │
│ - Search existing auth patterns                 │
│ - Read current user model                       │
│ - Understand security requirements              │
└──────────────┬──────────────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────────────┐
│ PLAN (Design)                                    │
│ - Propose: JWT vs sessions                      │
│ - Design: Database schema changes               │
│ - List: Files to modify                         │
│ - Identify: Potential breaking changes          │
└──────────────┬──────────────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────────────┐
│ VALIDATE (User Review)                           │
│ User: "Use JWT, but add refresh tokens"        │
│ ← CHECKPOINT: Catch issues before coding        │
└──────────────┬──────────────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────────────┐
│ ACT (Execution)                                  │
│ - Implement validated plan                      │
│ - No surprises (plan was approved)              │
│ - Focused execution                             │
└─────────────────────────────────────────────────┘
```

**Why NOT Draft → Act Directly?**

**Without Planning (risky):**
```
User: "Add authentication"
AI: [Immediately writes 500 lines of code]
User: "Wait, I wanted JWT not sessions!"
[50% of work wasted]
```

**With Planning (safe):**
```
User: "Add authentication"
AI: "Here's my plan: Use sessions with Redis..."
User: "Actually, use JWT instead"
AI: "Updated plan: JWT with refresh tokens..."
User: "Perfect, proceed"
AI: [Writes code following validated plan]
[0% wasted work]
```

**The Validation Checkpoint:**

**What gets caught in validation:**
- Wrong approach/technology
- Misunderstood requirements
- Missing edge cases
- Breaking changes not considered
- Better alternatives available

**Cost of catching issues:**
- In planning: 1 minute conversation
- After implementation: 30 minutes of rework

**Psychological Benefit:**

**Reduces anxiety:**
- User sees plan before execution (feels in control)
- Can course-correct early (reduces risk)
- Understands the approach (builds trust)

**How to Use Plan Mode:**

```
# Entering plan mode (read-only):
EnterPlanMode

# AI explores, designs, presents plan
# User reviews and approves/modifies

# Exiting plan mode (ready to execute):
ExitPlanMode
```

**When to Use Plan Mode:**

✅ **Yes, use plan mode:**
- Multi-file changes
- Architecture decisions
- Refactoring large code
- New feature implementation
- When you're uncertain about approach

❌ **No, skip plan mode:**
- Single-line fixes
- Typo corrections
- Simple, obvious changes
- When you've already validated the approach

**Prompting Pattern:**

**For complex tasks (use planning):**
```
"I want to add [feature].

Before implementing, please:
1. Explore the codebase to understand current architecture
2. Propose an implementation approach
3. Identify files to modify
4. Consider edge cases and breaking changes
5. Wait for my approval before coding"
```

**For simple tasks (skip planning):**
```
"Fix the typo in line 42 of auth.js: 'passowrd' → 'password'"
[No planning needed, just do it]
```

**This Template's Implementation:**

Plan mode is **built into Claude Code**:

1. `EnterPlanMode` → Read-only, exploration mode
2. AI explores codebase, designs approach
3. AI writes plan to `.claude/plans/` directory
4. User reviews plan
5. `ExitPlanMode` → Execution mode unlocked
6. AI implements validated plan

**Takeaway:** For non-trivial tasks, plan first, code second. The validation checkpoint saves more time than it costs.

---

## Quick Reference

### Prompting Cheat Sheet

**The 80/20 Rules:**

1. ✅ **Clarity:** Think clearly before prompting
2. ✅ **Context:** Provide all relevant information
3. ✅ **Examples:** Show 2-3 examples (few-shot)
4. ✅ **Permission to fail:** "If uncertain, say 'I don't know'"
5. ✅ **Output requirements:** Specify exact format wanted

**Quick Decision Tree:**

```
Need AI help?
│
├─ Simple task (1-step, obvious)?
│  → Direct prompt, no COT, no planning
│
├─ Complex task (multi-step, reasoning)?
│  │
│  ├─ Already know the approach?
│  │  → Use COT, skip planning
│  │
│  └─ Uncertain about approach?
│     → Use plan mode, then COT in execution
│
└─ Need consistent format?
   → Use few-shot examples
```

**Template Library:**

**1. Context-Rich Request**
```
I'm working on [project type].
Context: [key details]
Goal: [what you want]
Requirements:
- [requirement 1]
- [requirement 2]

Constraints:
- [limitation 1]
- [limitation 2]

Output: [format specification]
```

**2. Permission to Fail**
```
[Your question]

Important: Base your answer ONLY on the provided context.
If the information isn't available, say "I don't know" rather
than guessing.
```

**3. Few-Shot Scaffolding**
```
Follow these examples:

Example 1: [input] → [output]
Example 2: [input] → [output]
Example 3: [input] → [output]

Now do the same for:
[your input]
```

**4. Chain of Thought**
```
Before answering, think through:
1. [question 1]
2. [question 2]
3. [question 3]

Then provide your solution.
```

**5. Planning Request**
```
Task: [what to build]

Before implementation:
1. Analyze current codebase
2. Propose approach with alternatives
3. List files to modify
4. Identify risks and edge cases

Wait for approval before coding.
```

**Common Mistakes to Avoid:**

❌ Vague prompts: "Make this better"
✅ Specific prompts: "Reduce time complexity from O(n²) to O(n)"

❌ No context: "Fix the bug"
✅ Full context: "Fix authentication bug: [error] [code] [environment]"

❌ Assuming AI knows: "Update the config"
✅ Explicit: "Update database.yml to use PostgreSQL instead of MySQL: [show current config]"

❌ No output format: "Document this API"
✅ Specified format: "Document using OpenAPI 3.0 spec with examples"

❌ Treating AI as human: "Can you help?"
✅ Treating AI as tool: "Execute task: [specific instructions]"

**Prompting Mental Model:**

```
AI is a:
✅ Powerful autocomplete
✅ Pattern matcher
✅ Probability calculator
✅ Tool you program with words

AI is NOT:
❌ Sentient
❌ Your friend
❌ Mind reader
❌ Magic
```

---

## Progressive Learning Path

**Beginner (Start here):**

1. Read: [How AI Actually Works](#how-ai-actually-works)
2. Apply: [Permission to Fail](#permission-to-fail) to every prompt
3. Practice: [Context is King](#context-is-king) - always provide context

**Intermediate:**

4. Master: [The Meta-Skill of Clarity](#the-meta-skill-of-clarity)
5. Adopt: [Prompting is Programming](#prompting-is-programming) mindset
6. Use: [Few-Shot > Zero-Shot](#few-shot--zero-shot) for consistency

**Advanced:**

7. Optimize: [When to Use Chain of Thought](#when-to-use-chain-of-thought)
8. Leverage: [Draft → Plan → Act](#draft--plan--act) workflow

**Mastery:**

9. Build your own prompt library (save what works)
10. Teach others (best way to solidify learning)

---

## Related Guides

**Deepen your understanding:**

- **[Coding Principles Handbook](06_coding-principles-handbook.md)** - SOLID, DRY, KISS, YAGNI for code quality
- **[Anti-Patterns](../00-start-here/05_anti-patterns.md)** - What NOT to do with AI-assisted coding
- **[Vibe Coding vs Engineering](01_vibe-coding-vs-engineering.md)** - When to use speed vs structure
- **[Workflow Integration](03_workflow-integration.md)** - 4-layer architecture including plan mode
- **[Verification & Debugging](05_verification-debugging.md)** - Trust but verify patterns

**Advanced techniques:**

- **Sequential-Thinking MCP:** `01_global-setup/03_nice-to-have/04_sequential-thinking-mcp.md`
- **Sub-Agent Best Practices:** `docs/03-advanced/02_subagent-best-practices.md`
- **Agent Design:** See `.claude/agents/` directory for working examples

---

**Version:** v4.12.0
**Last Updated:** 2025-12-17
**Source:** Based on advanced prompting insights from "You SUCK at Prompting AI" + template analysis

---

**Next:** [Prompt Patterns Library](08_prompt-patterns.md) *(Coming in v4.13.0)* | [Coding Principles](06_coding-principles-handbook.md) | [Anti-Patterns](../00-start-here/05_anti-patterns.md)
