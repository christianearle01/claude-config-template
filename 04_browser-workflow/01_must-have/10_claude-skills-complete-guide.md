# Claude Skills - Reusable AI Expertise

**For:** claude.ai users who want to create portable, reusable workflows

**Skill Level:** Beginner to Intermediate

**Token Efficiency:** Skills can reduce repetitive context by 60-80% (Projected)

---

## 🎯 What Are Claude Skills?

**Claude Skills are reusable instruction manuals that teach Claude how you want tasks done.**

Think of skills as expertise modules that work across all your conversations, projects, and contexts. They're like having a personal playbook that you can use anywhere.

### The Problem Before Skills

Before account-level skills existed, working with Claude meant:

- **Repeating yourself constantly:** Every new conversation required re-explaining your preferences, workflows, and standards
- **Inconsistent results:** Without clear instructions each time, output quality varied
- **Context limitations:** Custom Instructions helped but were stuck in claude.ai—you couldn't use them in Claude Code or via API
- **Token waste:** Spending hundreds or thousands of tokens just setting context before getting to actual work

**Example scenario:**
```
You: "Write a marketing email for our summer sale"
Claude: "What's your brand voice? Target audience? Format preferences?"
You: [Explains voice, audience, format, compliance requirements...]
Claude: [Drafts email]

Next week, different conversation:
You: "Write another marketing email for fall collection"
Claude: "What's your brand voice? Target audience?..."
You: [Explains the SAME things again...]
```

**Token cost:** ~3,000 tokens per conversation just for context setting

### How Skills Solve This

Skills package your workflows into reusable modules that:

✅ **Work everywhere:** claude.ai + Claude Code CLI + Claude API
✅ **Are portable:** Not stuck in one project or conversation
✅ **Are stackable:** Combine multiple skills in one task
✅ **Auto-trigger:** Activate based on context (no manual invocation needed)
✅ **Save tokens:** Reduce repetitive context by 60-80% (Projected)

**Same scenario with skills:**
```
You: "Write a marketing email for our summer sale"
[Marketing Email skill auto-activates]
Claude: [Drafts email in your brand voice, correct format, includes required disclaimers]

Next week:
You: "Write another marketing email for fall collection"
[Skill activates automatically again]
Claude: [Perfect email, consistent with previous, zero setup needed]
```

**Token cost:** ~1,200 tokens (60% savings)

### Real-World Analogy

Imagine you're running a restaurant kitchen:

- **Custom Instructions** = Your head chef's expertise (always present, applies to everything)
- **Projects** = Specific menus you're working on (seasonal menu, catering menu)
- **Skills** = Recipe cards (specific procedures for making dishes)
- **MCP Tools** = Kitchen equipment (ovens, mixers, databases)

Skills are your recipe cards—precise instructions for repeated tasks that work no matter which menu (project) you're cooking.

---

## 📊 Skills vs Custom Instructions vs Local Skills

Understanding the three types of context systems helps you choose the right tool for each situation.

| Feature | Account Skills | Custom Instructions | Local Claude Code Skills |
|---------|----------------|---------------------|-------------------------|
| **Availability** | claude.ai + Code + API | claude.ai only | Claude Code CLI only |
| **Scope** | Per-task workflows | Global role context | Project-specific expertise |
| **Portability** | Works across all projects | Works across all chats | Single codebase only |
| **Stackability** | Can combine multiple | Only one set | Unlimited in project |
| **Auto-trigger** | Context-based | Always active | Context-based |
| **Character Limit** | Varies by skill | ~2,000 chars/section | No practical limit |
| **Best For** | Repeated workflows | Professional role | Project knowledge |
| **Setup Location** | Settings → Capabilities | Settings → Custom Instructions | `.claude/skills/` directory |

### When to Use Each

**Use Account Skills when:**
- You repeat the same workflow across multiple projects
- The process has 5+ specific steps or rules
- You need consistency in format or quality
- The workflow applies to various contexts (not project-specific)

**Examples:**
- Email template formatting (works for any email campaign)
- SEO blog post structure (works for any blog topic)
- Financial report format (works for any quarter)

---

**Use Custom Instructions when:**
- Defining who you are professionally
- Setting general response preferences
- Specifying tools and technologies you use
- Establishing overall communication style

**Examples:**
- "I'm a Python developer who values clean code"
- "Keep responses concise and code-first"
- "Always explain WHY, not just WHAT"

---

**Use Local Claude Code Skills when:**
- The knowledge is specific to ONE codebase
- It's about your project's architecture or conventions
- Team-specific processes or standards
- You need unlimited content length

**Examples:**
- Your app's authentication flow
- Database schema and relationships
- Team's git workflow
- API endpoint documentation

**Learn more:** [Local Claude Code Skills Guide](../../docs/01-fundamentals/02_skills-paradigm.md)

---

### The Best Combination

**Layer your context strategically:**

1. **Custom Instructions** → Who you are (role, preferences, expertise)
2. **Account Skills** → How you work (repeated workflows, formats)
3. **Projects** → What you're working on (specific context, docs)
4. **Local Skills** → Project expertise (architecture, conventions)

**Example for a Marketing Manager:**

```
Custom Instructions: "I'm a marketing manager at a B2B SaaS company..."
Account Skills: Email template + SEO blog format + social media voice
Project: Q4 product launch campaign docs
Result: Claude knows WHO you are, HOW you work, and WHAT you're doing
```

---

## 🔧 Two Types of Skills

### Official and Partner Skills

**Created by Anthropic and partner organizations**, these skills are pre-built, tested, and ready to use immediately.

**How to access:**
1. Go to claude.ai
2. Click Settings (bottom left)
3. Select "Capabilities"
4. Browse available official skills
5. Enable the ones you need

**Examples of official skills:**
- **skill-creator** - Helps you create your own custom skills
- **Notion** - Integrates with Notion workspace
- More skills being added regularly by Anthropic and partners

**Benefits:**
- ✅ Pre-tested and reliable
- ✅ Professional quality
- ✅ Maintained by creators
- ✅ Zero setup effort

**Best for:** Common workflows that many users need

---

### Custom Skills (Your Own)

**Created by you for your specific workflows**, custom skills are personalized to exactly how you work.

**How to create:**
1. Enable the "skill-creator" official skill (see above)
2. Describe your workflow to skill-creator
3. Review and refine the generated skill
4. Enable and start using it

**Benefits:**
- ✅ Perfectly matched to your needs
- ✅ As simple or complex as required
- ✅ You control the details
- ✅ Can update anytime

**Best for:** Your unique workflows that official skills don't cover

---

## ✅ When to Create a Custom Skill

Not every workflow needs a skill. Use these criteria to decide.

### Decision Framework

**Create a skill if your workflow meets 2 or more of these tests:**

#### ✅ Repetition Test
**Question:** Do you repeat the same instructions 3+ times across different chats?

**Example that passes:**
- "Always format blog posts with H2 headers, 300-word intro, bullet points for key takeaways, and meta description under 160 characters"
- You write 5+ blog posts per month

**Example that fails:**
- One-time website redesign
- Annual report (once per year)

---

#### ✅ Complexity Test
**Question:** Is the process complex enough that you'd need to train a real human?

**Example that passes:**
- Brand voice guidelines with 5+ specific rules (tone, vocabulary, structure, compliance requirements, audience considerations)
- Multiple steps with decision points

**Example that fails:**
- "Be professional and concise" (too general)
- Single-step tasks

---

#### ✅ Consistency Test
**Question:** Is quality or format consistency critical every time?

**Example that passes:**
- Financial reporting with compliance requirements
- Customer support responses (brand voice + policy adherence)
- Legal document formatting

**Example that fails:**
- Brainstorming sessions (variety is good)
- Exploratory research (format can vary)

---

### When NOT to Create a Skill

❌ **One-off tasks**
- Example: "Help me write my wedding speech"
- Why not: You'll never need this workflow again

❌ **Simple requests that vary each time**
- Example: "Summarize this article"
- Why not: Too general, better handled by prompts

❌ **Already covered by Custom Instructions**
- Example: "I prefer concise responses"
- Why not: Belongs in Custom Instructions, not a skill

❌ **Too broad or vague**
- Example: "Help me with everything"
- Why not: Skills should be focused on specific workflows

---

### Quick Self-Assessment

Ask yourself:
1. Will I do this exact workflow 3+ more times? **[YES/NO]**
2. Does this have 5+ specific rules or steps? **[YES/NO]**
3. Must the output format/quality be consistent? **[YES/NO]**

**If 2+ YES:** Create a skill ✅
**If 0-1 YES:** Use prompts instead ⚠️

---

## 📝 How to Create a Custom Skill

Follow this step-by-step process to create your first skill.

### Step 1: Enable skill-creator

1. Go to claude.ai
2. Click **Settings** (bottom left)
3. Select **Capabilities**
4. Find "skill-creator" in the official skills list
5. Toggle it **ON**

**You only do this once.** After enabling, skill-creator is available in all conversations.

---

### Step 2: Describe Your Workflow

Start a new conversation and describe the skill you want to create. Use this template:

```
I need a skill for [task type].

This skill should:
- [Guideline 1]
- [Guideline 2]
- [Output format]
- [Standards to follow]
- [Edge cases to handle]

I use this workflow for: [use cases]

Trigger this skill when: [context clues that indicate this skill is needed]

Example input: [sample request]
Example output: [what the result should look like]
```

**Tips for better skills:**
- Be specific about format requirements
- Include examples of good output
- Mention what to avoid
- Describe when it should activate
- List any tools/data it needs access to

---

### Step 3: Review and Refine

skill-creator will generate a skill definition for you. Review it carefully:

**Check:**
- ✅ Does it capture all your guidelines?
- ✅ Are the trigger conditions clear?
- ✅ Are examples helpful?
- ✅ Is anything missing or incorrect?

**Refine if needed:**
```
"The skill looks good, but can you add:
- Include a call-to-action at the end
- Keep paragraphs under 3 sentences
- Use active voice only"
```

skill-creator will update the skill based on your feedback.

---

### Step 4: Enable and Test

Once you're happy with the skill:

1. skill-creator will save it to your account
2. The skill is now available across claude.ai, Claude Code, and API
3. It will auto-trigger based on the context you defined

**Test it:**
- Start a new conversation
- Make a request that should trigger the skill
- Verify the output matches your expectations
- Refine if needed by talking to skill-creator again

---

### Real Example Walkthrough

Let's create an "SEO Blog Post" skill together.

**Step 1: Already enabled skill-creator ✓**

**Step 2: Describe the workflow**
```
I need a skill for writing SEO-optimized blog posts.

This skill should:
- Start with H1 title (60-70 characters)
- Include 300-word introduction with primary keyword
- Use H2 headers every 300-400 words
- Include bullet lists for key points
- Add internal linking suggestions
- End with meta description (150-160 characters)
- Maintain keyword density of 1-2%
- Use active voice and clear language

I use this workflow for: Company blog, client websites, content marketing

Trigger this skill when: User asks to write a blog post, article, or content piece with SEO focus

Example input: "Write a blog post about remote work productivity"
Example output: [Complete blog post with H1, intro with keyword, H2 sections, bullets, meta description]
```

**Step 3: Review**
skill-creator generates the skill. You review and add:
```
"Great! Can you also include:
- Target reading level of 8th grade
- Add a FAQ section at the end
- Suggest 3-5 related topics for internal links"
```

**Step 4: Enable and test**
```
You: "Write a blog post about AI for small businesses"
[SEO Blog Post skill activates automatically]
Claude: [Generates perfectly formatted blog post with all requirements]
```

**Result:** You now have a reusable skill that works every time you need an SEO blog post!

---

## ⚡ How Skills Trigger and Work

### Auto-Triggering

Skills activate **automatically** based on conversation context. You don't need to explicitly call them.

**How Claude decides:**
1. Analyzes your request
2. Checks which skills are enabled
3. Matches request context to skill trigger conditions
4. Activates relevant skills
5. Applies skill instructions to the task

**Example:**
```
You: "Draft an email to customers about the sale"
Claude: [Sees "email" → checks for email-related skills]
        [Finds "Marketing Email" skill]
        [Activates skill automatically]
        [Drafts email following skill guidelines]
```

**You don't see:** "Activating Marketing Email skill..."
**You only see:** The perfectly formatted email

---

### Manual Hints (Optional)

While skills auto-trigger, you can help Claude remember to use them by adding a hint to your Custom Instructions.

**Recommended addition to Custom Instructions (Section 2):**
```
Always consider relevant skills when responding to my requests.
```

This gentle reminder ensures Claude checks for applicable skills, especially in complex conversations where context might be ambiguous.

---

### Combining Multiple Skills (Stackability)

One of the most powerful features: **you can use multiple skills together**.

**Example: Content Creation Workflow**

**Skills enabled:**
1. SEO Keyword Research skill
2. Blog Writer skill
3. Meta Description Generator skill

**Your request:**
```
"Write a blog post about sustainable fashion"
```

**What happens:**
1. **SEO Keyword Research skill** → Identifies target keywords
2. **Blog Writer skill** → Creates post structure using keywords
3. **Meta Description Generator skill** → Writes description from content

**Result:** Complete SEO-optimized content in one conversation, with all skills contributing their expertise.

---

### How Skills Work with Other Claude Features

Skills integrate seamlessly with other Claude capabilities:

**Skills + Custom Instructions:**
- Custom Instructions set your role and preferences
- Skills add specific workflow procedures
- They work together without conflict

**Skills + Projects:**
- Projects provide specific context and documents
- Skills provide workflow structure
- Combined: Context-aware, structured output

**Skills + MCP Tools:**
- Skills can reference MCP tools in their instructions
- Example: Email skill that says "access customer database for personalization"
- Tools provide capabilities, skills provide workflow

---

## 🏗️ Skills in Your Claude Ecosystem

### The Four Building Blocks

Think of your Claude setup as having four layers:

**1. Claude (The Brain)**
- Core intelligence that powers everything
- Makes decisions and generates responses
- Interprets your requests

**2. Skills (The Instruction Manuals)**
- How-to guides for specific tasks
- Workflow procedures and standards
- Formatting and quality rules

**3. MCP - Model Capability Protocol (The Tools)**
- Access to external capabilities
- Database connections
- File system operations
- API calls

**4. Projects (The Workspace)**
- Specific context for what you're working on
- Relevant documents and resources
- Temporary focused environment

---

### How They Work Together

Here's a real-world example of all four layers working together:

**Scenario: Marketing Campaign Email**

**Your Custom Instructions:**
```
I'm a marketing manager at a B2B SaaS company.
I value data-driven decisions and clear ROI messaging.
```

**Your Project:** "Q4 Product Launch Campaign"
- Contains: Product specs, target audience research, campaign timeline

**Your Skills:**
- Marketing Email Template skill (format, structure, compliance)
- Brand Voice skill (tone, vocabulary, style)

**Your MCP Tools:**
- Customer database access
- Email performance analytics

**Your Request:**
```
"Draft an announcement email for the new AI feature to our enterprise customers"
```

**What Happens:**

1. **Claude** understands you need an email (brain)
2. **Skills activate:** Marketing Email + Brand Voice (instruction manuals)
3. **Project provides context:** Feature details, audience info (workspace)
4. **MCP can access:** Customer segments, past email performance (tools)
5. **Custom Instructions ensure:** B2B tone, ROI focus (your role)

**Result:**
```
Subject: [AI-Powered] Cut Analysis Time by 60% with SmartInsights

[Email body with:]
- Executive-focused value proposition
- ROI data points
- Brand voice maintained
- Proper formatting (unsubscribe, compliance)
- Personalized for enterprise segment
```

All from a single request, zero manual context setting.

---

### Visual Flow Diagram

```
You (Custom Instructions: Who you are)
  ↓
Request: "Draft an email..."
  ↓
Claude (Brain: Interprets request)
  ↓
Skills (Instruction Manuals: How to format emails)
  ↓
Project (Workspace: Campaign context & docs)
  ↓
MCP Tools (Capabilities: Database access)
  ↓
Output: Perfectly formatted, on-brand email
```

Each layer adds value without requiring manual coordination.

---

## 🎯 Best Practices

### DO: ✅

**✅ Start with official skills before creating custom ones**
- Browse what's already available
- Official skills are professionally maintained
- Save time and effort
- Learn from well-designed examples

**✅ Keep skills focused (one workflow, not everything)**
- Good: "SEO Blog Post Format" skill
- Bad: "All Writing Tasks" skill
- Focused skills are more reliable and easier to maintain

**✅ Include clear trigger conditions**
- Specify when the skill should activate
- Use concrete context clues
- Example: "When user requests blog post OR article OR content piece"

**✅ Provide examples in your skill definition**
- Show skill-creator what good output looks like
- Include both input and output examples
- Helps ensure consistency

**✅ Test skills before relying on them**
- Create test conversations
- Try edge cases
- Verify output quality
- Refine as needed

**✅ Update skills as your workflow evolves**
- Skills aren't set-it-and-forget-it
- As your process improves, update the skill
- Use skill-creator to modify existing skills

---

### DON'T: ❌

**❌ Create skills for one-off tasks**
- Skills are for repeated workflows
- One-time tasks don't justify skill creation
- Use regular prompts instead

**❌ Make skills too broad ("help me with everything")**
- Vague skills produce inconsistent results
- Better to have 3 focused skills than 1 vague skill
- Specificity = reliability

**❌ Duplicate what's already in Custom Instructions**
- Custom Instructions: General preferences
- Skills: Specific workflows
- Don't repeat yourself across both

**❌ Forget to test with edge cases**
- Test unusual inputs
- Verify error handling
- Check boundary conditions
- Ensure graceful degradation

**❌ Rely on skills for sensitive/confidential processes**
- Skills are account-level (not encrypted)
- Don't include proprietary information
- Keep sensitive data in project-specific context
- Use skills for process, not secrets

---

### Maintenance Tips

**Quarterly Review:**
- Every 3 months, review your active skills
- Ask: Am I still using this?
- Update or disable unused skills

**Documentation:**
- Keep notes on what each skill does
- Document trigger conditions
- Note any dependencies or requirements

**Version Control:**
- When updating a skill, test thoroughly first
- Consider keeping notes on major changes
- If a change breaks things, recreate from notes

**Team Coordination:**
- If working with a team, document shared workflows
- Consider how your skills align with team standards
- Currently, skills are account-specific (sharing coming later)

---

## 💼 Common Use Cases

### Use Case 1: Content Creation Workflow

**Scenario:** You're a content marketer creating 10+ blog posts per month.

**Skills created:**
1. **SEO Keyword Research** - Identifies target keywords and search intent
2. **Blog Post Writer** - Structures content with H1/H2, intro, body, conclusion
3. **Meta Description Generator** - Creates 150-160 char descriptions optimized for CTR

**How they stack:**
```
Your request: "Write a blog post about email marketing automation"

Step 1: SEO Keyword Research skill activates
→ Identifies: "email marketing automation", "automated email campaigns",
   "email workflow automation" (search volume, competition)

Step 2: Blog Post Writer skill activates
→ Uses keywords to structure 2,000-word post
→ H1: "Email Marketing Automation: Complete Guide for 2025"
→ 5 H2 sections covering benefits, setup, best practices
→ Includes keyword naturally (1.5% density)

Step 3: Meta Description Generator skill activates
→ "Learn email marketing automation from setup to advanced workflows.
   Boost engagement by 40% with these proven strategies. Read now."
   [158 characters]

Result: Complete, SEO-optimized blog post ready to publish
```

**Token savings:** ~60% vs explaining SEO requirements each time
**Time savings:** 5 min → 30 sec context setting (90% faster, Projected)

---

### Use Case 2: Project Management Documentation

**Scenario:** You're a product manager writing user stories and acceptance criteria weekly.

**Skills created:**
1. **User Story Formatter** - Structures stories: "As a [user], I want [goal] so that [benefit]"
2. **Acceptance Criteria Writer** - Creates Given/When/Then scenarios
3. **Sprint Planner** - Estimates story points and dependencies

**How they stack:**
```
Your request: "Create user stories for the new notification system"

Step 1: User Story Formatter skill activates
→ "As a mobile app user, I want to receive push notifications
   so that I stay informed of important updates"

Step 2: Acceptance Criteria Writer skill activates
→ Given I've enabled notifications
→ When a relevant event occurs
→ Then I receive a push notification within 30 seconds
→ And the notification displays the correct title and message
→ And tapping opens the relevant screen

Step 3: Sprint Planner skill activates
→ Story points: 5 (medium complexity)
→ Dependencies: User preferences API, Push notification service
→ Sprint placement: Sprint 12 (after dependencies)

Result: Complete feature documentation ready for development
```

**Consistency improvement:** 70% → 95% format adherence (Projected)

---

### Use Case 3: Data Analysis Reporting

**Scenario:** You're a data scientist producing weekly analysis reports for stakeholders.

**Skills created:**
1. **Data Cleaning Process** - Standard procedures for handling missing data, outliers
2. **Visualization Preferences** - Chart types, colors, labels for different data types
3. **Executive Report Format** - Structure: Summary, findings, recommendations, appendix

**How they stack:**
```
Your request: "Analyze this sales data and create an executive report"

Step 1: Data Cleaning Process skill activates
→ Identifies missing values (3% of records)
→ Applies standard imputation method
→ Flags outliers beyond 3 standard deviations
→ Documents cleaning steps

Step 2: Visualization Preferences skill activates
→ Creates bar chart for category comparison
→ Line chart for time trends
→ Uses company color palette
→ Adds clear axis labels and titles

Step 3: Executive Report Format skill activates
→ Executive Summary (3 bullet points, <100 words)
→ Key Findings (5 insights with supporting data)
→ Recommendations (3 actionable items)
→ Appendix (methodology, full dataset stats)

Result: Consistent, professional report format every week
```

**Completeness improvement:** 80% → 95% (fewer missing elements, Projected)

---

### Use Case 4: Customer Support Responses

**Scenario:** You're a support team lead handling 30+ customer inquiries daily.

**Skills created:**
1. **Brand Voice** - Tone, vocabulary, empathy level for customer communications
2. **FAQ Knowledge** - Standard answers to common questions
3. **Escalation Process** - Criteria for when to escalate to specialist

**How they stack:**
```
Your request: "Draft response to customer asking about refund policy"

Step 1: Brand Voice skill activates
→ Uses empathetic, helpful tone
→ Avoids jargon
→ Includes customer name
→ Signs off with team signature

Step 2: FAQ Knowledge skill activates
→ Recognizes "refund policy" question
→ Provides standard 30-day return policy
→ Mentions exceptions (custom orders, final sale)
→ Includes link to full policy page

Step 3: Escalation Process skill activates
→ Checks: Does this require finance team? No
→ Checks: Does this require manager approval? No
→ Conclusion: You can respond directly

Result: On-brand, accurate, complete response in seconds
```

**Quality consistency:** 70% → 95% brand voice adherence (Projected)
**Response time:** 5 min → 1 min per inquiry (80% faster, Projected)

---

## 📈 Efficiency Metrics (Projected)

**Important note:** These are theoretical projections based on the YouTube source material analyzing Claude Skills capabilities. Account-level skills are a relatively NEW feature with limited real-world data from diverse users. **Help us validate these estimates with your actual usage!**

### Token Savings (Projected)

| Scenario | Without Skills | With Skills | Savings |
|----------|---------------|-------------|---------|
| Email drafting (repeated format) | ~3,000 tokens | ~1,200 tokens | 60% |
| Content creation workflow | ~5,000 tokens | ~2,000 tokens | 60% |
| Combining 3+ processes | ~8,000 tokens | ~2,500 tokens | 69% |
| Complex multi-step task | ~10,000 tokens | ~3,000 tokens | 70% |

**How savings happen:**
- Eliminate repetitive context setting
- Skip explaining format requirements
- Reduce back-and-forth clarifications
- Automatic workflow application

---

### Time Savings (Projected)

| Activity | Without Skills | With Skills | Improvement |
|----------|---------------|-------------|-------------|
| Context setting per conversation | 5 min | 30 sec | 90% faster |
| Workflow consistency checking | Manual review | Automatic | 100% reduction |
| Multi-step processes | 3-5 exchanges | 1-2 exchanges | 60% faster |
| Getting to first useful output | 10 min | 3 min | 70% faster |

**How time savings happen:**
- Zero manual context setting
- Immediate application of standards
- Fewer revision cycles
- Consistent first-time output

---

### Quality Improvements (Projected)

| Metric | Without Skills | With Skills | Improvement |
|--------|---------------|-------------|-------------|
| Format adherence | 70% consistent | 95% consistent | +36% |
| Completeness (all steps included) | 80% | 95% | +19% |
| Revision cycles needed | 2-3 iterations | 1 iteration | 66% reduction |
| User satisfaction | 7/10 | 9/10 | +29% |

**How quality improves:**
- Systematic application of best practices
- No forgotten steps
- Consistent formatting
- Learned from your specifications

---

### Cost Analysis Example (Projected)

**Scenario:** Content marketer creating 20 blog posts per month

**Without Skills:**
- 20 posts × 5,000 tokens per post = 100,000 tokens/month
- At Claude pricing: ~$15/month (input tokens)

**With Skills:**
- 20 posts × 2,000 tokens per post = 40,000 tokens/month
- At Claude pricing: ~$6/month (input tokens)

**Savings:** $9/month, $108/year per user (60% reduction)

**For a team of 10:** $1,080/year savings (Projected)

---

### Reality Check

These projections are based on:
- ✅ Anthropic's token counting methodology (factual)
- ✅ Typical workflow patterns observed in video source (representative)
- ⚠️ Assumption: Skills work as designed in all contexts (needs validation)
- ⚠️ Assumption: Users create well-defined skills (skill quality varies)
- ⚠️ Limited real-world data from diverse users (NEW feature)

**Your actual results may vary based on:**
- Skill quality and specificity
- Workflow complexity
- How often you use each skill
- Task variety in your work

**We need your help:** Share your real experiences to validate or adjust these projections!

---

## ❓ FAQ

**Q: How many skills can I have?**

A: There's no official hard limit from Anthropic, but practically you should keep it manageable. **Recommendation: 5-10 active skills.** More than that becomes hard to track and may cause trigger conflicts. Focus on your most repeated workflows.

---

**Q: Can I share skills with my team?**

A: Currently, skills are **account-specific**—each user creates and manages their own. Team sharing is not available as of late 2024. Workaround: Document your skills and have teammates recreate them using skill-creator with the same specifications.

---

**Q: Do skills work in Claude Code?**

A: **Yes!** Account-level skills work across:
- claude.ai web interface ✅
- Claude Code CLI ✅
- Claude API ✅

This is different from *local* Claude Code skills (`.claude/skills/` directory) which only work in CLI.

---

**Q: How do I know which skills are active?**

A: Go to **Settings → Capabilities** in claude.ai. You'll see a list of all skills with toggles showing which are enabled. Enabled skills have the toggle in the "on" position.

---

**Q: Can I edit a skill after creating it?**

A: **Yes.** Start a conversation with skill-creator and say:
```
"I need to update my [skill name] skill. Please modify it to also include [new requirement]."
```

skill-creator will update the skill. Alternatively, you can recreate it from scratch if major changes are needed.

---

**Q: What if skills conflict with Custom Instructions?**

A: Skills are **more specific** and generally take precedence for their defined workflow. Custom Instructions provide general context while skills provide task-specific procedures. They're designed to work together, not conflict. If you notice issues, make your skill trigger conditions more specific.

---

**Q: How do I disable a skill I'm not using?**

A: Go to **Settings → Capabilities**, find the skill in the list, and toggle it off. The skill remains saved (you can re-enable later) but won't activate in conversations.

---

**Q: Can skills call external tools or MCP servers?**

A: **Yes.** When creating a skill, you can specify that it should use available MCP tools. Example: "This skill should access the customer database via the CRM MCP to personalize emails." As long as the MCP is set up in your environment, the skill can reference it.

---

**Q: Are skills saved in my conversation history?**

A: Skills operate **behind the scenes**. You see the results of skills in your conversations (the formatted output), but skill definitions themselves aren't visible in conversation history. They're stored at the account level, not conversation level.

---

**Q: What happens if I delete a skill?**

A: The skill is permanently removed from your account and stops activating in future conversations. Past conversations that used the skill are unchanged (they keep the output that was generated). You can recreate the skill later if needed.

---

**Q: Can I export my skills to back them up?**

A: Currently, there's no built-in export feature. **Best practice:** Keep documentation of your skills (what they do, trigger conditions, key guidelines) in a separate notes file. If you need to recreate them, you'll have the specifications.

---

**Q: Do skills cost extra?**

A: Account-level skills are included in your Claude subscription/usage. You pay for tokens used in conversations (as always), but skills themselves don't have a separate fee. The token *savings* from skills mean you'll likely spend less overall.

---

**Q: How do I get help creating complex skills?**

A: Use the **skill-creator** skill! It's specifically designed to help you design and refine skills. Describe what you want in detail, and skill-creator will guide you through the process. You can also refer to this guide and iterate on your skill definition with skill-creator until it's right.

---

## 🚀 Next Steps

Ready to start using Claude Skills? Follow this roadmap:

### Step 1: Browse Official Skills

**Action:** Explore what's already available

1. Go to claude.ai
2. Click **Settings** → **Capabilities**
3. Browse the list of official and partner skills
4. Enable **1-2 skills** that match your workflow
5. Start a new conversation and test them

**Goal:** Get comfortable with how skills work before creating your own.

**Time:** 10 minutes

---

### Step 2: Identify a Workflow to Automate

**Action:** Find your first custom skill opportunity

Ask yourself:
- What task do I do 3+ times per week?
- What workflow has specific rules I keep explaining?
- What output format do I need consistently?

**Example candidates:**
- Weekly report structure
- Email templates you use repeatedly
- Content formatting you always request
- Data analysis procedures

**Write down:**
- The task name
- How often you do it
- The specific steps/rules
- What consistency means for this task

**Time:** 15 minutes

---

### Step 3: Create Your First Custom Skill

**Action:** Use skill-creator to build your skill

1. Enable **skill-creator** (Settings → Capabilities)
2. Start a new conversation
3. Use this template:

```
I need a skill for [your task from Step 2].

This skill should:
- [Rule/guideline 1]
- [Rule/guideline 2]
- [Format requirement]
- [Quality standard]

I use this for: [frequency and context]
Trigger when: [what keywords or context indicate this skill is needed]

Example input: [sample request]
Example output: [what the result should look like]
```

4. Review the skill skill-creator generates
5. Refine until it's exactly right
6. Test it in a new conversation

**Time:** 20-30 minutes

---

### Step 4: Combine with Custom Instructions

**Action:** Optimize your account-level context

Add this to your Custom Instructions (Section 2):

```
Always consider relevant skills when responding to my requests.
```

This ensures Claude checks for applicable skills in every conversation.

**Bonus:** Review your Custom Instructions and make sure they complement (not duplicate) your skills:
- Custom Instructions: Who you are, general preferences
- Skills: Specific workflows and procedures

**Time:** 5 minutes

---

### Step 5: Explore Advanced Use Cases

**Action:** Level up your skills usage

Once you're comfortable:

**Stack multiple skills:**
- Create 2-3 complementary skills
- Use them together in one task
- Example: Research + Writing + Formatting

**Integrate with Projects:**
- Enable skills in a Project context
- See how skills + project docs work together
- Create project-specific workflows

**Combine with MCP:**
- If you use MCP servers, reference them in skills
- Example: Email skill that accesses customer database

**Time:** Ongoing experimentation

---

## 📚 Resources

### Official Documentation
- **Anthropic Claude Skills:** [docs.anthropic.com](https://docs.anthropic.com) (Settings → Capabilities section)
- **skill-creator:** Official skill for creating custom skills
- **Claude API Skills:** Skills work via API too (see API documentation)

### Related Guides in This Template
- **[Custom Instructions Guide](../README.md)** - How to set up your claude.ai profile
- **[Local Claude Code Skills](../../docs/01-fundamentals/02_skills-paradigm.md)** - Project-specific skills for Claude Code CLI
- **[All Roles Library](00_all-available-roles-complete-library.md)** - Role-based Custom Instructions templates
- **[Quick Reference](../../docs/00-start-here/09_quick-reference.md)** - Searchable feature reference

### YouTube Source
This guide is based on insights from:
**"The REAL POWER of Claude Agent SKILLS (Why Most Are Missing It)"**
- Explains portability and stackability concepts
- Covers when to create skills vs use Custom Instructions
- Demonstrates skill-creator workflow

### Community
- Share your experiences: Help validate the projected metrics in this guide
- Contribute examples: If you create useful skills, document them
- Ask questions: Use claude.ai to ask about skills anytime

---

## Navigation

**🏠 [Browser Workflow Home](../README.md)** | **📚 [All Roles Library](00_all-available-roles-complete-library.md)** | **📖 [Quick Reference](../../docs/00-start-here/09_quick-reference.md)**

---

*Part of the Claude Code Configuration Template - v3.7.0*
*Claude Skills Guide for claude.ai Users | Last updated: 2025-12-15*
