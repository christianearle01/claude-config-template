# Socratic Review Guidelines

**Purpose:** Transform code reviews from gatekeeping to teaching through curiosity-driven questions

**Part of:** v4.20.1 "External Perspectives - Enterprise Edition"
**Source:** Pattern 8 (Socratic Review Framework) from Addy Osmani + NLW
**Target Audience:** Code reviewers, team leads, senior developers

---

## The Core Problem

With AI code generation, developers submit PRs containing code they don't fully understand:
- AI generated the scaffolding quickly (the easy 70%)
- Developer copied without comprehension
- Code may work but developer can't maintain it
- Creates **false productivity** (shipping fast without learning)

**Traditional Review Approach:**
- Reviewer: "This implementation is wrong." ❌
- Submitter: Feels judged, doesn't learn, becomes dependent on approval

**Socratic Review Approach:**
- Reviewer: "Why did you choose this approach?" ✅
- Submitter: Must articulate reasoning, identifies gaps themselves, builds understanding

---

## The Five Question Categories

Use these categories to guide educational code reviews:

### 1. Understanding Questions

**Purpose:** Verify the submitter comprehends their own code

**Sample Questions:**
- "Can you walk me through how this works?"
- "What's the purpose of this function/class/module?"
- "How does this integrate with [existing system]?"
- "What would happen if we removed line [X]?"
- "Why did we need to add this dependency?"
- "Can you explain this in your own words?"

**When to Use:**
- Always for AI-generated code
- Complex logic or algorithms
- New patterns or architectures
- External integrations

**What You're Testing:**
- Can the submitter explain the code without referring to AI output?
- Do they understand the "why," not just the "what"?
- Can they trace data flow or execution path?

---

### 2. Alternative Exploration Questions

**Purpose:** Encourage critical thinking about design choices

**Sample Questions:**
- "What other solutions did you explore?"
- "Why did you choose this library/pattern/approach?"
- "What trade-offs did you consider?"
- "Are there simpler solutions we should consider?"
- "Why did you choose X over Y?"
- "What are the pros and cons of this approach?"

**When to Use:**
- Major architectural decisions
- Library/framework choices
- Design pattern selection
- Performance vs readability trade-offs

**What You're Testing:**
- Did the submitter consider alternatives, or just accept first solution?
- Do they understand trade-offs?
- Can they articulate decision criteria?

---

### 3. Edge Case Discovery Questions

**Purpose:** Identify scenarios the code might not handle

**Sample Questions:**
- "What scenarios might break this?"
- "How does this handle errors/nulls/empty inputs?"
- "What assumptions is this code making?"
- "What happens if [unexpected scenario]?"
- "How does this handle concurrent access?"
- "What if the API returns an error?"
- "What are the boundary conditions?"

**When to Use:**
- User input handling
- External API integrations
- Data validation
- Error handling
- Concurrent operations

**What You're Testing:**
- Did the submitter think through failure modes?
- Are edge cases tested?
- Is error handling comprehensive?

**The 70/30 Connection:**

This is where the **hard 30%** lives (see Pattern 7: The 70/30 Problem). AI generates scaffolding fast but often misses edge cases. This category helps identify what AI missed.

---

### 4. Maintainability Assessment Questions

**Purpose:** Ensure code is understandable and debuggable long-term

**Sample Questions:**
- "How would someone debug this in 6 months?"
- "What would a future developer need to know?"
- "Where might this become a bottleneck?"
- "How would you modify this if requirements change?"
- "Where would you add comments to help understanding?"
- "What documentation should accompany this?"

**When to Use:**
- Complex business logic
- Performance-critical code
- Shared utilities/libraries
- Code that will be maintained by others

**What You're Testing:**
- Is the code self-documenting?
- Are complex parts explained?
- Would someone unfamiliar understand this in 6 months?

---

### 5. Testing Verification Questions

**Purpose:** Ensure code is tested and testable

**Sample Questions:**
- "What tests validate this works correctly?"
- "How do we know edge cases are covered?"
- "If this breaks in production, how will we detect it?"
- "What would a failing test look like?"
- "How do we prevent regressions?"
- "What scenarios are covered by tests?"
- "Are there untestable parts that need refactoring?"

**When to Use:**
- All PRs (testing is always relevant)
- Bug fixes (need regression tests)
- New features (need comprehensive coverage)
- Refactoring (need to prove equivalence)

**What You're Testing:**
- Does test coverage match complexity?
- Are edge cases tested, not just happy path?
- Can we verify this works without manual testing?

---

## How to Apply in Reviews

### Step 1: Read the Code

Before asking questions:
1. Understand what the code does
2. Identify complexity areas
3. Note potential edge cases
4. Check test coverage

### Step 2: Choose Question Categories

Based on the PR, select 2-3 relevant categories:

**Simple PR (< 50 lines, single file):**
- Understanding (1-2 questions)
- Testing (1 question)

**Medium PR (50-300 lines, multiple files):**
- Understanding (2-3 questions)
- Alternatives (1-2 questions)
- Testing (1-2 questions)

**Complex PR (300+ lines, architectural changes):**
- Understanding (3-4 questions)
- Alternatives (2-3 questions)
- Edge Cases (2-3 questions)
- Maintainability (1-2 questions)
- Testing (2-3 questions)

### Step 3: Ask Questions (Don't Demand Changes)

**Instead of:**
- "This is wrong, use pattern X" ❌
- "You should have done Y" ❌
- "This won't work" ❌

**Say:**
- "Why did you choose this approach? What alternatives did you consider?" ✅
- "How does this handle [edge case]? What tests cover that?" ✅
- "Can you walk me through this logic? I'm trying to understand the flow." ✅

### Step 4: Wait for Articulated Reasoning

Give the submitter time to:
- Think through their approach
- Identify gaps themselves
- Explain their reasoning

**Signs of Understanding:**
- Clear, articulate explanation
- Acknowledges trade-offs
- Identifies potential issues
- Explains decision criteria

**Signs of Gaps:**
- "AI suggested this" (without understanding why)
- "It works" (without explaining how)
- "I'm not sure" (about core logic)
- Deflects questions (defensive, not curious)

### Step 5: Approve When Understanding Is Demonstrated

**Approval Criteria:**
- Submitter can explain code clearly
- Edge cases are identified and tested
- Trade-offs are articulated
- Maintainability is considered

**If gaps remain:**
- Suggest resources for learning
- Pair on complex parts
- Request specific improvements

---

## Integration with Git Approval Workflow

Our existing git approval workflow (v2.9.0) requires human review. Enhance it with Socratic questions:

**Before (gatekeeping):**
```
1. Review changes
2. Approve or reject
```

**After (educational):**
```
1. Read code thoroughly
2. Choose 2-3 question categories (based on PR complexity)
3. Ask Socratic questions in PR comments
4. Wait for articulated reasoning
5. Follow up if gaps remain
6. Approve when understanding is demonstrated
```

---

## Benefits

**For Submitters:**
1. **Builds Real Understanding** - Forces articulation, not just approval-seeking
2. **Reduces Dependency** - Learn to self-assess, not rely on reviewers
3. **Psychological Safety** - Curiosity-driven questions, not judgment-driven rejection
4. **Skill Development** - Internalize problem-solving strategies

**For Reviewers:**
1. **Identifies Gaps Early** - Surface understanding issues before merge
2. **Educational Impact** - Transform review from gatekeeping to teaching
3. **Team Quality** - Prevents skill erosion across the team
4. **Scalable** - Doesn't require 1:1 senior:junior ratio (unlike trio programming)

**For Organizations:**
1. **Prevents False Productivity** - Shipping code without understanding
2. **Reduces Technical Debt** - Code is maintainable because submitters understand it
3. **Knowledge Transfer** - Reviews become learning opportunities
4. **Quality Culture** - Focus on understanding, not just correctness

---

## Examples

### Example 1: Understanding Questions

**Code:**
```typescript
async function processPayment(amount: number, userId: string) {
  const user = await db.users.findById(userId);
  const payment = await stripe.charges.create({ amount, customer: user.stripeId });
  await db.payments.create({ userId, amount, stripeChargeId: payment.id });
  return payment;
}
```

**Gatekeeping Review (❌):**
> "This is wrong. You're not handling errors. Fix it."

**Socratic Review (✅):**
> "Can you walk me through what happens if the Stripe API call fails? What would the user see? How would we know it happened?"

**Result:** Submitter realizes error handling is missing, adds try/catch with proper logging and user feedback.

---

### Example 2: Alternative Exploration

**Code:**
```javascript
// Using Lodash for array operations
import _ from 'lodash';

const activeUsers = _.filter(users, user => user.isActive);
const userNames = _.map(activeUsers, user => user.name);
```

**Gatekeeping Review (❌):**
> "Don't use Lodash for this. Use native array methods."

**Socratic Review (✅):**
> "What made you choose Lodash for this operation? Are there native alternatives? What are the trade-offs between Lodash and native methods here?"

**Result:** Submitter realizes native `.filter()` and `.map()` work equally well, removes unnecessary dependency.

---

### Example 3: Edge Case Discovery

**Code:**
```python
def calculate_average(numbers):
    return sum(numbers) / len(numbers)
```

**Gatekeeping Review (❌):**
> "This will crash on empty arrays. Fix it."

**Socratic Review (✅):**
> "What happens if `numbers` is an empty list? How should we handle that case? What would users expect?"

**Result:** Submitter identifies edge case, adds handling for empty lists (return 0, raise error, or return None - discussion about which is appropriate).

---

### Example 4: Maintainability Assessment

**Code:**
```javascript
const x = data.map(d => d.v).filter(v => v > 10).reduce((a, b) => a + b, 0);
```

**Gatekeeping Review (❌):**
> "This is unreadable. Rewrite it."

**Socratic Review (✅):**
> "If someone sees this code in 6 months, what would help them understand what it's calculating? Can you describe what this does in a sentence?"

**Result:** Submitter realizes the variable name and chaining make it unclear. Renames variable to `totalHighValues` and adds comment explaining business logic.

---

### Example 5: Testing Verification

**Code:**
```typescript
export function validateEmail(email: string): boolean {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}
```

**Gatekeeping Review (❌):**
> "Where are the tests?"

**Socratic Review (✅):**
> "What edge cases should we test for email validation? What inputs might break this regex? How do we ensure this works for international domains?"

**Result:** Submitter writes tests for: empty string, missing @, multiple @, unicode characters, plus-addressing, subdomain handling.

---

## Pedagogical Foundation

This approach is based on the **Socratic Method** (educational theory):

- **Questions > Lectures** - Active learning > passive acceptance
- **Self-discovery > Authority** - Intrinsic motivation > extrinsic approval
- **Critical thinking > Memorization** - Transferable skills > context-specific knowledge

**Research Evidence:**
- Students learn better from worked examples + questions vs direct instruction
- Socratic questioning develops metacognitive skills (thinking about thinking)
- Self-explanation improves retention and transfer to new problems

---

## When NOT to Use Socratic Review

**Time-Critical Hotfixes:**
- Production down, immediate fix needed
- Use gatekeeping for speed, follow up with Socratic review later

**Trivial Changes:**
- Typo fixes, comment updates, formatting
- Don't over-question obvious changes

**Security Vulnerabilities:**
- Critical security issues need immediate correction
- Fix first, educate later

**Experienced Developers on Familiar Code:**
- Senior developers in their area of expertise
- Trust their judgment, save Socratic review for new patterns

---

## Common Pitfalls

### Pitfall 1: Asking Too Many Questions
**Problem:** Overwhelming the submitter with 20 questions
**Solution:** Choose 2-3 categories, ask 3-5 targeted questions

### Pitfall 2: "Gotcha" Questions
**Problem:** Asking questions you already know the answer to, testing submitter
**Solution:** Ask genuinely curious questions, be willing to learn from submitter

### Pitfall 3: Impatience
**Problem:** Expecting immediate answers, moving to demands when questions aren't answered quickly
**Solution:** Give time to think, follow up if needed, be patient

### Pitfall 4: Mixing Gatekeeping and Socratic
**Problem:** "Why did you do this? This is wrong, change it."
**Solution:** Stick to questions first, let submitter identify issues themselves

---

## See Also

**Related Patterns:**
- **Pattern 7: The 70/30 Problem** - Understanding why edge cases (the hard 30%) need Socratic review
- **Pattern 4: Workflow Automation Comparison** - Sequential review as intentional quality gate

**Related Documentation:**
- `docs/01-fundamentals/ANTI_PATTERNS.md` - Common AI coding mistakes
- `docs/01-fundamentals/06_coding-principles-handbook.md` - Principles to reinforce through questions
- `docs/00-start-here/09_quick-reference.md` - Git approval workflow reference

**Related Skills:**
- quality-reviewer - Automated quality checks (complements human Socratic review)
- commit-readiness-checker - Pre-commit validation

---

## Footer

**Version:** 4.20.1
**Added:** 2025-12-19
**Part of:** External Perspectives - Pattern 8 (Socratic Review Framework)
**Sources:** Addy Osmani (Google) + NLW (Super ai consulting)
**Target Audience:** Code reviewers, team leads, senior developers

**Next Step:** Start using these questions in your next PR review. Pick 1-2 categories, ask 3-5 questions, watch understanding improve.
