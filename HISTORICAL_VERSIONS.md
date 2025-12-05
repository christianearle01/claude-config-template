# Historical Template Versions

This repository preserves historical versions of the template in separate branches.

## Available Historical Branches

### historical/v1.0-original
- **Description:** Original template version 1.0 before v2.0 restructuring
- **Date:** November-December 2024 (approximate)
- **Branch:** `historical/v1.0-original`
- **Tag:** `historical-v1.0` (create manually after push)
- **Files:** 10 core documentation files
- **Structure:** Flat organization with root-level markdown files
- **Status:** Archived (not maintained)

**Key Differences from v2.0+:**
- No persona-based routing
- No progressive wizards
- Simpler documentation structure
- Focus on prompt optimization and agent coordination
- Quick setup approach

**To view this version:**
```bash
git checkout historical/v1.0-original
# or (after tag is created)
git checkout historical-v1.0
```

**To compare with current version:**
```bash
# View file structure differences
git diff main historical/v1.0-original --stat

# View specific file differences
git diff main historical/v1.0-original -- README-SETUP.md
```

---

## Why Preserve Historical Versions?

1. **Migration Guidance** - Help users upgrade from v1.0 to v2.x
2. **Architectural Comparison** - Compare design decisions and evolution
3. **Learning Resource** - Understand how template evolved over time
4. **Backup/Recovery** - Access older approaches if needed
5. **Documentation** - Historical reference for decision-making

## Branch Naming Convention

- `historical/v1.0-original` - Original version 1.0
- `historical/v1.x-[feature]` - Future v1.x historical snapshots
- `historical/pre-[feature]` - Versions before major features

## Notes

- Historical branches use `--orphan` (independent history)
- No merge conflicts with main branch
- Purely for reference (not for development)
- Can be deleted without affecting main development
- Team can checkout for comparison at any time

---

## Manual Steps Required

After creating the historical branch locally, you'll need to:

1. **Push the branch to remote:**
   ```bash
   git push -u origin historical/v1.0-original
   ```

2. **Create the tag (optional but recommended):**
   ```bash
   git checkout historical/v1.0-original
   git tag -a historical-v1.0 -m "Template Version 1.0 (Historical Snapshot)

   Original version before v2.0 restructuring.
   Preserved for historical reference and comparison.

   Date: ~November 2024
   Files: 10 core documentation files
   Structure: Flat, simple organization
   Focus: Quick setup and prompt optimization"
   git push origin historical-v1.0
   git checkout main
   ```

3. **Verify everything worked:**
   ```bash
   # Check remote branch exists
   git branch -r | grep "historical"

   # Check tag exists (if created)
   git tag -l | grep "historical"
   ```

---

**Last Updated:** December 5, 2025
**Current Version:** v2.4.0
**Historical Versions Preserved:** 1
