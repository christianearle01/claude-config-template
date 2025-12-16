# Prompt Optimization Guide - Maximize Claude Code Experience

## Overview

This guide teaches you how to write effective prompts that maximize Claude Code's efficiency, minimize token waste, and get better results faster.

---

## Why This Matters

**Without prompt optimization skills:**
- Vague prompts waste 5,000-15,000 tokens per request (Claude explores unnecessarily)
- Poor results require multiple iterations (2-3× more tokens to get it right)
- Claude reads wrong files, makes wrong assumptions, implements wrong solutions
- Monthly costs: $100-200 wasted on inefficient prompts

**With optimized prompts:**
- Specific prompts use 500-2,000 tokens (80-90% reduction)
- Higher first-time-right rate (1 iteration vs 2-3 = 60-70% token savings)
- Claude focuses on exactly what you need (no wasted exploration)
- Better quality output (clear instructions = better implementation)

**Time investment:** 15 minutes to learn 5 golden rules
**Projected savings:** $80-150/month + better output quality

---

## The Golden Rules of Claude Code Prompts

### 1. **Be Specific, Not Vague**
### 2. **Provide Context, Don't Make Claude Discover It**
### 3. **Reference Known Files and Patterns**
### 4. **Tell Claude What to Skip**
### 5. **Break Complex Tasks into Clear Steps**

---

## Rule 1: Be Specific, Not Vague

### ❌ Vague Prompts (High Token Cost)

```
"Fix the bug"
```
**Problems:**
- Claude doesn't know which bug
- Will read many files looking for issues
- May fix the wrong thing
- Cost: 5,000-15,000 tokens

```
"Improve the code"
```
**Problems:**
- Undefined scope
- Will analyze entire codebase
- Unclear what "improve" means
- Cost: 10,000-20,000 tokens

```
"Add authentication"
```
**Problems:**
- Too broad - what kind of auth?
- Where to add it?
- Will explore entire project first
- Cost: 8,000-15,000 tokens

### ✅ Specific Prompts (Low Token Cost)

```
"Fix the NoneType error in app/leadprosper_client.py:127
where lead_data['email'] is accessed without checking if it exists"
```
**Benefits:**
- Exact file and line number
- Specific error type
- Clear fix needed
- Cost: 500-1,000 tokens

```
"Refactor the OAuth token refresh logic in app/leadprosper_client.py
to use exponential backoff instead of fixed 5-second retry"
```
**Benefits:**
- Specific file and function
- Clear before/after behavior
- Focused scope
- Cost: 1,000-2,000 tokens

```
"Add JWT token authentication to the /api/leads endpoint
following the same pattern used in app/leadprosper_client.py:45-67"
```
**Benefits:**
- Specific endpoint
- References existing pattern
- Clear implementation approach
- Cost: 1,500-2,500 tokens

---

## Rule 2: Provide Context, Don't Make Claude Discover It

### ❌ Context-Less Prompts

```
"Implement the new vendor integration"
```
**What Claude has to do:**
1. Grep for existing integrations (500 tokens)
2. Read multiple vendor files (3,000 tokens)
3. Analyze patterns (2,000 tokens)
4. Figure out project structure (1,500 tokens)
5. Finally implement (2,000 tokens)
**Total: 9,000 tokens**

### ✅ Context-Rich Prompts

```
"Implement NCC vendor integration following the LeadProsper pattern.

Context:
- Reference implementation: app/leadprosper_client.py
- Pattern: POST request to vendor API with form data
- Form mappings: CSV file in root directory
- Authentication: Bearer token from .env
- Response handling: Check status_code, log on failure

Tasks:
1. Create app/ncc_client.py based on LeadProsper structure
2. Create Form Fields Mapping - NCC - AUTO Insurance.csv
3. Add NCC_API_KEY to .env.example
4. Wire into existing API endpoint pattern

Files to reference:
- app/leadprosper_client.py (main pattern)
- app/api/views.py (endpoint integration)

Files to skip:
- Other vendor implementations (different patterns)
- Test files (will add tests after)
- CSV files (just copy format)
"
```
**What Claude does:**
1. Read reference file (from cache: 100 tokens)
2. Copy pattern (500 tokens)
3. Implement (1,500 tokens)
**Total: 2,100 tokens (77% savings)**

---

## Rule 3: Reference Known Files and Patterns

### ❌ Without File References

```
"Add error logging to the API calls"
```
**Problems:**
- Which API calls?
- Claude searches all files for API calls
- May miss some or log wrong things
- Cost: 5,000-8,000 tokens

### ✅ With File References

```
"Add error logging to the LeadProsper API calls in:
- app/leadprosper_client.py:127 (post_lead method)
- app/leadprosper_client.py:89 (refresh_token method)

Use the same logging pattern from app/api/views.py:45
Log: timestamp, endpoint, status_code, error_message
Don't log: lead_data (contains PII)"
```
**Benefits:**
- Exact files and line numbers
- Specific methods
- References existing pattern
- Security awareness
- Cost: 1,000-1,500 tokens

---

## Rule 4: Tell Claude What to Skip

### ❌ Without Skip Instructions

```
"Find all API endpoints in the project"
```
**What Claude reads:**
- app/api/ (needed)
- app/tests/ (not needed)
- migrations/ (not needed)
- CSV files (not needed)
- vendor_* files (not needed)
**Cost: 10,000+ tokens**

### ✅ With Skip Instructions

```
"Find all API endpoints in app/api/

Skip:
- test files (not endpoints)
- migrations (database only)
- CSV files (just data)
- vendor client files (internal, not endpoints)

Focus: @app.route or path() definitions"
```
**What Claude reads:**
- app/api/ only
**Cost: 2,000 tokens (80% savings)**

---

## Rule 5: Break Complex Tasks into Clear Steps

### ❌ One Massive Prompt

```
"Build a complete OAuth2 system with Google, GitHub, and email login,
password reset, 2FA, session management, and admin dashboard"
```
**Problems:**
- Too complex for one response
- Claude may skip steps
- Hard to verify each part
- May exceed token limits
- Cost: 30,000+ tokens (may fail)

### ✅ Step-by-Step Approach

```
Step 1: "Set up OAuth2 base structure in app/auth/oauth.py
- Create OAuthProvider base class
- Add redirect_uri and state validation
- Reference: app/leadprosper_client.py for API client pattern"
```
**Cost: 2,000 tokens**

```
Step 2: "Implement Google OAuth provider
- Extend OAuthProvider from Step 1
- Use GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET from .env
- Implement get_auth_url() and handle_callback()
- Test with existing test pattern from app/tests/"
```
**Cost: 2,500 tokens**

```
Step 3: "Add session management using Redis
- Install redis client
- Create app/auth/session.py
- Store user_id and OAuth tokens
- Set 24-hour expiration"
```
**Cost: 2,000 tokens**

**Total: 6,500 tokens vs 30,000+ (78% savings + higher success rate)**

---

## Real-World Examples from Your Workflow

### Example 1: Debugging API Integration

**❌ Inefficient:**
```
"The LeadProsper integration is broken, fix it"
```

**✅ Optimized:**
```
"Fix LeadProsper API timeout error in app/leadprosper_client.py:127

Error: requests.exceptions.Timeout when posting leads
Occurs: Only for leads with 10+ form fields
Current timeout: 5 seconds (line 45)

Solution needed:
- Increase timeout to 30 seconds for post_lead()
- Add retry logic (max 3 attempts)
- Log timeout occurrences

Don't change: Other API methods, they work fine"
```

**Savings: 4,000 tokens → 800 tokens (80% savings)**

---

### Example 2: Adding New Feature

**❌ Inefficient:**
```
"Add form validation"
```

**✅ Optimized:**
```
"Add email and phone validation to LeadProsper form submission

Location: app/leadprosper_client.py, post_lead() method (line 127)

Validation rules:
- Email: RFC 5322 format, required
- Phone: 10 digits, US format, optional
- Use existing regex patterns from app/validators.py

Error handling:
- Return validation errors before API call
- Same format as current API errors (dict with 'errors' key)

Test with: app/test_leadprosper.py, add test_invalid_email case

Skip: Other vendors (will add validation separately)"
```

**Savings: 6,000 tokens → 1,500 tokens (75% savings)**

---

### Example 3: Code Review and Refactoring

**❌ Inefficient:**
```
"Review the code and suggest improvements"
```

**✅ Optimized:**
```
"Review app/leadprosper_client.py for performance improvements

Focus areas:
1. Lines 89-120: Token refresh logic (called on every request)
2. Lines 127-180: Form data serialization (large CSV files)
3. Lines 200-230: Retry logic (may cause delays)

Looking for:
- Caching opportunities (especially token refresh)
- Batch processing for CSV parsing
- Async/await for API calls

Keep:
- Current error handling (it works well)
- Logging format (team requirement)

Don't review: Other files, just this one"
```

**Savings: 10,000 tokens → 2,000 tokens (80% savings)**

---

### Example 4: Writing Tests

**❌ Inefficient:**
```
"Write tests"
```

**✅ Optimized:**
```
"Write unit tests for app/leadprosper_client.py post_lead() method

Test cases needed:
1. Successful lead post (200 response)
2. API timeout handling (500 error)
3. Invalid email validation (before API call)
4. Token refresh on 401 error

Test framework: pytest (already in requirements.txt)
Test location: app/tests/test_leadprosper.py (create if needed)
Mock API calls: Use responses library (see app/tests/test_quotewizard.py:23 for example)

Follow existing test pattern from:
- app/tests/test_quotewizard.py (structure)
- app/tests/conftest.py (fixtures)

Target coverage: 85% (project minimum)"
```

**Savings: 8,000 tokens → 2,500 tokens (69% savings)**

---

### Example 5: Documentation

**❌ Inefficient:**
```
"Document the codebase"
```

**✅ Optimized:**
```
"Add docstrings to app/leadprosper_client.py methods

Methods to document:
- __init__() (line 15)
- refresh_token() (line 89)
- post_lead() (line 127)
- _serialize_form_data() (line 200)

Docstring format: Google style (existing project standard)
Include:
- Brief description
- Args with types
- Returns with type
- Raises (for exceptions)
- Example usage (for post_lead only)

Reference existing docstrings: app/quotewizard_client.py:45

Skip:
- Private methods (starting with __)
- Test files (separate task)
- Other vendor files (will do separately)"
```

**Savings: 12,000 tokens → 2,000 tokens (83% savings)**

---

## Advanced Techniques

### Technique 1: Use @-mentions for File Context

```
"Add error handling to @app/leadprosper_client.py post_lead() method

Handle these errors:
- ConnectionError: Retry 3 times
- Timeout: Log and return error response
- HTTPError: Check status code, refresh token if 401

Follow the error pattern in @app/quotewizard_client.py"
```

**Benefits:**
- @-mention auto-includes file content
- Claude has full context immediately
- No need to search for files

### Technique 2: Reference CLAUDE.md Sections

```
"Implement data tracking as described in CLAUDE.md

Use:
- Integration vendors section for API patterns
- Security & Privacy section for logging rules
- Development workflow for branch naming

Create:
- app/tracking/events.py (event definitions)
- app/tracking/logger.py (logging logic)

Pattern: Follow LeadProsper client structure"
```

**Benefits:**
- Leverages project memory
- Enforces project standards
- Reduces re-explanation

### Technique 3: Use Plan Mode for Complex Work

```
"Plan the implementation of multi-vendor lead distribution

Requirements:
- Post to highest bidder first (Ricochet360)
- If rejected, post to next bidder (QuoteWizard)
- If rejected, post to lowest bidder (NCC)
- Track success/failure for each vendor
- Store in database for analytics

Don't implement yet, just create implementation plan.

Reference:
- Current vendor integrations in app/*_client.py
- Database models in app/models.py
- API endpoints in app/api/views.py"
```

**Benefits:**
- Get plan first, verify approach
- Claude thinks through architecture
- Catch issues before implementation
- Save tokens on rewrites

---

## Token Usage Comparison

| Task Type | Bad Prompt | Good Prompt | Savings |
|-----------|------------|-------------|---------|
| Bug fix | 5,000 tokens | 800 tokens | 84% |
| New feature | 10,000 tokens | 2,500 tokens | 75% |
| Code review | 15,000 tokens | 3,000 tokens | 80% |
| Testing | 8,000 tokens | 2,500 tokens | 69% |
| Documentation | 12,000 tokens | 2,000 tokens | 83% |

**Average savings: 78%**

---

## Workflow Integration Tips

### Daily Development Workflow

1. **Morning - Plan Your Day**
```
"Review CLAUDE.md and list 3 priority tasks for today:
1. Bug fixes in app/leadprosper_client.py
2. Add NCC vendor integration
3. Update form validation

For each task, suggest specific file and line numbers to focus on."
```

2. **During Work - Specific Requests**
```
"Implement task #2 from today's plan: NCC vendor integration

Context already established in morning plan.
Use LeadProsper as reference (app/leadprosper_client.py).
Skip exploration, just implement."
```

3. **End of Day - Review and Document**
```
"Review changes made today in:
- app/ncc_client.py (new file)
- app/api/views.py (modified lines 45-67)

Add to CLAUDE.md:
- NCC integration complete (add to vendors list)
- New pattern: async API calls (add to conventions)

Generate commit message following Conventional Commits."
```

### Git Workflow Integration

**Starting new feature:**
```
"Create feature branch for OAuth implementation

Current branch: develop-leadprosper (from git status)
New branch: feature/oauth-integration

Update CLAUDE.md:
- Current Branch Context section
- Add: Working on OAuth (reference: planning doc in issues/)"
```

**Before committing:**
```
"Review changes for commit in:
- app/auth/ (new files)
- app/api/views.py (modified)
- requirements.txt (added packages)

Check:
1. No .env or credentials committed
2. Follows project code style
3. Tests pass (run pytest)
4. Update CLAUDE.md with new auth location

Generate commit message if all checks pass."
```

### Code Review Workflow

**Reviewing PR:**
```
"Review PR changes in app/leadprosper_client.py

Focus on:
1. Lines 45-67 (new retry logic) - check error handling
2. Lines 127-145 (timeout changes) - verify values reasonable
3. Lines 200-220 (logging) - ensure no PII logged

Compare against:
- Project security guidelines in CLAUDE.md
- Existing patterns in app/quotewizard_client.py
- Test coverage in app/tests/

Provide: Specific line-by-line feedback"
```

### Debugging Workflow

**When error occurs:**
```
"Debug error in lead posting flow

Error message:
[paste exact error message]

Occurred when:
- Posting lead with 15 form fields
- To LeadProsper API
- Lead contains email: test@example.com

Current code: app/leadprosper_client.py:127
Recent changes: Added validation (commit abc123)

Check:
1. Validation logic (may be rejecting valid data)
2. API payload format (may have changed)
3. Timeout settings (large payload may need more time)

Start with most likely cause (validation), then move to others."
```

---

## Common Mistakes to Avoid

### Mistake 1: "Figure it out yourself"
```
❌ "Make it work"
✅ "Fix the 500 error in app/leadprosper_client.py:127 when posting leads with missing email field"
```

### Mistake 2: "Do everything"
```
❌ "Build the entire system"
✅ "Build OAuth base class in app/auth/oauth.py, following app/leadprosper_client.py structure"
```

### Mistake 3: "You know what I mean"
```
❌ "Add that feature we discussed"
✅ "Add email validation to post_lead() method using regex from app/validators.py"
```

### Mistake 4: "Search everywhere"
```
❌ "Find where we handle errors"
✅ "Check error handling in app/leadprosper_client.py lines 89-120 and app/api/views.py lines 45-67"
```

### Mistake 5: "Make it better"
```
❌ "Optimize the code"
✅ "Cache OAuth tokens in Redis to reduce API calls in app/leadprosper_client.py:89 refresh_token() method"
```

---

## Quick Reference Prompt Template

Use this template for any task:

```
[ACTION] [WHAT] in [WHERE]

Context:
- [Relevant background]
- [Existing patterns to follow]
- [Known constraints]

Specific steps:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Reference files:
- [File 1] (for pattern)
- [File 2] (for integration)

Skip:
- [What not to touch]
- [What not to read]

Success criteria:
- [How to verify it works]
```

### Example:
```
Implement phone validation in app/leadprosper_client.py post_lead() method

Context:
- Email validation already exists (line 135)
- Using regex from app/validators.py
- Phone is optional field

Specific steps:
1. Import phone_regex from app/validators.py
2. Add validation after email check (line 138)
3. Return error if invalid format
4. Skip validation if phone is None

Reference files:
- app/validators.py (regex patterns)
- app/quotewizard_client.py:156 (similar validation)

Skip:
- Other vendor clients (will add separately)
- Test files (separate task)

Success criteria:
- Rejects invalid phone formats
- Accepts valid 10-digit US numbers
- Allows None/empty values
```

---

## Monitoring Your Optimization

Track your improvement over time:

```bash
# Check usage limits
/usage
# Monitor: you should be using less of your plan limits with optimized prompts

# Note: Track savings by:
# - Shorter conversations (fewer messages to reach goals)
# - More efficient model usage (Haiku instead of Sonnet/Opus)
# - Better prompt specificity (first-try success rate)
```

**Tip:** While there's no direct cost tracking command, you can estimate savings by:
- Using `/usage` to check plan limits consumption
- Tracking model switches (Haiku = 92% cheaper than Sonnet)
- Monitoring conversation length (fewer back-and-forths = fewer tokens)

---

## Summary: Prompt Optimization Checklist

Before sending any prompt, check:

- [ ] **Specific**: Exact file, line number, method name?
- [ ] **Context**: Referenced existing patterns?
- [ ] **Known info**: Mentioned what Claude shouldn't discover?
- [ ] **Skip list**: Told Claude what to ignore?
- [ ] **Steps**: Broken complex task into clear steps?
- [ ] **Success criteria**: Defined how to verify completion?

**Follow this checklist → Save 50-80% on tokens → Get better results faster**

---

## Additional Resources

- **Agent coordination**: `.claude/AGENT_COORDINATION_GUIDE.md`
- **Implementation guide**: `.claude/IMPLEMENTATION_GUIDE.md`
- **Team onboarding**: `~/Developer/claude-config-template/TEAM_ONBOARDING.md`
- **Project memory**: `CLAUDE.md`

---

**Master these techniques and watch your Claude Code productivity soar while token costs plummet!**
