# Project Memory - [PROJECT NAME]

> **Global Standards**: This project follows the coding standards in `~/.claude/coding-standards.md`
> - 4 spaces indentation (not tabs)
> - Big O notation thinking
> - Algorithmic efficiency (target O(n) or better)
> - Clear naming conventions
> - Edge case handling

## Project Overview
[Brief description of what this project does]

## Tech Stack
- Languages: [Python, JavaScript, TypeScript, etc.]
- Frameworks: [Django, React, Flask, Express, etc.]
- Database: [PostgreSQL, MongoDB, MySQL, etc.]
- Other tools: [Docker, Redis, Celery, etc.]

## Code Style & Conventions
- **Indentation**: 4 spaces (not tabs) - global requirement
- **Naming**: Clear, descriptive names; specify convention [camelCase / snake_case / PascalCase]
- **Algorithm Design**: Apply Big O notation thinking, target O(n) or better
- **Data Structures**: Use HashMap/Set for O(1) lookups, avoid nested loops on same dataset
- **Code Quality**: Analyze as veteran software engineer, consider edge cases
- **Line Length**: [80 / 100 / 120 characters]
- **Import Ordering**: [Alphabetical / grouped by type]
- **Documentation**: Self-documenting code, comments only where logic is non-obvious

## Testing Requirements
- Test framework: [pytest, jest, unittest, etc.]
- Coverage minimum: [80% / 90%]
- Run tests before commits: [Yes/No]
- Test file naming: [test_*.py / *.test.js]

## Development Workflow
- Main branch: [main / master / develop]
- Feature branches: [feature/name / feat/name]
- Commit message style: [Conventional Commits / custom]
- PR requirements: [Tests pass, coverage maintained, reviewed]

## Important Files & Locations
- Configuration: [path/to/config files]
- Tests: [path/to/tests]
- Documentation: [path/to/docs]
- Build output: [dist/, build/, etc.]

## Security & Privacy
- Environment variables location: [.env / config/secrets.yml]
- Sensitive data patterns to avoid: [API keys, passwords, tokens, PII]
- Files to never commit: [.env, credentials.json, *.key, etc.]

## Common Commands
- Start development: [npm run dev / python manage.py runserver]
- Run tests: [pytest / npm test]
- Build for production: [npm run build / make build]
- Deploy: [deployment commands or reference]

## Project Structure (For Agent Coordination)
- **Main application**: [path to main app code]
- **API endpoints**: [path to API files]
- **Database models**: [path to models]
- **Tests**: [path to test files]
- **Configuration**: [path to config files]

## Agent Optimization Notes
- [List large files to avoid re-reading, e.g., "migrations/", "build/"]
- [Document existing patterns to reference, e.g., "Auth uses OAuth2 pattern"]
- [Note what's already complete to avoid re-analysis]
- [Specify template files or reference implementations]
