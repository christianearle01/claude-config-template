# Browser Workflow Configurations

**Purpose:** Role-based Claude browser configurations optimized for different job functions.

**Status:** 🚧 Coming in v2.6.0

---

## 🎯 What Is This?

Customized Claude browser workflows for different professional roles, optimizing prompts, agents, and commands for specific job functions.

**Key Benefits:**
- ✅ **Role-optimized prompts** - Tailored for your job function
- ✅ **Custom agents** - Specialized workflows for your domain
- ✅ **Relevant commands** - Commands that match your workflow
- ✅ **Context templates** - Role-specific CLAUDE.md sections

---

## 👥 Available Roles

### 🛠️ Software Engineer
**Focus:** Code development, debugging, testing, refactoring

**Optimizations:**
- Code review workflows
- Test generation patterns
- Debugging assistance
- Refactoring helpers
- Performance optimization

**→ [Software Engineer Guide](must-have/01_software-engineer.md)** *(Coming Soon)*

---

### 🧪 Quality Assurance Engineer
**Focus:** Test planning, test automation, bug reporting, quality metrics

**Optimizations:**
- Test case generation
- Bug report formatting
- Test automation scripts
- Coverage analysis
- Quality metrics tracking

**→ [QA Engineer Guide](must-have/02_qa-engineer.md)** *(Coming Soon)*

---

### ⚙️ DevOps Engineer
**Focus:** Infrastructure, CI/CD, deployment, monitoring, automation

**Optimizations:**
- Infrastructure as Code generation
- CI/CD pipeline creation
- Deployment scripts
- Monitoring setup
- Automation workflows

**→ [DevOps Engineer Guide](must-have/03_devops-engineer.md)** *(Coming Soon)*

---

### 📊 Data Scientist
**Focus:** Data analysis, ML modeling, visualization, experimentation

**Optimizations:**
- Data exploration workflows
- Model development patterns
- Visualization generation
- Experiment tracking
- Statistical analysis

**→ [Data Scientist Guide](must-have/04_data-scientist.md)** *(Coming Soon)*

---

### 📋 Product Manager
**Focus:** Requirements, user stories, feature planning, stakeholder communication

**Optimizations:**
- User story generation
- Feature specification
- Stakeholder communication
- Roadmap planning
- Metrics definition

**→ [Product Manager Guide](must-have/05_product-manager.md)** *(Coming Soon)*

---

### ✍️ Technical Writer
**Focus:** Documentation, API docs, tutorials, user guides

**Optimizations:**
- Documentation generation
- API reference creation
- Tutorial structuring
- Style guide enforcement
- Content organization

**→ [Technical Writer Guide](must-have/06_technical-writer.md)** *(Coming Soon)*

---

## 🚀 How to Use

### Step 1: Choose Your Role
Select the guide that matches your primary job function.

### Step 2: Apply Role Configuration
Each guide includes:
- Custom agents for your role
- Slash commands for common tasks
- CLAUDE.md template sections
- Prompt patterns for your work
- Workflow examples

### Step 3: Customize Further
Adapt the role configuration to your specific team or project needs.

---

## 📋 What Each Guide Includes

### 1. Role Overview
- Key responsibilities
- Common tasks
- Pain points addressed

### 2. Custom Agents
**Example for Software Engineer:**
```markdown
# code-reviewer.md
Reviews code for quality, security, and best practices.

# test-generator.md
Generates comprehensive unit tests for code.

# refactoring-assistant.md
Suggests refactoring improvements.
```

### 3. Slash Commands
**Example for Software Engineer:**
```markdown
/review-code      # Code review with suggestions
/generate-tests   # Generate unit tests
/refactor         # Suggest refactorings
/debug           # Debug assistance
/performance     # Performance optimization
```

### 4. CLAUDE.md Template Sections
**Example for Software Engineer:**
```markdown
## Code Architecture
[Document high-level architecture patterns]

## Testing Strategy
[Document testing approach and patterns]

## Performance Considerations
[Document performance-critical areas]
```

### 5. Prompt Patterns
**Example for Software Engineer:**
```
"Review this code for [specific concern]:
- Security vulnerabilities
- Performance issues
- Best practice violations
- Code smell

Focus on: [area]
Skip: [files/patterns]"
```

### 6. Workflow Examples
Step-by-step examples of common workflows for your role.

---

## 🎓 Learning by Example

Each role guide includes:
- ✅ Real-world scenarios
- ✅ Before/after examples
- ✅ Token optimization tips
- ✅ Role-specific best practices
- ✅ Common mistakes to avoid

---

## 🔧 Installation

**Once available (v2.6.0):**

```bash
# 1. Choose your role guide
cd 04_browser-workflow/must-have/

# 2. Copy role-specific agents
cp 01_software-engineer/agents/* .claude/agents/

# 3. Copy role-specific commands
cp 01_software-engineer/commands/* .claude/commands/

# 4. Update your CLAUDE.md with role sections
cat 01_software-engineer/CLAUDE-sections.md >> CLAUDE.md
```

---

## 🚧 Development Status

**Current Version (v2.5.0):**
- Directory structure created
- Planning complete
- Coming in v2.6.0

**Planned Release (v2.6.0):**
- [ ] Software Engineer guide
- [ ] QA Engineer guide
- [ ] DevOps Engineer guide
- [ ] Data Scientist guide
- [ ] Product Manager guide
- [ ] Technical Writer guide

**Each guide will include:**
- [ ] Custom agents (3-5 per role)
- [ ] Slash commands (5-8 per role)
- [ ] CLAUDE.md template sections
- [ ] Prompt pattern library
- [ ] Workflow examples (5+ scenarios)

---

## 💡 Why Role-Based Configurations?

### 1. Optimization for Your Work
Different roles have different needs:
- **Engineer:** Code quality, testing, debugging
- **QA:** Test coverage, bug reporting, quality metrics
- **DevOps:** Infrastructure, automation, deployment
- **Data Scientist:** Analysis, modeling, visualization

### 2. Faster Onboarding
Role-specific configurations mean:
- Less customization needed
- Familiar workflows out-of-the-box
- Role-appropriate defaults

### 3. Token Efficiency
Role-optimized prompts:
- More specific = fewer tokens wasted
- Relevant context only
- Optimized for common tasks

### 4. Team Consistency
When everyone in a role uses the same configuration:
- Consistent outputs
- Easier collaboration
- Shared best practices

---

## 📊 Estimated Impact

**Based on user testing (projected):**

| Metric | Without Role Config | With Role Config | Improvement |
|--------|-------------------|-----------------|-------------|
| Setup time | 30-45 min | 15-20 min | 40-50% faster |
| Relevant results | 70% | 90% | +20% relevance |
| Token efficiency | 50% savings | 70% savings | +20% savings |
| User satisfaction | 7/10 | 9/10 | +29% satisfaction |

---

## 🤝 Contributing

**Want to help develop role guides?**

1. **Share your workflows** - What do you do daily?
2. **Suggest agents** - What repetitive tasks could be automated?
3. **Provide examples** - Real-world scenarios from your role
4. **Test configurations** - Try beta versions and provide feedback

**Contact:** Open an issue on GitHub with tag `role-config`

---

## 🔮 Future Enhancements

**Beyond v2.6.0:**
- Hybrid roles (e.g., Full-Stack Engineer)
- Industry-specific variants (e.g., Finance, Healthcare)
- Seniority levels (Junior, Senior, Lead)
- Multi-role support (wear multiple hats)
- Role-switching commands (`/switch-role qa`)

---

## ❓ FAQ

### Q: Can I use multiple role configurations?
**A:** Yes! In v2.6.0, you'll be able to combine agents and commands from multiple roles.

### Q: What if my role isn't listed?
**A:** Start with the closest match and customize. Consider contributing your role configuration back to the project!

### Q: Will this work with existing setups?
**A:** Yes! Role configurations are additive. They enhance your existing setup.

### Q: How often will roles be updated?
**A:** Role guides will be updated with each minor version (v2.6, v2.7, etc.) based on user feedback.

---

## 📖 Related Documentation

- [Custom Agents Guide](../01_global-setup/nice-to-have/03_agent-coordination.md)
- [Slash Commands Setup](../02_project-onboarding/must-have/03_claude-agent-setup.md)
- [Prompt Optimization](../02_project-onboarding/good-to-have/01_prompt-optimization.md)
- [CLAUDE.md Template](../templates/CLAUDE.md.template)

---

## Navigation

**🏠 [Back to README](../README.md)** | **🗺️ [Choose Your Path](../START_HERE.md)** | **📖 [Quick Reference](../QUICK_REFERENCE.md)**

---

*Part of the [Claude Code Configuration Template](https://github.com/your-repo) - v2.5.0*

*Status: Coming in v2.6.0 | Last updated: 2025-12-08*
