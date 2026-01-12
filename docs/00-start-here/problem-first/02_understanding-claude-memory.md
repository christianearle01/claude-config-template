# Understanding Claude Memory (CLAUDE.md)

**Version:** v5.0.0-alpha.1
**Reading Time:** 6 minutes
**Purpose:** Understand WHY Claude needs project memory and HOW it saves you time/tokens

---

## The Problem This Solves

**Without CLAUDE.md:**

```
Monday 9am - New session:
You: "Help me add authentication to my app"
Claude: "Sure! What framework are you using?"
You: "Next.js 14 with TypeScript"
Claude: "What's your auth strategy?"
You: "Supabase"
Claude: "What's your database schema?"
You: "Here it is..." [paste 50 lines]

Monday 2pm - New session (context expired):
You: "Help me add a protected route"
Claude: "What framework are you using?"  ← AGAIN!
You: "Next.js 14..." ← RE-EXPLAINING
[Repeat the same conversation]

Tokens wasted per day: 1000+ (re-explaining same context 3-5 times)
```

**With CLAUDE.md:**

```
Monday 9am - Session starts:
[Claude auto-reads CLAUDE.md]
Claude knows: Next.js 14, TypeScript, Supabase, your schema

You: "Help me add authentication to my app"
Claude: "Given your Supabase setup, here's how to add Next.js middleware auth..."
[No questions needed - Claude has context]

Monday 2pm - New session:
[Claude auto-reads CLAUDE.md AGAIN]
Claude remembers: Everything from this morning

You: "Help me add a protected route"
Claude: "For your Next.js 14 app with Supabase auth..."
[Zero re-explanation needed]

Tokens saved per day: 700+ (75% reduction in session startup costs)
```

---

## The Notebook Analogy (ELI12)

**Think of Claude like a brilliant consultant who visits your office every day:**

**Without a notebook (No CLAUDE.md):**
- Monday: "Hi, I'm Claude! Tell me about your project..."
- Tuesday: "Hi, I'm Claude! Tell me about your project..." ← Amnesia!
- Wednesday: "Hi, I'm Claude! Tell me about your project..." ← Still no memory!

**With a notebook (CLAUDE.md):**
- Monday: Claude reads notebook → "Ah, Next.js project with Supabase auth..."
- Tuesday: Claude reads same notebook → "I remember! Next.js project..."
- Wednesday: Claude reads same notebook → Still remembers!

**CLAUDE.md is that notebook** - persistent memory that loads at session start.

---

## How It Works (Behind the Scenes)

### Without CLAUDE.md

```
┌─────────────────────────────────────────────┐
│ Session 1: Monday 9am                       │
├─────────────────────────────────────────────┤
│ 1. Claude starts (0 context)                │
│ 2. You explain project (500 tokens)         │
│ 3. You ask question (200 tokens)            │
│ 4. Claude answers (300 tokens)              │
│ Total: 1000 tokens                          │
└─────────────────────────────────────────────┘

Session ends → All context LOST

┌─────────────────────────────────────────────┐
│ Session 2: Monday 2pm                       │
├─────────────────────────────────────────────┤
│ 1. Claude starts (0 context AGAIN)          │
│ 2. You re-explain project (500 tokens WASTE)│
│ 3. You ask question (200 tokens)            │
│ 4. Claude answers (300 tokens)              │
│ Total: 1000 tokens (500 wasted on re-intro) │
└─────────────────────────────────────────────┘

Daily total (5 sessions): 5000 tokens
Wasted on re-introductions: 2500 tokens (50%!)
```

### With CLAUDE.md

```
┌─────────────────────────────────────────────┐
│ Session 1: Monday 9am                       │
├─────────────────────────────────────────────┤
│ 1. Claude auto-reads CLAUDE.md (0 manual tokens) │
│ 2. You ask question (200 tokens)            │
│ 3. Claude answers with context (300 tokens) │
│ Total: 500 tokens                           │
└─────────────────────────────────────────────┘

Session ends → CLAUDE.md persists (not lost)

┌─────────────────────────────────────────────┐
│ Session 2: Monday 2pm                       │
├─────────────────────────────────────────────┤
│ 1. Claude auto-reads CLAUDE.md AGAIN (0 manual tokens) │
│ 2. You ask question (200 tokens)            │
│ 3. Claude answers with context (300 tokens) │
│ Total: 500 tokens (0 wasted!)               │
└─────────────────────────────────────────────┘

Daily total (5 sessions): 2500 tokens
Wasted on re-introductions: 0 tokens
SAVINGS: 50% reduction!
```

**Key Insight:** CLAUDE.md is read ONCE per session (automatically), not EVERY query (manually).

---

## What Goes In CLAUDE.md?

**Think: "What would a new team member need to know about this project?"**

### Essential Context (Always Include)

**1. Project Purpose (2-3 sentences)**
```markdown
## What This Does
This is an e-commerce platform for selling handmade crafts.
Users browse products, add to cart, checkout with Stripe.
Admin panel for managing inventory and orders.
```

**Why:** Claude needs to understand business context for suggestions.

**2. Tech Stack (List format)**
```markdown
## Tech Stack
- Frontend: Next.js 14 (App Router), TypeScript, Tailwind CSS
- Backend: Next.js API routes, Prisma ORM
- Database: PostgreSQL (Supabase)
- Auth: Supabase Auth (magic links)
- Payments: Stripe
- Hosting: Vercel
```

**Why:** Claude adapts solutions to your specific technologies.

**3. Key Patterns (How you do things)**
```markdown
## Patterns & Conventions
- API routes in app/api/[resource]/route.ts
- React Server Components by default, 'use client' when needed
- Prisma for all database access (no raw SQL)
- Error handling: try/catch with custom ErrorBoundary
- Styling: Tailwind utility classes, no custom CSS
```

**Why:** Claude matches your existing code style.

### Optional Context (Include If Relevant)

**4. External APIs**
```markdown
## External Services
- Stripe: sk_test_... (test mode only)
- SendGrid: Email notifications (API key in .env)
- Cloudinary: Product image uploads
```

**5. Known Issues / Constraints**
```markdown
## Current Constraints
- Database has 10k row limit (hobby plan)
- Image uploads limited to 5MB
- Stripe webhooks not yet implemented (manual order processing)
```

**Why:** Claude won't suggest solutions that violate constraints.

**6. Current Work**
```markdown
## Active Development
Working on: Adding product search functionality
Next: Implement Stripe webhooks for automated order processing
Blocked: Waiting for design mockups for checkout flow
```

**Why:** Claude prioritizes suggestions relevant to current work.

---

## CLAUDE.md Size Guidelines

**Target:** 200-400 lines (balanced context)

**Too Small (<100 lines):**
- Claude asks obvious questions
- Solutions are too generic
- You waste tokens clarifying

**Just Right (200-400 lines):**
- Claude has enough context
- Solutions are project-specific
- Minimal clarification needed

**Too Large (>500 lines):**
- Dilutes important information
- Increases session startup cost
- Claude might miss key details

**Rule of Thumb:** If you'd tell a new team member, include it. If it's in git history or code comments, skip it.

---

## Traditional vs Claude-Assisted Comparison

### Creating CLAUDE.md

**Traditional Way (Manual Writing):**
```
1. Open blank file
2. Think: "What should I write?"
3. Write sections from memory (20 min)
4. Realize you forgot key details (5 min)
5. Go back and add them (10 min)
6. Wonder if it's complete (lingering doubt)

Total time: 35 minutes
Risk: Missing critical context
```

**Claude-Assisted Way:**
```
You: "Help me create CLAUDE.md for my project.
     It's a Next.js e-commerce app with Supabase and Stripe."

Claude: "I'll ask targeted questions to build your CLAUDE.md:

1. What does your app do? (business purpose)
2. What's your data model? (main entities)
3. Any external APIs? (Stripe, email, etc.)
4. Current work focus? (active features)
5. Any constraints? (hosting limits, known issues)

[5-minute Q&A conversation]

Claude: "Here's your CLAUDE.md draft. Review and edit:"

[Generated 300-line CLAUDE.md with all essential context]

Total time: 10 minutes
Benefit: Structured, comprehensive, nothing forgotten
```

**Time Saved:** 25 minutes (71% faster)

---

## When CLAUDE.md Gets Updated

**CLAUDE.md is LIVING DOCUMENTATION** - update it when things change:

### Trigger: Major Architecture Change

```
Before: Using REST API
Change: Migrating to GraphQL
Update CLAUDE.md: Change "API routes" to "GraphQL resolvers"
```

### Trigger: New External Service

```
Before: No email service
Change: Added SendGrid
Update CLAUDE.md: Add SendGrid to "External Services" section
```

### Trigger: New Constraints

```
Before: No known issues
Change: Database hitting row limit
Update CLAUDE.md: Add "10k row limit" to "Current Constraints"
```

### Trigger: Completed Work

```
Before: "Working on: Product search"
Change: Search completed, now working on checkout
Update CLAUDE.md: Move search to "Completed", add checkout to "Active"
```

**Frequency:** Update when context changes, not on schedule. Usually 1-2 times per week for active projects.

---

## Common Mistakes (And How to Avoid)

### ❌ Mistake 1: "I'll Remember to Create It Later"

**Problem:** You start working without CLAUDE.md, waste tokens re-explaining

**Impact:** First 3 sessions waste 1500+ tokens before you realize

**Fix:** Create CLAUDE.md BEFORE first Claude session. Even minimal version (50 lines) is better than nothing.

### ❌ Mistake 2: "I'll Put Everything In There"

**Problem:** 800-line CLAUDE.md with every detail, including git history

**Impact:** Dilutes important information, expensive to load

**Fix:** Focus on "what someone needs RIGHT NOW to work on this project", not complete history.

### ❌ Mistake 3: "CLAUDE.md is Set-It-And-Forget-It"

**Problem:** Created once, never updated, becomes stale

**Impact:** Claude has outdated context, gives wrong suggestions

**Fix:** Review CLAUDE.md monthly, update when major changes happen.

### ❌ Mistake 4: "I'll Write It in Technical Detail"

**Problem:** Too focused on implementation details, not enough context

**Impact:** Claude doesn't understand WHY, only WHAT

**Fix:** Include business purpose and constraints, not just technical stack.

---

## Verification Questions (Check Your Understanding)

### Question 1: Why Token Savings?

**Answer:** CLAUDE.md is read ONCE per session automatically (0 manual tokens), vs manually re-explaining EVERY session (500+ tokens wasted).

**If you answered differently:** Re-read "How It Works (Behind the Scenes)" section.

### Question 2: When to Update?

**Answer:** When context changes (architecture shift, new service, new constraints), not on schedule.

**If you answered "daily" or "never":** Both wrong. Update when CHANGES happen that affect Claude's understanding.

### Question 3: Ideal Size?

**Answer:** 200-400 lines (balanced context). Too small = generic answers. Too large = diluted focus.

**If you answered differently:** Re-read "CLAUDE.md Size Guidelines" section.

---

## Real-World Example

### Before CLAUDE.md (Session Log)

```
Session 1:
You: "Add authentication"
Claude: "What auth method?" ← QUESTION
You: "Supabase magic links" ← ANSWER
Claude: "What's your user schema?" ← QUESTION
You: "id, email, createdAt..." ← ANSWER
Claude: "Here's the solution..." ← FINALLY

Tokens: 650 (350 wasted on Q&A)

Session 2 (2 hours later):
You: "Add protected routes"
Claude: "What auth method?" ← SAME QUESTION AGAIN!
You: "Supabase magic links" ← RE-EXPLAINING
[Repeat same waste]

Tokens: 650 (350 wasted AGAIN)
```

### After CLAUDE.md (Session Log)

```
Session 1:
[Claude reads CLAUDE.md: "Supabase auth, user schema: id/email/createdAt"]
You: "Add authentication"
Claude: "Here's Supabase magic link auth for your schema..." ← INSTANT
[No questions needed]

Tokens: 300 (0 wasted)

Session 2 (2 hours later):
[Claude reads CLAUDE.md AGAIN]
You: "Add protected routes"
Claude: "Here's middleware for your Next.js 14 + Supabase setup..." ← INSTANT
[Still no questions]

Tokens: 300 (0 wasted)

Daily savings: 700 tokens (54% reduction)
```

---

## Try It Yourself

**Option 1: Claude Creates Your CLAUDE.md**
```
Start a Claude session and say:
"Help me create CLAUDE.md for my [type of project]"

Answer Claude's questions → Get generated CLAUDE.md
```

**Option 2: Use the Template**
```
See: templates/CLAUDE.md.template
Copy and fill in your project details
```

**Option 3: Problem-First Setup**
```
./scripts/problem-first-setup.sh

Minimal CLAUDE.md created automatically with your problem statement
Expand it as you work
```

---

## Next Steps

**Continue Problem-First Learning:**
- **Next:** `03_token-optimization-basics.md` (Save 50-95% on costs)
- **Or:** `04_quick-wins-path.md` (Fastest value demonstration)

**Get Template:**
- **Template:** `templates/CLAUDE.md.template` (Copy and customize)
- **Examples:** `examples/claude-md/` (Real project examples)

**Traditional Path:**
- **Setup:** `docs/00-start-here/03_instant-setup.md` (5-minute setup includes CLAUDE.md creation)

---

**Navigation:**
- **Back:** `01_how-claude-solves-problems.md` (Problem types overview)
- **Up:** `docs/00-start-here/01_entry-points.md` (Main hub)
- **Next:** `03_token-optimization-basics.md` (Token savings strategies)

---

**Version:** v5.0.0-alpha.1
**Last Updated:** 2025-01-13
**Path:** `docs/00-start-here/problem-first/02_understanding-claude-memory.md`
