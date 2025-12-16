# Onboarding Claude Code to an Existing Project

This guide helps you set up Claude Code for a project you're joining for the first time.

**Time Required:** 30-45 minutes
**Goal:** Fully document your project so Claude Code understands the business context, architecture, and conventions.

> **Note:** This template assumes you have cloned/downloaded it to a location on your machine.
> Replace `[TEMPLATE_PATH]` below with the actual path where you stored this template.
> Example: `~/config/claude-config-template` or `~/Documents/claude-config-template`

---

## Why This Matters

**Without CLAUDE.md project documentation:**
- Claude re-reads 20-50 files every session to understand "What does this app do?"
- Costs 2,000-10,000 tokens per session just for context gathering
- You re-explain the same business context in every new conversation
- Claude makes incorrect assumptions about project purpose and architecture

**With CLAUDE.md (this 30-min investment):**
- Claude reads 1 file (CLAUDE.md) = 200-500 tokens for full context
- Saves 95% on context queries (2,000-10,000 → 200-500 tokens)
- Persistent memory across sessions ("What does this app do?" never needs re-answering)
- Accurate understanding of business purpose prevents wrong implementation choices

**Time investment:** 30-45 minutes per project (one-time)
**Projected savings:** $40-80/month per active project in token costs + prevents costly architectural mistakes

---

## Step 1: Copy Template Files (5 minutes)

```bash
cd /path/to/existing/project

# Replace [TEMPLATE_PATH] with your actual template location
# Example: export TEMPLATE_PATH=~/Documents/claude-config-template
export TEMPLATE_PATH=[TEMPLATE_PATH]

# Copy Claude Code configuration
cp -r $TEMPLATE_PATH/.claude .

# Copy CLAUDE.md template
cp $TEMPLATE_PATH/templates/CLAUDE.md.template ./CLAUDE.md

# Copy gitignore rules (append to existing .gitignore)
cat $TEMPLATE_PATH/.gitignore.template >> .gitignore
```

---

## Step 2: Document Business Context (15 minutes)

**Most Important Step:** This is what makes Claude Code truly effective.

### Use Claude Code to Help You:

Start Claude Code in your project directory:
```bash
claude
```

Then ask:
```
I just joined this project. Help me document what this application does in CLAUDE.md:

1. Read the README, package.json (or requirements.txt, go.mod, etc.), and main application files
2. Identify the business purpose (what problem does this solve?)
3. List the key features (from a user perspective, not technical implementation)
4. Identify external API integrations and their purposes
5. Update CLAUDE.md with this information

Focus on WHAT the app does (business value), not HOW it's implemented (technical details).

Skip reading: node_modules/, dist/, build/, vendor/, .git/
```

### What to Capture:

**✅ Good Documentation:**
- "This is a task management platform that helps remote teams coordinate work"
- "Core feature: Real-time collaboration on documents using WebSockets"
- "Uses Stripe → Process subscription payments for premium plans"

**❌ Poor Documentation:**
- "This is a Node.js application" (too technical, no business context)
- "Has a UserController and TaskService" (implementation details)
- "Uses Stripe" (no explanation of WHY)

---

## Step 3: Document Tech Stack & Patterns (10 minutes)

Ask Claude Code:
```
Help me document the technical patterns and conventions in CLAUDE.md:

1. Review the codebase structure
2. Identify architectural patterns (MVC, microservices, monolith, clean architecture, etc.)
3. Find coding conventions:
   - Naming conventions (camelCase, snake_case, PascalCase)
   - Indentation (spaces vs tabs, how many)
   - Import organization
   - File naming patterns
4. Document testing approach (framework, coverage requirements, test file naming)
5. Note any project-specific guidelines or reference documents

Look for patterns in existing code - don't make assumptions.
```

### Reference Files to Check:

Ask Claude Code to look for:
- `README.md` or `CONTRIBUTING.md` - May contain conventions
- `.eslintrc`, `.prettierrc`, `pyproject.toml` - Code style configs
- Existing documentation in `docs/` folder
- Test files - Test naming patterns
- Recent commits - Commit message style

---

## Step 4: Customize Slash Commands (5 minutes)

The template provides universal commands. Customize them with project-specific details:

### Edit `.claude/commands/test.md`:
Replace `[command from CLAUDE.md]` with your actual test command:
```markdown
Run tests: npm test
OR: pytest tests/
OR: go test ./...
OR: mvn test
```

### Edit `.claude/commands/build.md`:
Replace `[command from CLAUDE.md]` with your actual build command:
```markdown
Run build: npm run build
OR: python setup.py build
OR: go build
OR: make build
```

### Optional: Create Project-Specific Commands

Examples:
- `/deploy` - Deployment checklist
- `/db-migrate` - Run database migrations
- `/lint` - Run linters
- `/format` - Format code

---

## Step 5: Test Your Setup (5 minutes)

```bash
claude  # Start Claude Code in your project

# Try these commands:
/standards    # Should show your project standards from CLAUDE.md
/onboarding   # Should explain what the project does
/test         # Should run your test suite

# Ask Claude:
"What does this project do?"
"What are the main features?"
"How is the code organized?"
```

If Claude Code gives accurate, helpful responses → Setup successful! ✅

If responses are vague or incorrect → Update CLAUDE.md with more context

---

## Tips for Existing Projects

### Finding Business Context

**1. README Files**
- Often explain what the project does in plain English
- Look for "About", "Overview", or "Description" sections

**2. Marketing/Product Website**
- Visit the product website (if public)
- Read feature descriptions from a user perspective

**3. API Documentation**
- Shows what the system can do
- Endpoint names reveal features (e.g., `/api/payments`, `/api/subscriptions`)

**4. Controller/Route Names**
- `UserController`, `PaymentRoutes` → User management and payment features
- `OrderService`, `InventoryManager` → E-commerce functionality

**5. Database Schema**
- Table names reveal core entities (`users`, `orders`, `subscriptions`)
- Relationships show system architecture

**6. Package/Dependency Names**
- `stripe`, `twilio`, `sendgrid` → Payment, SMS, email features
- `passport`, `jsonwebtoken` → Authentication features

---

### Identifying External Integrations

**Look for:**

**1. Dependencies in package.json / requirements.txt / go.mod:**
```json
{
  "dependencies": {
    "stripe": "^12.0.0",     // Payment processing
    "twilio": "^4.0.0",       // SMS messaging
    "@sendgrid/mail": "^7.0.0" // Email delivery
  }
}
```

**2. Environment Variables:**
```bash
STRIPE_API_KEY=sk_test_...
TWILIO_AUTH_TOKEN=...
AWS_ACCESS_KEY_ID=...
GOOGLE_OAUTH_CLIENT_ID=...
```

**3. Helper/Service Files:**
```
src/helpers/stripe_helper.ts
src/services/sendgrid.service.py
lib/integrations/google_auth.go
```

**4. Configuration Files:**
```yaml
# config/apis.yml
stripe:
  api_key: ${STRIPE_API_KEY}
  webhook_secret: ${STRIPE_WEBHOOK_SECRET}
```

**Ask Claude Code:**
```
Search the codebase for external API integrations:

1. Check package.json / requirements.txt for third-party API libraries
2. Search for environment variables ending in _API_KEY, _TOKEN, _SECRET
3. Find helper/service files named after external services
4. For each integration found, explain:
   - What business feature does it enable?
   - Where is it used in the codebase?
   - What operations does it perform?
```

---

### Understanding Architecture

**Ask Claude Code:**
```
Explore this codebase and explain:

1. What architectural pattern is used?
   (MVC, microservices, monolith, clean architecture, hexagonal, etc.)

2. How is the code organized?
   - Directory structure
   - Purpose of each major directory
   - How do different parts interact?

3. What are the main components?
   - Entry points (main.py, server.js, main.go, etc.)
   - Core modules/packages
   - Data layer (database, ORM, repositories)

4. Are there any unique patterns or conventions?
   - Custom abstractions
   - Design patterns in use
   - Project-specific idioms

Focus on high-level architecture, not implementation details.
Skip: node_modules/, vendor/, dist/, build/
```

---

## Common Mistakes to Avoid

### ❌ Don't Duplicate package.json in CLAUDE.md

**Wrong:**
```markdown
## Dependencies
- express: ^5.0.0
- typescript: ^5.4.4
- mysql2: ^3.9.7
(... 50 more lines)
```

**Right:**
```markdown
## Tech Stack

> **Note:** Claude Code automatically reads package.json for full dependency list.

**Core Technologies:**
- **Framework:** Express.js 5.0 - Chosen for middleware ecosystem and team familiarity
- **Language:** TypeScript 5.4 - Type safety for large codebase
- **Database:** MySQL - Relational data with complex queries

**Why These Choices:**
- Express: Mature ecosystem, extensive middleware library
- TypeScript: Catch errors at compile time, better IDE support
- MySQL: Strong ACID guarantees for financial data
```

---

### ❌ Don't Document Implementation Details

**Wrong:**
```markdown
## User Authentication
Uses bcrypt to hash passwords with 10 salt rounds.
JWT tokens stored in cookies with httpOnly flag.
Refresh token rotation implemented with Redis.
```

**Right:**
```markdown
## User Authentication
**Purpose:** Secure user login with session management
**Pattern:** JWT-based authentication with refresh tokens
**Security:** Password hashing, httpOnly cookies, token rotation

(Claude Code can read the code to see HOW it's implemented)
```

---

### ❌ Don't Skip External API Purposes

**Wrong:**
```markdown
## External APIs
- Stripe
- Twilio
- SendGrid
```

**Right:**
```markdown
## External Services & APIs

### Stripe (Payment Processing)
- **Purpose:** Process customer payments for subscription plans
- **Used By:** Subscription management, billing system
- **Key Operations:** Create subscriptions, process payments, handle webhooks
- **Configuration:** API keys in .env, webhook endpoint at /api/webhooks/stripe

### Twilio (SMS Messaging)
- **Purpose:** Send SMS notifications and two-factor authentication codes
- **Used By:** 2FA system, order notifications
- **Key Operations:** Send SMS, verify phone numbers
- **Configuration:** Account SID and Auth Token in .env
```

---

## What to Document: Quick Checklist

### ✅ Do Document:

- [ ] **Business Purpose:** What problem does this solve?
- [ ] **Target Users:** Who uses this application?
- [ ] **Key Features:** What can users do? (from their perspective)
- [ ] **User Workflows:** Common user journeys
- [ ] **Why External APIs:** Business purpose of each integration
- [ ] **Why Tech Choices:** Reasons for choosing technologies
- [ ] **Coding Conventions:** Naming, formatting, organization patterns
- [ ] **Testing Requirements:** Framework, coverage, how to run tests
- [ ] **Architecture Pattern:** MVC, microservices, etc.

### ❌ Don't Document:

- [ ] **Implementation Details:** Claude Code reads the code
- [ ] **Full Dependency List:** Claude Code reads package.json
- [ ] **API Signatures:** Claude Code reads function definitions
- [ ] **Algorithm Details:** Focus on WHY, not HOW
- [ ] **Line-by-Line Code:** Code is self-documenting

---

## Example: Good vs Bad CLAUDE.md

### ❌ Bad Example (Too Technical, No Context):

```markdown
# Project Memory

## Tech Stack
- Node.js 18
- Express.js 5.0.0
- MySQL 8.0
- TypeScript 5.4.4

## Structure
- src/controllers/ - Controllers
- src/services/ - Services
- src/models/ - Models
```

**Problems:**
- No business context (what does this app DO?)
- Just lists technologies (Claude reads package.json)
- No explanation of WHY these choices
- No external API purposes
- No coding conventions

---

### ✅ Good Example (Business Context, Clear Purpose):

```markdown
# Project Memory - TaskFlow

## What Does This Application Do?

**TaskFlow** is a task management platform that helps remote teams coordinate work and track project progress.

**Target Users:** Remote teams, project managers, freelancers

**Core Features:**
1. **Real-Time Collaboration** - Multiple users edit tasks simultaneously
2. **Smart Notifications** - Context-aware alerts via email and SMS
3. **Time Tracking** - Automatic time logging for billable hours
4. **Client Portals** - Clients view project status without full access

**Primary User Workflows:**
- Team member creates task → Assigns to colleague → Tracks progress → Marks complete
- Manager creates project → Invites team → Reviews time reports → Invoices client
- Client logs in → Views project status → Approves deliverables

## Tech Stack

> **Note:** Claude Code automatically reads package.json for dependencies.

**Core Technologies:**
- **Framework:** Express.js - Chosen for middleware ecosystem and WebSocket support
- **Language:** TypeScript - Type safety for complex business logic
- **Database:** MySQL - Relational data with complex reporting queries

**Why These Choices:**
- Express: Best WebSocket integration for real-time features
- TypeScript: Catch errors early, essential for team of 8+ developers
- MySQL: Complex JOIN queries for time tracking reports

## External Services & APIs

### Twilio (SMS Notifications)
- **Purpose:** Send SMS notifications for urgent task updates
- **Used By:** Notification system, deadline reminders
- **Key Operations:** Send SMS when task assigned, send reminders 1 hour before deadline
- **Configuration:** Credentials in .env, webhook at /api/webhooks/twilio

### Stripe (Payment Processing)
- **Purpose:** Process subscription payments for premium features
- **Used By:** Subscription management, client portal access
- **Key Operations:** Create subscriptions, process payments, handle failed payments
- **Configuration:** API keys in .env, webhook at /api/webhooks/stripe

### SendGrid (Email Delivery)
- **Purpose:** Send email notifications and weekly digests
- **Used By:** Notification system, weekly summary emails
- **Key Operations:** Send transactional emails, batch send for digests
- **Configuration:** API key in .env, templates in SendGrid dashboard

## Architecture Pattern

**MVC with Service Layer:**
- Controllers: Validate requests, call services
- Services: Business logic, orchestrate models
- Models: Database interactions only

**No SQL in controllers or services** - All queries in models

## Code Style & Conventions

**Naming:**
- Controllers: `TaskController`, `UserController` (PascalCase)
- Services: `taskService`, `userService` (camelCase)
- Models: `TaskModel`, `UserModel` (PascalCase)
- Functions: `createTask`, `fetchUserTasks` (camelCase, verb-noun)

**Indentation:** 2 spaces (enforced by Prettier)

**Import Order:**
1. External packages (express, mysql2)
2. Internal types/interfaces
3. Services/Models
4. Constants/Config

**Response Pattern:**
All functions return: `{status: boolean, error: string | null, result?: T}`

## Testing Requirements

**Framework:** Jest + Supertest
**Coverage:** Minimum 80%
**Run Tests:** `npm test`
**Test Files:** `*.test.ts` next to source files

**Test Pattern:**
- Unit tests for services
- Integration tests for controllers
- E2E tests for critical workflows

## Security Guidelines

- **Never commit:** .env files, API keys, passwords
- **Validate all inputs:** Use Zod schemas in controllers
- **SQL Safety:** Use parameterized queries only (mysql2 with ? placeholders)
- **Authentication:** JWT tokens, refresh token rotation

## Common Commands

- **Dev Server:** `npm run dev` (nodemon + ts-node)
- **Run Tests:** `npm test` (Jest)
- **Build:** `npm run build` (TypeScript compiler)
- **Database Migrations:** `npm run migrate` (runs scripts in migrations/)

## Onboarding Checklist

**For New Developers:**
- [ ] Clone repo and run `npm install`
- [ ] Copy `.env.example` to `.env` and add credentials
- [ ] Run `npm run migrate` to set up local database
- [ ] Run `npm test` to verify setup
- [ ] Start dev server with `npm run dev`
- [ ] Read this CLAUDE.md file
- [ ] Review coding_guidelines/ folder

**For Claude Code:**
- [ ] Read this CLAUDE.md for project context
- [ ] Review package.json for tech stack
- [ ] Main entry point: src/server.ts
- [ ] Understand MVC + Service pattern
- [ ] Note SQL safety requirements
```

**Why This is Good:**
- ✅ Clear business purpose
- ✅ Explains WHY external APIs are used
- ✅ Documents conventions (not duplicating package.json)
- ✅ Provides architecture context
- ✅ Includes onboarding checklist

---

## Troubleshooting

### Problem: Claude Code doesn't understand my project

**Solution:** Add more business context to CLAUDE.md
- What problem does this solve?
- Who are the users?
- What are the key workflows?

### Problem: Claude Code suggests wrong patterns

**Solution:** Document your conventions in CLAUDE.md
- Show example function names
- Explain directory structure
- Reference style guides

### Problem: Claude Code re-reads files unnecessarily

**Solution:** Add to "Agent Optimization Notes" in CLAUDE.md
```markdown
## Agent Optimization Notes

**Skip These:**
- node_modules/ (dependencies)
- dist/ (build output)
- coverage/ (test reports)

**Reference Instead of Re-reading:**
- "Follow UserController pattern for new controllers"
- "See taskService.ts for service example"
```

---

## Optimizing Your Workflow (v3.4.0+)

### workflow-analyzer Skill - Improve Quality Through Pattern Recognition

After onboarding your project, the **workflow-analyzer skill** can scan your git workflow to identify optimization opportunities.

**Auto-activates on:**
- "What patterns do you see in my workflow?"
- "How can I improve my commit quality?"
- "Analyze my recent commits"
- "What operations do I repeat manually?"

**What it does:**
- Tracks your git commit patterns over time
- Identifies repeated manual operations
- Finds queries that skills don't handle well yet
- Suggests workflow improvements proactively
- Enables skill evolution based on YOUR patterns

**Example Use:**
```
You: "Analyze my workflow for the last 2 weeks"

workflow-analyzer: "I notice you commit documentation updates
separately from code changes (12 out of 15 commits). This is
great for clarity! However, you manually check version sync
across 5 files before each release. Consider using the
version-management skill to automate this check."
```

**Benefits:**
- **Self-awareness** - Understand your workflow habits
- **Quality improvement** - Catch patterns that slow you down
- **Skill suggestions** - Get recommendations for new skills
- **Meta-learning** - Project improves based on YOUR usage

See: `.claude/skills/workflow-analyzer/SKILL.md` for details.

---

## Next Steps

After completing this onboarding:

1. **Test Claude Code** - Ask it questions about your project
2. **Refine CLAUDE.md** - Add details as you discover them
3. **Use workflow-analyzer** - Scan your workflow after 10-15 commits to identify optimization opportunities
4. **Create Custom Commands** - Add project-specific slash commands (or graduate to natural language!)
5. **Share with Team** - Commit .claude/ and CLAUDE.md to version control

---

## Questions?

**Template Issues:** Check [README.md](../../../README.md)
**Claude Code Docs:** https://code.claude.com/docs
**MCP Setup:** [02_mcp-setup.md](../../../01_global-setup/02_good-to-have/02_mcp-setup.md)

---

**Last Updated:** 2025-12-04
**Template Version:** 2.0
**Time to Complete:** 30-45 minutes (one-time setup)
