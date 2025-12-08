# Create Your Own Custom Role - Claude.ai Workflow

**For:** Users whose professional role isn't in our priority list

**You'll create:** Custom Instructions optimized for YOUR specific role and workflow

---

## 🎯 Who Is This For?

If your role isn't covered yet, this guide helps you create optimized Custom Instructions for:
- Product Managers
- Data Scientists
- DevOps Engineers
- Technical Writers
- Frontend Developers
- Security Engineers
- Marketing Professionals
- Business Analysts
- Project Managers
- Content Creators
- **...or ANY professional role!**

---

## 📋 Custom Instructions Template Generator

Copy and customize this template for YOUR role:

### Section 1: What would you like Claude to know about you?

```
I'm a [YOUR ROLE] who uses Claude for:
- [Primary task 1]
- [Primary task 2]
- [Primary task 3]
- [Primary task 4]
- [Primary task 5]

My work context:
- Primary tools/software: [e.g., specific apps, platforms, languages]
- Focus areas: [e.g., domains, specializations]
- Key responsibilities: [e.g., what you're accountable for]

I value:
- [Core principle 1 - e.g., accuracy, speed, creativity]
- [Core principle 2 - e.g., clarity, thoroughness, innovation]
- [Core principle 3 - e.g., collaboration, independence, efficiency]
- [Core principle 4 - e.g., quality, pragmatism, best practices]
```

**Character limit:** Keep under 1500 characters

---

### Section 2: How would you like Claude to respond?

```
When helping with [YOUR MAIN TASK TYPE]:
- [Instruction 1 - e.g., "Always provide data to back up claims"]
- [Instruction 2 - e.g., "Focus on practical, actionable advice"]
- [Instruction 3 - e.g., "Consider business impact first"]
- [Instruction 4 - e.g., "Use industry-standard terminology"]
- [Instruction 5 - e.g., "Explain trade-offs of different options"]

When [SECONDARY TASK TYPE]:
- [Instruction 1]
- [Instruction 2]
- [Instruction 3]

Keep responses:
- [Style preference 1 - e.g., "Concise and scannable"]
- [Style preference 2 - e.g., "Data-driven with examples"]
- [Style preference 3 - e.g., "Action-oriented"]
```

**Character limit:** Keep under 1500 characters

---

## 💡 Examples by Role Type

### Example 1: Product Manager

**Section 1:**
```
I'm a product manager who uses Claude for:
- Writing user stories and requirements
- Analyzing product metrics and feedback
- Creating roadmaps and prioritization
- Stakeholder communication
- Competitive analysis

My work context:
- Primary tools: JIRA, Confluence, Mixpanel, Figma
- Focus areas: SaaS B2B products, user onboarding
- Key responsibilities: Product strategy, feature prioritization

I value:
- User-centric thinking
- Data-driven decisions
- Clear, persuasive communication
- Balancing business goals with user needs
```

**Section 2:**
```
When helping with product decisions:
- Always consider user impact and business value
- Provide frameworks for prioritization
- Include metrics to measure success
- Think about edge cases and different user segments
- Suggest A/B testing approaches

When writing documentation:
- Use clear, non-technical language
- Focus on the "why" not just the "what"
- Include acceptance criteria

Keep responses: Action-oriented, data-driven, stakeholder-ready
```

---

### Example 2: Data Scientist

**Section 1:**
```
I'm a data scientist who uses Claude for:
- Data analysis and visualization
- ML model development and debugging
- Statistical analysis and hypothesis testing
- Interpreting results and insights
- Code review for data pipelines

My work context:
- Primary languages: Python (pandas, scikit-learn, PyTorch)
- Tools: Jupyter, SQL, Tableau, Git
- Focus areas: Predictive modeling, NLP, time series

I value:
- Statistical rigor and reproducibility
- Clean, well-documented code
- Explainable models
- Performance and efficiency
```

**Section 2:**
```
When helping with data analysis:
- Suggest statistical tests and why they're appropriate
- Consider data quality and potential biases
- Explain assumptions clearly
- Provide code with comments

When developing models:
- Focus on interpretability alongside performance
- Suggest evaluation metrics
- Consider overfitting risks

Keep responses: Technically rigorous, reproducible, well-documented
```

---

### Example 3: DevOps Engineer

**Section 1:**
```
I'm a DevOps engineer who uses Claude for:
- Writing Infrastructure as Code
- Debugging CI/CD pipelines
- Creating automation scripts
- Security and compliance reviews
- Monitoring and alerting setup

My work context:
- Primary tools: Terraform, Kubernetes, Docker, Jenkins
- Cloud platforms: AWS, Google Cloud
- Languages: Python, Bash, YAML

I value:
- Reliability and uptime
- Security best practices
- Automation over manual processes
- Infrastructure as code principles
```

**Section 2:**
```
When helping with infrastructure:
- Follow cloud best practices
- Consider cost optimization
- Prioritize security (least privilege, encryption)
- Make code idempotent and reusable

When debugging:
- Check logs systematically
- Consider dependencies and networking
- Think about scalability

Keep responses: Production-ready, security-focused, scalable
```

---

## 🎓 Best Practices for Custom Instructions

### 1. Be Specific
- ❌ "I'm a developer"
- ✅ "I'm a Python backend developer specializing in APIs"

### 2. Focus on What Matters
- Include tools you use daily
- Skip tools you rarely touch
- Mention your expertise level if relevant

### 3. Define Your Output Preferences
- How detailed should responses be?
- Code-first or explanation-first?
- What style/tone works for you?

### 4. Iterate and Refine
- Start with the template
- Use Claude for a week
- Adjust based on what works/doesn't work
- Update your Custom Instructions

---

## 🔍 Token Optimization Tips

### 1. Front-load Common Context
Put your most-used tools and preferences in Custom Instructions:
```
Primary language: Python
Framework: Django
Database: PostgreSQL
```

This saves repeating it in every prompt.

### 2. Use Projects for Specifics
- Custom Instructions = Your role (global)
- Projects = Specific work items (scoped)

### 3. Create Prompt Patterns
Once you have Custom Instructions, create reusable prompts for your common tasks.

**Example for a Product Manager:**
```
Template:
"Analyze this feature request:
[description]

Consider:
- User value (0-10)
- Implementation effort (Small/Medium/Large)
- Strategic alignment
- Risks and dependencies

Recommend: Build now / Build later / Don't build"
```

---

## ✅ Testing Your Custom Instructions

After creating your Custom Instructions:

1. **Test with a familiar task**
   - Use a prompt you've used before
   - Compare the response quality
   - Check if Claude applies your preferences

2. **Check token efficiency**
   - Note how much context you need to provide
   - Should be less than before

3. **Refine**
   - What worked well?
   - What was confusing?
   - What did Claude ignore?
   - Update your instructions

---

## 📊 Efficiency Metrics (Projected)

_Note: Theoretical projections. Your results may vary by role._

**Generic Claude (no Custom Instructions):**
- Context setting: 500-1000 tokens per chat
- Need to repeat role/tools/preferences each time
- Generic responses, requires clarification

**With Role-Optimized Custom Instructions:**
- Context setting: ~100 tokens per chat
- Role and preferences pre-loaded
- Tailored responses immediately

**Expected savings:** 60-75% token reduction

---

## ❓ FAQ

**Q: How long should my Custom Instructions be?**
A: Aim for 1000-1500 characters per section. claude.ai limits to ~2000 chars per section.

**Q: Can I copy parts from the Software Engineer/QA templates?**
A: Absolutely! Mix and match what's relevant to your role.

**Q: Should I include my company or project?**
A: Generally no - keep Custom Instructions role-specific. Use Projects for company/project context.

**Q: What if I have multiple roles?**
A: Choose your primary role or create a hybrid. Custom Instructions are global (one set only).

**Q: Can I see examples from other roles?**
A: Yes! Check:
- [Software Engineer Guide](01_software-engineer.md)
- [QA Engineer Guide](02_qa-engineer.md)

---

## 🚀 Quick Start Checklist

- [ ] Copy the template above
- [ ] Fill in [YOUR ROLE] and [YOUR TASKS]
- [ ] List your primary tools/technologies
- [ ] Define your core values/principles
- [ ] Set response style preferences
- [ ] Paste into claude.ai → Settings → Custom Instructions
- [ ] Test with a common task
- [ ] Refine based on results

---

## 🤝 Share Your Template

Created a great Custom Instructions template for your role? Help others:

1. Open an issue on GitHub: "Custom Role Template: [Your Role]"
2. Share your anonymized template
3. We'll add it to the coming-soon list!

---

## Navigation

**🏠 [Back to Browser Workflow](../README.md)** | **📖 [All Roles](../README.md#choose-your-professional-role)** | **✨ [See Examples](01_software-engineer.md)**

---

*Part of the Claude.ai Workflow Optimization Guide - Custom Role Generator*
*Last updated: 2025-12-08*
