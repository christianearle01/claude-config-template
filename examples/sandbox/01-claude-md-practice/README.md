# Sandbox 1: CLAUDE.md Configuration Practice

**Duration:** 30 minutes
**Skill Level:** Beginner (Foundation)
**Goal:** Learn to create effective CLAUDE.md files through hands-on practice

---

## Scenario

You've inherited a Node.js API project from a developer who left the company. The code has no documentation, and you need to configure Claude Code to work on it. Your job: Create a CLAUDE.md that helps Claude understand the project WITHOUT reading every file.

**The Problem:**
- 15 files, unclear structure
- No README (just basic npm scripts)
- 3 API endpoints (users, posts, auth)
- Some external APIs used (Twilio for SMS)
- Authentication system (unclear if sessions or JWT)

**Your Task:**
Create a CLAUDE.md that answers:
- What does this API do? (business purpose)
- What tech stack is it using?
- What are the main API endpoints?
- Are there any external services?
- What's the file structure?

---

## Learning Objectives

By completing this sandbox, you will:

1. **Understand CLAUDE.md purpose** - It's project memory, not code documentation
2. **Learn "WHAT not HOW"** - Document business purpose, not implementation details
3. **Practice essential vs detailed** - Know what to include vs what to skip
4. **Experience token savings** - See how context prevents file exploration

---

## Setup (2 minutes)

1. **Examine starter files:**
   ```bash
   cd starter-files
   ls -la
   ```

2. **You'll see:**
   - 15 JavaScript files (messy structure)
   - package.json (dependencies list)
   - Basic README.md (just npm scripts)

3. **Read a few files** (spend 5 minutes exploring)
   - What does this API do?
   - What tech stack is it using?
   - Can you figure out the architecture?

---

## Challenge (20 minutes)

**Step 1: Create CLAUDE.md (10 minutes)**

In the `starter-files/` directory, create a `CLAUDE.md` file that documents:

1. **Business Purpose** (2-3 sentences)
   - What does this API do?
   - Who uses it?

2. **Tech Stack**
   - Language (Node.js)
   - Framework (Express)
   - Database (if any)
   - External APIs (Twilio SMS)

3. **API Endpoints** (list the 3 main endpoints)
   - /api/users
   - /api/posts
   - /api/auth

4. **File Structure** (high-level only)
   - Where is routing?
   - Where is business logic?
   - Where are models?

5. **External Services**
   - Twilio SMS (why is it used?)

**Step 2: Validate your CLAUDE.md (5 minutes)**

Run the validation script:
```bash
cd ..  # Back to sandbox root
./validation.sh
```

The script checks:
- ✅ CLAUDE.md exists
- ✅ Contains "Business Purpose" or "What Does This Application Do"
- ✅ Lists all 3 API endpoints
- ✅ Mentions tech stack (Express, Node.js)
- ✅ Documents Twilio integration
- ✅ File is <500 lines (concise, not exhaustive)

**Step 3: Self-Assessment (5 minutes)**

Ask yourself:
- ✅ Can you explain the tech stack without looking at code?
- ✅ Did you document the API endpoints?
- ✅ Would a new developer understand the architecture?
- ✅ Did you focus on WHAT (business purpose) not HOW (implementation)?

---

## Solution

**If you get stuck, check:** `solution/CLAUDE.md`

The solution shows:
- Proper structure (sections, clarity)
- Business-focused language (not code-focused)
- Essential information only (no exhaustive details)
- External service rationale (WHY Twilio is used)

---

## Common Mistakes

### ❌ Mistake 1: Too Much Detail
```markdown
# BAD EXAMPLE
## File Structure
- server.js:1-45 - Express setup, middleware loading
- routes/users.js:10-20 - GET endpoint implementation
- routes/users.js:22-35 - POST endpoint with validation
- controllers/userController.js:12-55 - User CRUD logic
...
```

**Problem:** This is code documentation, not project memory. Claude can READ code. Don't duplicate it.

**Better:**
```markdown
# GOOD EXAMPLE
## File Structure
- server.js - Express server setup
- routes/ - API endpoint definitions
- controllers/ - Business logic
- models/ - Database schemas
```

---

### ❌ Mistake 2: Missing Business Purpose
```markdown
# BAD EXAMPLE
# Project Memory

## Tech Stack
- Node.js Express
- MongoDB database
- JWT authentication
```

**Problem:** No context on WHAT the app does. Just lists tech.

**Better:**
```markdown
# GOOD EXAMPLE
# Project Memory

## Business Purpose
This API powers a team collaboration platform for remote workers.
Core features: User management, post creation/editing, SMS notifications for urgent tasks.

## Tech Stack
- Node.js Express (REST API)
- MongoDB (user + post storage)
- JWT authentication (token-based)
- Twilio SMS (urgent task notifications)
```

---

### ❌ Mistake 3: Vague Descriptions
```markdown
# BAD EXAMPLE
## External Services
- We use Twilio
- Some third-party API
```

**Problem:** Doesn't say WHY or WHAT FOR.

**Better:**
```markdown
# GOOD EXAMPLE
## External Services
- **Twilio SMS API**
  - Purpose: Send urgent task notifications to users
  - Triggered: When task priority = "urgent" and user has SMS enabled
  - Rate limit: 100 SMS/day (free tier)
```

---

## Break This Config Exercises

**After completing the challenge, try these intentionally broken examples to deepen understanding:**

### Exercise A: Missing Tech Stack

**Scenario:** `broken-examples/no-tech-stack-CLAUDE.md`

```markdown
# Project Memory

## Business Purpose
Team collaboration platform for remote workers.

## API Endpoints
- /api/users
- /api/posts
- /api/auth
```

**Question:** What's wrong? How would you fix it?

<details>
<summary>Click for answer</summary>

**Problem:** No tech stack documented. Claude has to guess:
- What language is this? (could be Node, Python, Ruby)
- What framework? (Express, Koa, Fastify?)
- What database? (MongoDB, PostgreSQL, MySQL?)

**Fix:** Add Tech Stack section with specifics.
</details>

---

### Exercise B: Implementation Details Overload

**Scenario:** `broken-examples/too-detailed-CLAUDE.md`

```markdown
# Project Memory (5000 lines)

## Function Documentation
### createUser(userData)
**Parameters:**
- userData: Object containing {email, password, name}
**Returns:** Promise<User>
**Implementation:** Uses bcrypt to hash password (12 rounds)...

[4,995 more lines of function documentation]
```

**Question:** What's wrong? How would you fix it?

<details>
<summary>Click for answer</summary>

**Problem:** This is code documentation, not project memory.
- 5000 lines exceeds context limits
- Duplicates what Claude can read from code
- Focuses on HOW instead of WHAT

**Fix:** Delete function docs. Document WHAT the app does, not HOW every function works.
</details>

---

### Exercise C: Vague Business Purpose

**Scenario:** `broken-examples/vague-purpose-CLAUDE.md`

```markdown
# Project Memory

## Business Purpose
This is a web application.

## Tech Stack
- React
- Node.js
```

**Question:** What's wrong? How would you fix it?

<details>
<summary>Click for answer</summary>

**Problem:** "Web application" tells Claude nothing.
- What problem does it solve?
- Who uses it?
- What features does it have?

**Fix:** Be specific:
```markdown
## Business Purpose
Remote team collaboration platform.
Core features: Real-time messaging, task management, video calls.
Used by distributed engineering teams (10-50 people per workspace).
```
</details>

---

## Success Criteria

**You've mastered CLAUDE.md configuration when:**

✅ **You can create CLAUDE.md in <10 minutes** (without looking at solution)
✅ **Your CLAUDE.md is <500 lines** (concise, not exhaustive)
✅ **New team members understand the project** (from CLAUDE.md alone, without reading code)
✅ **Claude doesn't explore files unnecessarily** (has enough context to answer questions)

**Token Savings Test:**
Before CLAUDE.md: "What does this project do?" → Claude reads 10+ files (2,000+ tokens)
After CLAUDE.md: "What does this project do?" → Claude reads CLAUDE.md (200 tokens)
**Savings: 90% fewer tokens**

---

## Next Steps

**After mastering this sandbox:**

1. **Try Sandbox 2:** Prompt Caching Practice (optimize for repeated queries)
2. **Apply to real project:** Create CLAUDE.md for your own codebase (30 min)
3. **Read theory:** [Skills Paradigm](../../../docs/01-fundamentals/02_skills-paradigm.md) explains WHY this works

---

## Support

**Stuck? Check these resources:**
- **Solution:** `solution/CLAUDE.md` (reference implementation)
- **Template:** `../../../templates/CLAUDE.md.template` (blank template)
- **Theory:** `../../../docs/01-fundamentals/02_skills-paradigm.md`

**Still confused?**
- Re-read the "Common Mistakes" section above
- Compare your CLAUDE.md to the solution
- Ask: "Am I documenting WHAT (business) or HOW (code)?"

---

**Happy practicing! Remember: CLAUDE.md is project memory, not code documentation.**
