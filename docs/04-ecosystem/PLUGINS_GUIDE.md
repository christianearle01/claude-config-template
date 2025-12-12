# Claude Code Plugins

**Bundle and share workflows across teams**

---

## Sources & Validation

**Official Claude Code Documentation:**
- Plugin system: Official Claude Code feature ✅ VALIDATED
- Plugin installation: Documented in official docs

**Community Insights:**
Analysis from NotebookLLM covering three YouTube sources:
- "Vibe Coding vs AI Augmented Coding": https://www.youtube.com/watch?v=hwEgheORjjs
- "800+ Hours of Claude Code Experience": https://www.youtube.com/watch?v=Ffh9OeJ7yxw
- "Claude Code Agent Skills": https://www.youtube.com/watch?v=CEvIs9y1uog

**Note:** Plugins enable team governance and workflow sharing.

---

## What Are Plugins?

**Definition:** Bundled collections of Claude Code configurations

**A plugin can include:**
- Slash commands
- Custom agents
- Hooks (pre/post actions)
- MCP server configurations
- Skills (expertise folders)
- Example files
- Documentation

**Think of plugins as:**
- NPM packages for Claude Code workflows
- Installable productivity bundles
- Team standard kits

---

## Why Use Plugins?

### Problem: Team Inconsistency

**Without plugins:**
```
Developer A: Uses custom code-review agent
Developer B: Has different code-review agent
Developer C: No code-review agent

Result: Inconsistent code quality, tribal knowledge
```

**With plugins:**
```
Team installs: company-standards-plugin

Everyone gets:
- Same code-review agent
- Same commit message format
- Same security checks
- Same documentation patterns

Result: Consistent quality, shared knowledge
```

---

### Problem: Onboarding Friction

**Without plugins:**
```
New developer joins:
1. Set up Claude Code (30 min)
2. Copy team configurations manually (60 min)
3. Learn tribal knowledge (weeks)
4. Hope they got everything right

Total: 90+ minutes setup, weeks to productivity
```

**With plugins:**
```
New developer joins:
1. Install Claude Code (10 min)
2. Install company plugin (2 min):
   claude plugin install company-standards

Total: 12 minutes setup, instant team standards
```

---

### Problem: Workflow Sharing

**Quote from power users:**
> "Plugins are how we share entire workflows across team/community"

**Use cases:**
- Company coding standards
- Framework-specific patterns (Next.js plugin, React plugin)
- Security best practices
- Documentation templates
- Testing workflows

---

## Plugin Structure

### Basic Plugin Anatomy

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── commands/
│   ├── code-review.md       # Slash command: /code-review
│   └── commit.md            # Slash command: /commit
├── agents/
│   ├── security-auditor.md  # Custom agent
│   └── test-generator.md    # Custom agent
├── skills/
│   └── api-design/          # Skill folder
│       ├── SKILL.md
│       └── examples/
├── hooks/
│   └── pre-commit.sh        # Git hook
├── .mcp.json                # MCP server configs
├── README.md                # Plugin documentation
└── examples/
    └── sample-project/      # Example usage
```

---

### Plugin Metadata (plugin.json)

**Minimal example:**
```json
{
  "name": "company-standards",
  "version": "1.0.0",
  "description": "Company coding standards and workflows",
  "author": "Engineering Team",
  "repository": "https://github.com/company/claude-plugin"
}
```

**Full example:**
```json
{
  "name": "company-standards",
  "version": "1.2.0",
  "description": "Company coding standards and workflows",
  "author": "Engineering Team <dev@company.com>",
  "repository": "https://github.com/company/claude-plugin",
  "license": "MIT",
  "keywords": ["typescript", "react", "testing", "security"],
  "dependencies": {
    "mcpServers": ["github", "sequential-thinking"]
  },
  "requirements": {
    "claudeCodeVersion": ">=1.0.0"
  }
}
```

---

## Installing Plugins

### From Public Marketplace (Hypothetical)

**If/when Claude Code has a public marketplace:**
```bash
claude plugin install plugin-name

# From specific marketplace
claude plugin install plugin-name@marketplace-name

# Specific version
claude plugin install plugin-name@1.2.0
```

---

### From Git Repository

**Install from GitHub/GitLab:**
```bash
# Via HTTPS
claude plugin install https://github.com/company/claude-plugin.git

# Via SSH
claude plugin install git@github.com:company/claude-plugin.git

# Specific branch
claude plugin install https://github.com/company/claude-plugin.git#develop
```

---

### From Local Directory

**Install from local folder:**
```bash
# Absolute path
claude plugin install /path/to/my-plugin

# Relative path
claude plugin install ./my-plugin

# Current directory (if contains .claude-plugin/)
claude plugin install .
```

---

### From Zip/Tarball

**Install from archive:**
```bash
# From zip file
claude plugin install ./company-standards-v1.2.0.zip

# From URL
claude plugin install https://example.com/plugins/company-standards.zip
```

---

## Managing Plugins

### List Installed Plugins

```bash
claude plugin list
```

**Output:**
```
Installed plugins:
- company-standards@1.2.0 (from git)
- react-patterns@2.1.0 (from local)
- security-checks@1.0.0 (from marketplace)
```

---

### Update Plugin

```bash
# Update to latest version
claude plugin update company-standards

# Update all plugins
claude plugin update --all
```

---

### Remove Plugin

```bash
claude plugin uninstall company-standards
```

**What gets removed:**
- Commands
- Agents
- Hooks
- MCP configs (if not used elsewhere)
- Skills

**What stays:**
- User-created files
- Project-specific settings

---

## Creating Your Own Plugin

### Step 1: Initialize Plugin

**Create plugin directory:**
```bash
mkdir my-plugin
cd my-plugin
```

**Create plugin.json:**
```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "My custom Claude Code workflows",
  "author": "Your Name <you@example.com>"
}
```

**Create directory structure:**
```bash
mkdir -p .claude-plugin commands agents skills hooks examples
mv plugin.json .claude-plugin/
```

---

### Step 2: Add Commands

**Create command file:**
```bash
touch commands/code-review.md
```

**Content:**
```markdown
---
name: code-review
description: Review code for security, performance, and quality
arguments: true
---

# Code Review

Review the code changes for:

1. **Security vulnerabilities:**
   - SQL injection risks
   - XSS vulnerabilities
   - Exposed secrets

2. **Performance issues:**
   - N+1 queries
   - Unnecessary re-renders
   - Memory leaks

3. **Code quality:**
   - Naming conventions
   - Code duplication
   - Error handling

Provide specific recommendations with code examples.

$ARGUMENTS
```

**Usage after install:**
```bash
/code-review src/auth/login.ts
```

---

### Step 3: Add Agents

**Create agent file:**
```bash
touch agents/test-generator.md
```

**Content:**
```yaml
---
name: test-generator
description: Generates unit tests for a given function
allowed-tools: Read, Write
model: sonnet
---

# Test Generator

## Task
Generate comprehensive unit tests covering:
- Happy path
- Edge cases
- Error conditions

## Process
1. Read function source code
2. Identify edge cases
3. Generate test cases
4. Write tests using project's test framework

## Output
Test file with 80%+ code coverage
```

**Usage after install:**
```bash
# Spawn via Task tool
You: "Generate tests for the login function"
Claude: *spawns test-generator agent automatically*
```

---

### Step 4: Add Skills

**Create Skill folder:**
```bash
mkdir -p skills/api-design
touch skills/api-design/SKILL.md
```

**Content:**
```yaml
---
name: api-design
description: RESTful API design following company standards
---

# API Design Skill

## Instructions

When designing REST APIs:
1. Use plural nouns for resources: /users, /posts
2. Use HTTP verbs correctly: GET, POST, PUT, DELETE
3. Version APIs: /v1/users
4. Return consistent error format:
   {
     "error": "Error message",
     "code": "ERROR_CODE",
     "details": {}
   }

## Example Good API

GET /v1/users/:id
POST /v1/users
PUT /v1/users/:id
DELETE /v1/users/:id

## Example Bad API

GET /getUserById
POST /createUser
```

**Usage after install:**
Automatic when user asks about API design

---

### Step 5: Add Documentation

**Create README.md:**
```markdown
# My Plugin

Company coding standards and workflows for Claude Code.

## What's Included

- **Commands:** /code-review, /commit
- **Agents:** test-generator, security-auditor
- **Skills:** api-design, error-handling
- **Hooks:** pre-commit (runs tests)

## Installation

From GitHub:
\`\`\`bash
claude plugin install https://github.com/company/my-plugin.git
\`\`\`

From local:
\`\`\`bash
claude plugin install ./my-plugin
\`\`\`

## Usage

### Code Review
\`\`\`bash
/code-review src/auth/login.ts
\`\`\`

### Generate Tests
\`\`\`
You: "Generate tests for calculateTotal function"
\`\`\`

### API Design
Claude automatically applies api-design Skill when you ask about APIs.

## Requirements

- Claude Code >= 1.0.0
- MCP Servers: github, sequential-thinking

## License

MIT
```

---

### Step 6: Test Your Plugin

**Install locally:**
```bash
claude plugin install ./my-plugin
```

**Verify installation:**
```bash
claude plugin list
# Should show: my-plugin@1.0.0 (from local)
```

**Test each feature:**
```bash
# Test command
/code-review src/test.ts

# Test agent
You: "Generate tests for myFunction"

# Test skill
You: "Design an API for user management"
```

---

### Step 7: Share Your Plugin

**Option 1: GitHub Repository**
```bash
git init
git add .
git commit -m "Initial plugin release"
git remote add origin https://github.com/you/my-plugin.git
git push -u origin main
git tag v1.0.0
git push origin v1.0.0
```

**Others install:**
```bash
claude plugin install https://github.com/you/my-plugin.git
```

---

**Option 2: Zip File**
```bash
zip -r my-plugin-v1.0.0.zip my-plugin/
```

**Others install:**
```bash
claude plugin install ./my-plugin-v1.0.0.zip
```

---

**Option 3: Internal Package Registry**

For companies with private registries:
```bash
npm publish  # If using npm for distribution
```

---

## Real-World Plugin Examples

### Example 1: Company Standards Plugin

**Purpose:** Enforce company-wide coding standards

**Contents:**
```
company-standards/
├── .claude-plugin/plugin.json
├── commands/
│   ├── review.md           # /review - Code review with standards
│   └── commit.md           # /commit - Conventional commits
├── agents/
│   └── security-checker.md # Security audit agent
├── skills/
│   ├── typescript-style/   # TS naming conventions
│   ├── api-design/         # REST API patterns
│   └── error-handling/     # Error handling patterns
└── README.md
```

**Installation:**
```bash
claude plugin install https://github.com/company/standards-plugin.git
```

**Result:** All developers use same standards automatically

---

### Example 2: Next.js Plugin

**Purpose:** Next.js best practices and patterns

**Contents:**
```
nextjs-plugin/
├── .claude-plugin/plugin.json
├── skills/
│   ├── app-router/         # App router patterns
│   ├── server-actions/     # Server actions
│   └── caching/            # Caching strategies
├── agents/
│   └── route-generator.md  # Generate Next.js routes
├── examples/
│   └── sample-app/         # Example Next.js app
└── README.md
```

**Installation:**
```bash
claude plugin install nextjs-best-practices
```

**Usage:**
```
You: "Create a new API route for user authentication"
Claude: *applies app-router Skill, generates route following patterns*
```

---

### Example 3: Testing Plugin

**Purpose:** Comprehensive testing workflows

**Contents:**
```
testing-plugin/
├── .claude-plugin/plugin.json
├── commands/
│   ├── test.md             # /test - Run tests
│   └── coverage.md         # /coverage - Check coverage
├── agents/
│   ├── test-generator.md   # Generate unit tests
│   └── e2e-builder.md      # Build E2E tests
├── skills/
│   └── testing-patterns/   # Testing best practices
└── README.md
```

**Result:** Consistent testing across all projects

---

## Advanced Plugin Features

### Plugin Dependencies

**Depend on other plugins:**
```json
{
  "name": "my-plugin",
  "dependencies": {
    "plugins": ["company-standards@1.0.0"],
    "mcpServers": ["github", "sequential-thinking"]
  }
}
```

**Install:**
```bash
claude plugin install my-plugin
# Automatically installs company-standards plugin
# Verifies github and sequential-thinking MCPs are available
```

---

### Version Constraints

**Require specific Claude Code version:**
```json
{
  "name": "my-plugin",
  "requirements": {
    "claudeCodeVersion": ">=1.2.0",
    "nodeVersion": ">=18.0.0"
  }
}
```

**Prevents installation if requirements not met.**

---

### Environment-Specific Configs

**Plugin with environment variables:**
```json
{
  "name": "my-plugin",
  "env": {
    "COMPANY_API_URL": "https://api.company.com",
    "ENABLE_ANALYTICS": "true"
  }
}
```

**Merged into user's environment when plugin is active.**

---

## Best Practices

### 1. Semantic Versioning

**Follow semver:** MAJOR.MINOR.PATCH

- **MAJOR (1.0.0 → 2.0.0):** Breaking changes
- **MINOR (1.0.0 → 1.1.0):** New features, backwards-compatible
- **PATCH (1.0.0 → 1.0.1):** Bug fixes

**Example:**
```bash
git tag v1.0.0  # Initial release
git tag v1.1.0  # Added new command
git tag v1.1.1  # Fixed bug in command
git tag v2.0.0  # Restructured skills (breaking change)
```

---

### 2. Documentation

**Always include:**
- README.md with installation instructions
- Usage examples for each feature
- Requirements (Claude Code version, MCPs)
- License information

**Example README structure:**
```markdown
# Plugin Name

## What's Included
## Installation
## Usage
## Requirements
## Troubleshooting
## Contributing
## License
```

---

### 3. Testing

**Before releasing:**
- Install plugin locally
- Test each command
- Verify agents spawn correctly
- Ensure Skills activate as expected
- Check for conflicts with default configs

**Test in fresh environment:**
```bash
# Create test directory
mkdir test-plugin
cd test-plugin

# Install plugin
claude plugin install ../my-plugin

# Test features
/my-command
```

---

### 4. Versioning Content

**Keep breaking changes to minimum:**
- Don't rename commands (breaks user workflows)
- Don't remove agents (users may depend on them)
- Deprecate gradually (announce in README)

**Good version progression:**
```
v1.0.0 - Initial release (3 commands, 2 agents)
v1.1.0 - Added new command: /deploy
v1.2.0 - Added new Skill: database-design
v1.2.1 - Fixed bug in /deploy command
v2.0.0 - Renamed /review → /code-review (breaking change)
```

---

### 5. Licensing

**Choose appropriate license:**
- **MIT:** Most permissive (recommended for open-source)
- **Apache 2.0:** Permissive with patent grant
- **Proprietary:** For internal company plugins

**Add LICENSE file:**
```bash
touch LICENSE
```

---

## Troubleshooting Plugins

### Plugin Not Found

**Error:** "Plugin 'my-plugin' not found"

**Solutions:**
1. Check plugin name:
   ```bash
   claude plugin list
   ```
2. Verify installation:
   ```bash
   claude plugin install ./my-plugin
   ```

---

### Command Conflicts

**Error:** "Command '/review' already exists"

**Cause:** Another plugin or user config has same command

**Solutions:**
1. Uninstall conflicting plugin
2. Rename command in your plugin
3. Use namespaced commands: /company:review

---

### Missing Dependencies

**Error:** "Required MCP 'github' not found"

**Solutions:**
1. Install required MCP:
   ```bash
   claude mcp add github
   ```
2. Update plugin.json dependencies list

---

## FAQ

**Q: Can I create private plugins for my team?**
A: Yes! Host on private GitHub repo or internal package registry.

**Q: Do plugins work across projects?**
A: Yes, plugins are installed globally. All projects can use them.

**Q: Can I override a plugin's settings per project?**
A: Yes, project-level settings override plugin settings.

**Q: How do I update a plugin I created?**
A: Bump version in plugin.json, commit, tag, push. Users run `claude plugin update`.

**Q: Can plugins include MCP server configurations?**
A: Yes, include .mcp.json in plugin. Gets merged with user's MCP config.

**Q: What if I want to disable a plugin temporarily?**
A: `claude plugin disable my-plugin` (keeps it installed but inactive)

**Q: Can plugins bundle Skills?**
A: Yes! Include skills/ directory in plugin. Skills activate automatically.

---

## Summary

**Plugin Core Principles:**

1. **Bundle workflows** - Commands, agents, Skills, hooks in one package
2. **Share across teams** - Git, zip, or marketplace distribution
3. **Version properly** - Semantic versioning for clear updates
4. **Document thoroughly** - README with usage examples
5. **Test before release** - Fresh environment, all features

**The outcome:**
- ✅ Team consistency (same standards, same workflows)
- ✅ Fast onboarding (2-minute plugin install vs. 90-minute manual setup)
- ✅ Shared knowledge (Skills, agents, commands preserved)
- ✅ Easy updates (version bumps propagate to team)

**Best practice:**
> Create plugins for reusable workflows. Share via Git. Version with semver. Document usage. Test thoroughly.

---

**See also:**
- [Skills Paradigm](../01-fundamentals/SKILLS_PARADIGM.md) - Skills in plugins
- [Third-Party MCPs](THIRD_PARTY_MCPS.md) - Including MCPs in plugins
- [Advanced MCP Workflows](../03-advanced/ADVANCED_MCP_WORKFLOWS.md) - Orchestration patterns
