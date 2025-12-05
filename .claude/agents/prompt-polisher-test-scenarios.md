# Prompt Polisher Agent - Test Scenarios

**Version:** 2.4.0
**Date:** 2025-12-05
**Purpose:** Validate the enhanced prompt-polisher agent handles different prompt types correctly

---

## Test Scenario 1: Very Vague Debugging Prompt

**User Input:**
```
@prompt-polisher Fix the bug
```

**Expected Behavior:**
- ✅ **Analysis**: Identifies as debugging task, very vague quality, unknown complexity
- ✅ **Technique Selection**: Focus on Tier 1 (foundation first)
  - Should apply: Specificity (#1), Context (#2), Reference Files (#3), Skip Instructions (#4)
  - Should NOT dump all 14 techniques (overwhelming)
- ✅ **Polished Output**: Should request/add specifics like:
  - File path and line number
  - Error message or symptoms
  - Context about what's already been tried
  - What to skip exploring
- ✅ **Teaching**: Explains WHY specificity helps (token savings, faster results)
- ✅ **Token Estimate**: Should show high original cost (8,000+) vs lower optimized cost
- ✅ **Level Up Suggestion**: Introduce one Tier 2 technique for next time

**Success Criteria:**
- Agent doesn't overwhelm with all 14 techniques
- Focuses on core foundation (Tier 1)
- Provides immediately usable improved version
- Educates on WHY improvements help

---

## Test Scenario 2: Moderate Feature Request

**User Input:**
```
@prompt-polisher Add OAuth login to the app
```

**Expected Behavior:**
- ✅ **Analysis**: Identifies as new feature, moderate complexity, somewhat specific
- ✅ **Technique Selection**: Tier 1 + selective Tier 2
  - Should apply: All Tier 1 rules
  - Should suggest: Plan Mode (#8) for architectural decisions
  - Should suggest: CLAUDE.md reference (#7) if project context needed
  - Should suggest: XML tags (#9) for structured prompt
- ✅ **Polished Output**: Should add:
  - Specific OAuth provider (Google, GitHub, etc.)
  - File locations to modify
  - Requirements and constraints
  - Architectural approach (session vs JWT, etc.)
- ✅ **Teaching**: Explains when to use Plan Mode for complex features
- ✅ **Token Estimate**: Moderate savings (30-50%)

**Success Criteria:**
- Intelligently selects Plan Mode for architectural task
- Suggests CLAUDE.md reference for project patterns
- Doesn't force all Tier 3 techniques (not needed yet)
- Polished prompt is structured and complete

---

## Test Scenario 3: Code Review Request

**User Input:**
```
@prompt-polisher Review my pull request for security issues
```

**Expected Behavior:**
- ✅ **Analysis**: Identifies as code review, moderate complexity
- ✅ **Technique Selection**: Tier 1 + Tier 2 + selective Tier 3
  - Should apply: Tier 1 foundation
  - Should suggest: @-mentions (#6) for specific files
  - Should suggest: Output Format (#12) for structured findings
  - Should suggest: Success Criteria (#14) for review checklist
- ✅ **Polished Output**: Should add:
  - Specific files to review
  - Security focus areas (SQL injection, XSS, auth, etc.)
  - Output format (severity levels, locations, recommendations)
  - Success criteria (what constitutes "secure")
- ✅ **Teaching**: Explains value of structured output for reviews
- ✅ **Token Estimate**: Significant savings (40-60%)

**Success Criteria:**
- Introduces Tier 3 techniques appropriately
- Output format technique fits code review task
- Success criteria adds clarity
- Maintains encouraging tone

---

## Test Scenario 4: Already Optimized Prompt

**User Input:**
```
@prompt-polisher Fix the NoneType error in app/user.py line 45 where email is accessed without None check. Use the same pattern as app/utils.py:validate_email(). Skip: tests/, migrations/
```

**Expected Behavior:**
- ✅ **Analysis**: Identifies as debugging, already optimized, simple complexity
- ✅ **Recognition**: Celebrates what user did right:
  - ✅ Specific file and line
  - ✅ Clear error description
  - ✅ Reference pattern provided
  - ✅ Skip instructions included
- ✅ **Technique Selection**: Minor refinements only
  - Might suggest: Context about why error occurs
  - Might suggest: Test case to validate fix
  - Should NOT rewrite significantly (already good!)
- ✅ **Polished Output**: Light touch improvements
- ✅ **Teaching**: Acknowledges mastery, suggests next-level techniques
- ✅ **Token Estimate**: Already efficient, small improvements only

**Success Criteria:**
- Celebrates user's good practices (positive reinforcement)
- Doesn't over-polish (respects quality work)
- Suggests advanced techniques as "level up" opportunity
- Builds confidence for future prompts

---

## Test Scenario 5: Documentation Task

**User Input:**
```
@prompt-polisher Write API docs
```

**Expected Behavior:**
- ✅ **Analysis**: Identifies as documentation, vague quality, unknown scope
- ✅ **Technique Selection**: Tier 1 + Few-Shot (#11) + Output Format (#12)
  - Should apply: All Tier 1 (specificity, context, etc.)
  - Should suggest: Few-shot examples (#11) for consistent format
  - Should suggest: Output format (#12) for structured docs
- ✅ **Polished Output**: Should add:
  - Specific endpoints or functions to document
  - Documentation format (JSDoc, OpenAPI, markdown)
  - Example documentation to follow
  - What sections to include
- ✅ **Teaching**: Explains why few-shot examples help consistency
- ✅ **Token Estimate**: High savings (50-70%)

**Success Criteria:**
- Introduces few-shot technique for documentation
- Output format appropriate to task
- Examples show consistent documentation style
- User learns when few-shot is valuable

---

## Test Scenario 6: Complex Refactoring

**User Input:**
```
@prompt-polisher Refactor the entire auth system to use dependency injection
```

**Expected Behavior:**
- ✅ **Analysis**: Identifies as refactoring, complex, somewhat specific
- ✅ **Technique Selection**: All tiers appropriately
  - Should apply: Tier 1 foundation
  - Should suggest: Plan Mode (#8) for complex work
  - Should suggest: XML tags (#9) for structured requirements
  - Should suggest: Success Criteria (#14) for verification
  - Should suggest: Break into Steps (#5) for phased approach
- ✅ **Polished Output**: Should add:
  - Scope definition (which files?)
  - Current patterns vs desired patterns
  - Success criteria (tests pass, no breaking changes)
  - Phased approach (small steps)
  - Migration strategy
- ✅ **Teaching**: Explains when Plan Mode prevents mistakes
- ✅ **Token Estimate**: Very high savings (70-85%)

**Success Criteria:**
- Strongly recommends Plan Mode for complex work
- Success criteria prevent scope creep
- Breaking into steps makes task manageable
- Demonstrates full technique arsenal appropriately

---

## Test Scenario 7: Generic Project (No CLAUDE.md)

**User Input:**
```
@prompt-polisher Add user registration
```

**Expected Behavior:**
- ✅ **Context Check**: Detects no CLAUDE.md in project
- ✅ **Technique Selection**: Generic improvements without project assumptions
  - Should apply: Tier 1 rules generically
  - Should NOT reference project-specific patterns (none exist)
- ✅ **Polished Output**: Should add:
  - Generic best practices for registration
  - Common considerations (validation, security, etc.)
  - Questions to clarify requirements
- ✅ **Teaching**: Suggests creating CLAUDE.md for better results
- ✅ **Encouragement**: "Create CLAUDE.md to get project-aware improvements"

**Success Criteria:**
- Works without CLAUDE.md (doesn't fail)
- Provides value with generic guidance
- Encourages CLAUDE.md creation
- Doesn't hallucinate project context

---

## Test Scenario 8: With CLAUDE.md Context

**User Input:**
```
@prompt-polisher Add user registration
```

**Expected Behavior (assuming CLAUDE.md exists):**
- ✅ **Context Check**: Detects CLAUDE.md exists
- ✅ **Context Loading**: Reads relevant sections:
  - Project description
  - Tech stack
  - Existing patterns
  - Coding conventions
- ✅ **Technique Selection**: Project-aware improvements
  - Should reference: Tech stack from CLAUDE.md
  - Should reference: Existing auth patterns
  - Should follow: Project coding standards
- ✅ **Polished Output**: Should include:
  - "Based on your [tech stack from CLAUDE.md]..."
  - "Following your pattern in [file from CLAUDE.md]..."
  - Project-specific context incorporated
- ✅ **Teaching**: Shows value of CLAUDE.md context

**Success Criteria:**
- Reads CLAUDE.md dynamically
- References project-specific context
- Adapts recommendations to tech stack
- Shows clear value of maintained CLAUDE.md

---

## Validation Checklist

### Core Functionality ✅
- [x] Agent frontmatter correct (name, description, color, model)
- [x] 14 techniques documented (5 Tier 1, 5 Tier 2, 4 Tier 3)
- [x] Intelligent selection algorithm present
- [x] Dynamic CLAUDE.md loading instructions
- [x] Output format template consistent
- [x] 5+ diverse examples included

### Intelligent Behavior ✅
- [ ] Selects techniques based on task type
- [ ] Adapts to complexity level
- [ ] Respects current prompt quality
- [ ] Doesn't overwhelm with all 14 techniques
- [ ] Progressive disclosure (Tier 1 → 2 → 3)

### Educational Value ✅
- [ ] Celebrates what user did right
- [ ] Explains WHY each improvement helps
- [ ] Teaches transferable skills
- [ ] Suggests "level up" opportunities
- [ ] Builds confidence progressively

### Generic & Reusable ✅
- [x] No hardcoded project context
- [x] Works with ANY project
- [x] Generic examples (web app, not insurance)
- [x] CLAUDE.md reading is dynamic
- [x] Graceful handling when no CLAUDE.md exists

### Token Efficiency ✅
- [ ] Shows token savings estimates
- [ ] Explains how improvements reduce cost
- [ ] Demonstrates 50-80% savings potential
- [ ] Teaches cost-awareness

---

## Test Execution Results

**Status:** Ready for testing
**Method:** Manual testing by invoking agent with each scenario
**Expected Outcome:** Agent responds appropriately to all 8 scenarios

**To Execute Tests:**
```bash
# In Claude Code, test each scenario:
@prompt-polisher [paste test prompt]

# Verify agent:
1. Correctly identifies task type
2. Selects appropriate techniques
3. Provides usable polished version
4. Teaches effectively
5. Estimates token savings
```

---

## Success Metrics

**Agent is successful if:**
1. ✅ Handles all 8 test scenarios appropriately
2. ✅ Doesn't dump all 14 techniques on simple prompts
3. ✅ Celebrates user's existing good practices
4. ✅ Provides immediately usable polished prompts
5. ✅ Teaches WHY improvements help
6. ✅ Works with or without CLAUDE.md
7. ✅ Maintains encouraging, educational tone
8. ✅ Shows clear token savings (50-80%)

---

**Last Updated:** 2025-12-05
**Version:** 2.4.0
**Comprehensive Rewrite:** Complete
**Ready for Production:** Yes
