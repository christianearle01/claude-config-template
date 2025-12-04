---
name: onboarding
description: Help new developers understand this codebase
---

Provide a friendly, comprehensive onboarding guide for this project.

**Read from CLAUDE.md and create a welcoming guide:**

## Welcome to [PROJECT NAME]! 👋

### What This Application Does

[Read from CLAUDE.md "What Does This Application Do?" section]
- What problem does it solve?
- Who are the users?
- Key features from user perspective

### Tech Stack Overview

[Read from CLAUDE.md "Tech Stack" and package.json]
- Core technologies (language, framework, database)
- Why these were chosen
- Key dependencies

### Getting Started

**Setup Steps:**
[From CLAUDE.md "Onboarding Checklist"]
1. Clone and install dependencies
2. Set up local environment
3. Run tests to verify setup
4. Start development server

**Common Commands:**
[From CLAUDE.md "Common Commands"]
- Dev server: `[command]`
- Run tests: `[command]`
- Build: `[command]`

### Project Structure

[From CLAUDE.md "Project Structure"]
Explain directory organization:
- Where to find main application code
- Where to find tests
- Where to find configuration
- Where to find documentation

### Architecture & Patterns

[From CLAUDE.md]
- Architectural pattern (MVC, microservices, etc.)
- Request flow
- Common patterns to follow
- Reference implementations

### External Integrations

[From CLAUDE.md "External Services & APIs"]
For each integration:
- What it does (business purpose)
- Where it's used in the codebase
- How to configure it

### Coding Standards Quick Hits

[From CLAUDE.md "Code Style & Conventions"]
- Naming conventions
- Indentation rules
- Import organization
- Testing requirements

### Where to Find Things

**Need to work on authentication?**
→ Check [path from CLAUDE.md]

**Need to understand database schema?**
→ Check [path from CLAUDE.md]

**Need examples of patterns?**
→ Reference [files from CLAUDE.md "Agent Optimization Notes"]

### Next Steps for Your First Day

1. Read this CLAUDE.md file completely
2. Set up your local environment
3. Run the test suite to verify setup
4. Pick a small "good first issue" to understand the codebase
5. Ask questions - the team is here to help!

**Helpful Commands:**
- `/standards` - Quick reference to coding standards
- `/test` - Run the test suite
- `/review [file]` - Get code review feedback

---

**Make the guide:**
- Friendly and welcoming (not intimidating)
- Practical (focus on what they need to know NOW)
- Clear about next steps
- Encouraging about asking questions

**Example tone:**
"Welcome! You'll be productive here in no time. This project uses [framework] to help [users] do [thing]. Let's get you set up..."

NOT:
"This is a complex system with 47 microservices using advanced patterns..."

**If CLAUDE.md is incomplete or missing key sections:**
Suggest to the user: "Your CLAUDE.md needs more information. Run [TEMPLATE_PATH]/ONBOARDING_EXISTING_PROJECT.md setup guide to document the project properly."
