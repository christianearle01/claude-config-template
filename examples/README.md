# Examples Directory

**Ready-to-use configuration examples and templates.**

---

## Directory Index

| Directory | Description | Contents |
|-----------|-------------|----------|
| [global-settings/](global-settings/) | Global Claude Code settings | Example `~/.claude/settings.json` configurations |
| [hooks/](hooks/) | Git and Claude hooks | Pre-commit hooks, event handlers |
| [mcp-servers/](mcp-servers/) | MCP server configurations | Server setup examples |
| [npm-security/](npm-security/) | NPM security configurations | `.npmrc`, package scanning scripts |
| [python-security/](python-security/) | Python security configurations | `pip.conf`, requirements templates |

---

## global-settings/

Example global settings for `~/.claude/settings.json`.

**Use case:** Setting up consistent Claude Code behavior across all projects.

**Files:**
- `README.md` - Detailed explanation of each setting
- Example configurations for different workflows

---

## hooks/

Git hooks and Claude Code event handlers.

**Use case:** Automating tasks on git events or Claude Code events.

**Contents:**
- `INSTALL.md` - Installation instructions
- Pre-commit hook examples
- Event handler templates

---

## mcp-servers/

MCP (Model Context Protocol) server configurations.

**Use case:** Extending Claude Code with additional tools and capabilities.

**Contents:**
- Server configuration templates
- Setup guides

---

## npm-security/

NPM package security configurations and scripts.

**Use case:** Securing JavaScript/TypeScript projects from supply chain attacks.

**Contents:**
- `.npmrc` template with security settings
- `package.json` security scripts
- Dependency scanning configurations
- Lock file audit scripts

**Related docs:** [NPM Security Guide](../01_global-setup/nice-to-have/04_npm-security-guide.md)

---

## python-security/

Python package security configurations and templates.

**Use case:** Securing Python projects from malicious packages.

**Contents:**
- `pip.conf` template with security settings
- `requirements.txt` template with version pinning
- `pyproject.toml` security configurations
- Virtual environment best practices

**Related docs:** [Python Security Guide](../01_global-setup/nice-to-have/05_python-security-guide.md)

---

## How to Use These Examples

### Copy Directly
```bash
# Copy a specific example
cp examples/global-settings/settings.json ~/.claude/settings.json

# Copy security configs
cp examples/npm-security/.npmrc ~/my-project/.npmrc
```

### Use as Reference
Review the examples and adapt them to your needs. Each directory has its own README with detailed explanations.

### With the Wizard
```bash
# The setup wizard can apply these examples automatically
./scripts/claude-wizard.sh
```

---

## Contributing Examples

Have a useful configuration? Contributions welcome!

1. Create a directory for your example type
2. Include a README explaining the configuration
3. Add comments in config files explaining each setting
4. Submit a pull request

---

*v3.15.0 - Examples master index*
