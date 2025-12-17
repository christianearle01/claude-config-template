#!/bin/bash

################################################################################
# Team Lead Wizard
# Version: 2.1
# Time: 90-120 minutes
# Purpose: Team deployment and standardization
################################################################################

set -e

TEMPLATE_ROOT=$1

# Source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/wizard-helpers.sh"

# Start timer
start_timer

################################################################################
# Introduction
################################################################################

clear
echo -e "${YELLOW}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║                                                            ║${NC}"
echo -e "${YELLOW}║         👥 Team Lead (90-120 minutes)                     ║${NC}"
echo -e "${YELLOW}║                                                            ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}Team deployment plan (3 phases):${NC}"
echo ""
echo "  ${MAGENTA}Phase 1: Planning${NC}"
echo "    • Plan rollout strategy (pilot → full team)"
echo "    • Create shared template repository"
echo ""
echo "  ${MAGENTA}Phase 2: Implementation${NC}"
echo "    • Document team-specific standards"
echo "    • Onboard pilot users (2-3 developers)"
echo ""
echo "  ${MAGENTA}Phase 3: Iteration${NC}"
echo "    • Gather feedback and refine"
echo ""

show_tip "This is a one-time investment that pays off with team consistency."

pause

################################################################################
# Part 1: Rollout Strategy (15 minutes)
################################################################################

clear
show_phase_progress 1 3 "Planning"
show_task_progress 1 2 "Rollout Strategy"
echo ""

echo -e "${CYAN}Part 1: Planning Your Rollout Strategy (15 minutes)${NC}"
echo ""

echo -e "${YELLOW}Recommended rollout phases:${NC}"
echo ""
echo -e "${GREEN}Phase 1: Pilot (Week 1-2)${NC}"
echo "  • Select 2-3 early adopters"
echo "  • Complete setup with this wizard"
echo "  • Gather feedback on pain points"
echo "  • Refine templates and documentation"
echo ""
echo -e "${GREEN}Phase 2: Expansion (Week 3-4)${NC}"
echo "  • Onboard 5-10 more developers"
echo "  • Document common questions in FAQ"
echo "  • Create team-specific examples"
echo "  • Monitor adoption and usage"
echo ""
echo -e "${GREEN}Phase 3: Full Team (Week 5+)${NC}"
echo "  • Roll out to remaining team members"
echo "  • Establish best practices"
echo "  • Regular check-ins and optimization"
echo ""

echo -n -e "${GREEN}How many team members will use Claude Code? ${NC}"
read -r TEAM_SIZE

echo ""
echo -e "${CYAN}Estimated rollout timeline:${NC}"
if [ "$TEAM_SIZE" -lt 10 ]; then
    echo "  • Pilot: 1-2 weeks"
    echo "  • Full rollout: 2-4 weeks"
elif [ "$TEAM_SIZE" -lt 50 ]; then
    echo "  • Pilot: 2 weeks"
    echo "  • Expansion: 3-4 weeks"
    echo "  • Full rollout: 6-8 weeks"
else
    echo "  • Pilot: 2-3 weeks"
    echo "  • Expansion by team: 8-12 weeks"
    echo "  • Full rollout: 12-16 weeks"
fi

checkpoint 1 "Rollout strategy planned"

pause

################################################################################
# Part 2: Shared Template Repository (20 minutes)
################################################################################

clear
show_phase_progress 1 3 "Planning"
show_task_progress 2 2 "Shared Template"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 2: Create Shared Template Repository (20 minutes)${NC}"
echo ""

echo -e "${YELLOW}Why a shared template?${NC}"
echo "  • Ensures consistent configuration across team"
echo "  • Single source of truth for standards"
echo "  • Easy to update all projects with improvements"
echo "  • Version controlled and auditable"
echo ""

if ask_yes_no "Create shared template repository?"; then
    echo ""
    echo -e "${CYAN}Let's set up your team template!${NC}"
    echo ""

    # Get template repository path
    echo -n -e "${GREEN}Template repository path (e.g., ~/company/claude-template): ${NC}"
    read -r TEAM_TEMPLATE_PATH

    if [ -z "$TEAM_TEMPLATE_PATH" ]; then
        echo -e "${RED}Error: Template path required${NC}"
        exit 1
    fi

    # Create directory
    mkdir -p "$TEAM_TEMPLATE_PATH"
    echo -e "${GREEN}✅ Created directory: $TEAM_TEMPLATE_PATH${NC}"

    # Copy template contents
    echo ""
    echo "Copying template files..."
    cp -r "$TEMPLATE_ROOT/"* "$TEAM_TEMPLATE_PATH/" 2>/dev/null || true
    echo -e "${GREEN}✅ Copied template files${NC}"

    # Initialize git repository
    echo ""
    echo "Initializing git repository..."
    cd "$TEAM_TEMPLATE_PATH"
    git init > /dev/null 2>&1 || true
    echo -e "${GREEN}✅ Initialized git repository${NC}"

    # Create README for team
    cat > "$TEAM_TEMPLATE_PATH/TEAM_README.md" << 'EOF'
# Team Claude Code Template

**Purpose:** Standardized Claude Code setup for our team.

## Quick Start for Team Members

1. **Clone this template:**
   ```bash
   git clone <your-repo-url> ~/claude-template
   ```

2. **Run setup wizard:**
   ```bash
   cd ~/claude-template
   ./scripts/claude-wizard.sh
   ```

3. **Choose your profile:**
   - First time? → First-Time Learner
   - Experienced? → Quick Setup

## For New Projects

```bash
cd /path/to/your/project
cp -r ~/claude-template/.claude .
cp ~/claude-template/templates/CLAUDE.md.template ./CLAUDE.md
# Edit CLAUDE.md to document business purpose
claude
```

## Team Standards

[Add your team-specific standards here]

## Support

- Team Lead: [Your name]
- Slack channel: #claude-code-help
- Documentation: [Link to internal wiki]

## Updates

Check this repository regularly for template updates:
```bash
cd ~/claude-template
git pull
```
EOF

    echo -e "${GREEN}✅ Created TEAM_README.md${NC}"

    # Add team-specific files
    echo ""
    echo -e "${CYAN}Creating team-specific configuration...${NC}"

    mkdir -p "$TEAM_TEMPLATE_PATH/team"
    cat > "$TEAM_TEMPLATE_PATH/team/standards.md" << 'EOF'
# Team Coding Standards

## General Principles

- Follow existing code conventions
- Write self-documenting code
- Optimize for readability over cleverness

## Project Setup

1. Always use this template for new projects
2. Document business purpose in CLAUDE.md
3. Update .gitignore to exclude sensitive files

## Model Usage Guidelines

- **Sonnet**: Planning, design, code review
- **Haiku**: Implementation, refactoring
- **Opus**: Complex architectural decisions only

## Token Budget

- Target: <50K tokens per feature
- Monitor with: `/usage` command
- Optimize prompts: Reference files explicitly

## Security

- Never commit .env files
- Never commit .claude/memory.json
- Use security hooks for external content

## Code Review Checklist

- [ ] CLAUDE.md updated (if new features)
- [ ] Tests passing
- [ ] Big O complexity acceptable (O(n) or better)
- [ ] No security vulnerabilities
- [ ] Follows team conventions
EOF

    echo -e "${GREEN}✅ Created team/standards.md${NC}"

    checkpoint 2 "Shared template created"

    echo ""
    echo -e "${MAGENTA}Next steps for shared template:${NC}"
    echo "  1. Push to GitHub/GitLab: git remote add origin <url>"
    echo "  2. Share with team: git push -u origin main"
    echo "  3. Document in team wiki"
    echo ""
else
    echo ""
    echo -e "${CYAN}Skipping shared template creation.${NC}"
    TEAM_TEMPLATE_PATH=$TEMPLATE_ROOT
fi

pause

################################################################################
# Part 3: Team-Specific Standards (30 minutes)
################################################################################

clear
show_phase_progress 2 3 "Implementation"
show_task_progress 1 2 "Team Standards"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 3: Document Team-Specific Standards (30 minutes)${NC}"
echo ""

echo -e "${YELLOW}What to document:${NC}"
echo "  • Coding conventions (naming, formatting)"
echo "  • Model usage guidelines (when Sonnet vs Haiku)"
echo "  • Token budget per feature"
echo "  • Security requirements"
echo "  • Code review checklist"
echo ""

if [ -f "$TEAM_TEMPLATE_PATH/team/standards.md" ]; then
    echo -e "${GREEN}✅ Team standards template created${NC}"
    echo ""
    echo "Edit this file to customize for your team:"
    echo "  $TEAM_TEMPLATE_PATH/team/standards.md"
    echo ""

    if ask_yes_no "Edit team standards now?"; then
        if [ -n "$EDITOR" ]; then
            $EDITOR "$TEAM_TEMPLATE_PATH/team/standards.md"
        elif command -v code &> /dev/null; then
            code "$TEAM_TEMPLATE_PATH/team/standards.md"
            pause "Press Enter after editing..."
        elif command -v nano &> /dev/null; then
            nano "$TEAM_TEMPLATE_PATH/team/standards.md"
        else
            echo -e "${YELLOW}No editor found. Edit manually later.${NC}"
        fi
    fi
fi

# Create global coding standards
echo ""
echo -e "${CYAN}Creating global coding standards...${NC}"

mkdir -p "$HOME/.claude"
cat > "$HOME/.claude/coding-standards.md" << 'EOF'
# Global Coding Standards

These standards apply to ALL projects unless overridden by project-specific CLAUDE.md.

## Indentation & Formatting

- Use 4 spaces (NEVER tabs) when creating new files
- Maintain consistency with existing file formatting
- Use clear and appropriate naming conventions

## Big O Notation & Algorithmic Efficiency

- Target acceptable complexity: O(1), O(log n), O(n), O(n log n)
- Avoid O(n²) or worse unless explicitly required
- Prefer efficient data structures: HashMap/Set for O(1) lookups

## Code Quality

- Ensure time complexity is O(n) or better whenever possible
- Avoid unnecessary nested iterations
- Handle edge cases: n = 0, very large n, adversarial inputs
- Validate logic against edge cases and scalability requirements

## Documentation

- Keep code self-documenting with clear names
- Add comments only where logic is non-obvious
- Document algorithm choices and Big O complexity for critical functions

## Security

- NEVER commit .env files or API keys
- Use parameterized queries (prevent SQL injection)
- Validate all external inputs
- Follow principle of least privilege

## Testing

- Write tests for critical business logic
- Test edge cases (empty input, very large input, null values)
- Aim for 80%+ code coverage on core features
EOF

echo -e "${GREEN}✅ Created ~/.claude/coding-standards.md${NC}"

checkpoint 3 "Team standards documented"

pause

################################################################################
# Part 4: Pilot User Onboarding (30 minutes)
################################################################################

clear
show_phase_progress 2 3 "Implementation"
show_task_progress 2 2 "Pilot Onboarding"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 4: Onboard Pilot Users (30 minutes)${NC}"
echo ""

echo -e "${YELLOW}Pilot user selection criteria:${NC}"
echo "  • Early adopters (enthusiastic about AI tools)"
echo "  • Diverse roles (frontend, backend, full-stack)"
echo "  • Good communicators (will provide feedback)"
echo "  • Available for 1-2 week pilot"
echo ""

echo -n -e "${GREEN}How many pilot users? (recommended: 2-3): ${NC}"
read -r PILOT_COUNT

echo ""
echo -e "${CYAN}Pilot onboarding checklist:${NC}"
echo ""

for i in $(seq 1 ${PILOT_COUNT:-2}); do
    echo -e "${MAGENTA}Pilot User $i:${NC}"
    echo "  [ ] Share template repository URL"
    echo "  [ ] Schedule 30-min onboarding session"
    echo "  [ ] Walk through wizard (First-Time Learner or Quick Setup)"
    echo "  [ ] Help set up first project"
    echo "  [ ] Schedule Week 1 check-in"
    echo "  [ ] Collect feedback (what worked, what didn't)"
    echo ""
done

echo -e "${YELLOW}Onboarding session agenda (30 minutes):${NC}"
echo "  1. Overview of Claude Code benefits (5 min)"
echo "  2. Run setup wizard together (15 min)"
echo "  3. Set up their first project (10 min)"
echo "  4. Q&A and troubleshooting (5 min)"
echo ""

show_tip "Record the onboarding session for async training later."

checkpoint 4 "Pilot users onboarded"

pause

################################################################################
# Part 5: Feedback and Refinement (15 minutes)
################################################################################

clear
show_phase_progress 3 3 "Iteration"
show_task_progress 1 1 "Feedback Collection"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 5: Gather Feedback and Refine (Ongoing)${NC}"
echo ""

echo -e "${YELLOW}Feedback collection plan:${NC}"
echo ""
echo -e "${GREEN}Week 1 Check-in:${NC}"
echo "  • How's the setup working?"
echo "  • Any blockers or confusion?"
echo "  • What documentation is missing?"
echo ""
echo -e "${GREEN}Week 2 Review:${NC}"
echo "  • Token usage analysis (hitting budgets?)"
echo "  • Model switching adoption (using Haiku?)"
echo "  • CLAUDE.md quality (updated regularly?)"
echo ""
echo -e "${GREEN}Week 4 Retrospective:${NC}"
echo "  • What worked well?"
echo "  • What should change for next wave?"
echo "  • Update template based on learnings"
echo ""

# Create feedback template
cat > "$TEAM_TEMPLATE_PATH/team/feedback-template.md" << 'EOF'
# Claude Code Pilot Feedback

**Pilot User:** [Name]
**Date:** [YYYY-MM-DD]
**Week:** [1/2/4]

## Setup Experience

- How long did setup take? ___ minutes
- Difficulty rating (1-5): ___
- Wizard clarity (1-5): ___

## Usage Patterns

- Projects using Claude Code: ___
- Model switching frequency: [ ] Always [ ] Sometimes [ ] Never
- Token usage per week: ___ K tokens
- Cost awareness: [ ] Track closely [ ] Aware [ ] Not tracking

## What's Working Well?

[Free text]

## Pain Points / Blockers

[Free text]

## Documentation Gaps

[Free text]

## Feature Requests

[Free text]

## Would you recommend to teammates?

[ ] Yes, definitely
[ ] Yes, with reservations
[ ] No

**Why?**

[Free text]

## Additional Comments

[Free text]
EOF

echo -e "${GREEN}✅ Created feedback template${NC}"
echo ""
echo "Feedback template: $TEAM_TEMPLATE_PATH/team/feedback-template.md"
echo ""

checkpoint 5 "Feedback process established"

pause

################################################################################
# Knowledge Check
################################################################################

quiz \
    "What's the recommended pilot group size?" \
    "B" \
    "10+ users (get broad feedback)" \
    "2-3 users (early adopters)" \
    "Everyone at once (faster rollout)"

quiz \
    "Why use a shared template repository?" \
    "C" \
    "It's required by Claude Code" \
    "To track individual usage" \
    "Ensures team consistency and easy updates"

pause

################################################################################
# Final Summary
################################################################################

clear
check_timer "Total team setup time"
echo ""

success_banner "Team Lead"

echo -e "${CYAN}Team Deployment Plan Complete!${NC}"
echo ""
echo "  ✅ Rollout strategy planned ($TEAM_SIZE team members)"
if [ -d "$TEAM_TEMPLATE_PATH/team" ]; then
    echo "  ✅ Shared template repository created"
fi
echo "  ✅ Team standards documented"
echo "  ✅ Pilot onboarding plan ready (${PILOT_COUNT:-2} users)"
echo "  ✅ Feedback collection process established"
echo ""

echo -e "${MAGENTA}Immediate Next Steps:${NC}"
echo ""
echo -e "${GREEN}1. Share template repository:${NC}"
if [ -d "$TEAM_TEMPLATE_PATH/.git" ]; then
    echo "   cd $TEAM_TEMPLATE_PATH"
    echo "   git remote add origin <your-repo-url>"
    echo "   git add ."
    echo "   git commit -m 'Initial team Claude Code template'"
    echo "   git push -u origin main"
else
    echo "   Initialize git and push to GitHub/GitLab"
fi
echo ""
echo -e "${GREEN}2. Schedule pilot onboarding sessions${NC}"
echo "   • 30 minutes per user"
echo "   • Run wizard together"
echo "   • Set up first project"
echo ""
echo -e "${GREEN}3. Create support channel${NC}"
echo "   • Slack: #claude-code-help"
echo "   • Document common Q&A"
echo "   • Weekly office hours"
echo ""

echo -e "${YELLOW}Success Metrics to Track:${NC}"
echo "  • Completion rate: Target 95%"
echo "  • Setup time: Target <30 min (Quick Setup)"
echo "  • Token savings: Target 50%+ reduction"
echo "  • Adoption rate: Target 80%+ after 8 weeks"
echo "  • User satisfaction: Target 8/10+"
echo ""

echo -e "${CYAN}Resources:${NC}"
echo "  • Team onboarding guide: $TEMPLATE_ROOT/02_project-onboarding/good-to-have/03_team-onboarding.md"
echo "  • Template repository: $TEAM_TEMPLATE_PATH"
echo "  • Feedback template: $TEAM_TEMPLATE_PATH/team/feedback-template.md"
echo ""

celebrate "Your team is ready for Claude Code"

exit 0
