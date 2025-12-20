# Dependency Manager 🗑️

A powerful tool suite for finding and cleaning up dependency directories across your development projects. Free up disk space by identifying and removing regeneratable dependencies like `node_modules`, `venv`, `build`, and more.

## 📊 What It Does

Scans your development directory for common dependency and build directories, providing:
- **Size analysis** - See which projects consume the most space
- **First-level filtering** - Only shows top-level dependency directories (excludes nested ones)
- **0B filtering** - Automatically filters out empty directories
- **Safe deletion** - Multiple deletion modes with confirmations and backups

## 🚀 Quick Start

### Step 1: Scan for Dependencies

```bash
./scripts/dependency-manager/find-dependencies.sh [path]
```

**Example:**
```bash
# Scan your entire Developer directory
./scripts/dependency-manager/find-dependencies.sh ~/Developer

# Scan a specific project
./scripts/dependency-manager/find-dependencies.sh ~/Developer/my-project
```

**Output:**
- Terminal: Colored, formatted summary
- File: `dependency-scan-results.txt` with complete results

### Step 2: Remove Dependencies

```bash
./scripts/dependency-manager/remove-dependencies.sh
```

Opens an interactive menu with multiple deletion options.

## 📁 Supported Dependency Types

| Type | Description | Languages/Frameworks |
|------|-------------|---------------------|
| `node_modules` | Package dependencies | JavaScript/Node.js/npm/yarn/pnpm |
| `venv`, `.venv`, `env` | Virtual environments | Python |
| `vendor` | Package dependencies | PHP/Go |
| `target` | Build output | Rust |
| `build`, `dist` | Build directories | Various |
| `__pycache__` | Python bytecode | Python |
| `.pytest_cache`, `.tox` | Test caches | Python |
| `.bundle` | Bundler dependencies | Ruby |

## 🛠️ Features

### Find Dependencies Script

**Features:**
- ✅ Recursive scanning of any directory
- ✅ First-level directory detection (excludes nested dependencies)
- ✅ Automatic 0B filtering (removes noise)
- ✅ Size-sorted output (largest first)
- ✅ Human-readable sizes (KB/MB/GB)
- ✅ Saves results to file for later use

**Example Output:**
```
📊 Results (first-level directories only, excluding 0B, sorted by size):

SIZE         PATH
----------------------------------------------------------------------------------------------------
2.6G         /Users/dev/Project1/node_modules
1.0G         /Users/dev/Project2/node_modules
867.7M       /Users/dev/Project3/.venv
503.1M       /Users/dev/Project4/node_modules

📈 Summary:
   Found 3,072 dependency directories
   Total size: 23.6G

✅ Results saved to: ./scripts/dependency-manager/dependency-scan-results.txt
```

### Remove Dependencies Script

**Deletion Modes:**

#### 1️⃣ Dry Run (Recommended First)
Preview what would be deleted without actually deleting anything.

#### 2️⃣ Delete by Type
Safely remove all directories of a specific type:
- All `node_modules`
- All Python environments (`venv`, `.venv`, `env`)
- All build/dist directories
- All `__pycache__` directories

#### 3️⃣ Interactive Mode
Review and confirm each directory individually before deletion.

#### 4️⃣ Delete All
Remove all scanned directories (requires typing "DELETE ALL" to confirm).

**Safety Features:**
- ✅ Visual summary before deletion
- ✅ Confirmation prompts (must type exact phrases)
- ✅ Backup list created for all deletions
- ✅ Progress counter during deletion
- ✅ Skips already-deleted directories

**Example Backup File:**
```
deleted-dependencies-20251219-112907.txt
/Users/dev/Project1/node_modules
/Users/dev/Project2/node_modules
/Users/dev/Project3/.venv
```

## 📖 Workflow Examples

### Example 1: Free Up Space Before Backup

```bash
# 1. Scan your Developer directory
./scripts/dependency-manager/find-dependencies.sh ~/Developer

# 2. Run the removal script
./scripts/dependency-manager/remove-dependencies.sh

# 3. Choose option 1 (Dry run) to preview
# 4. Choose option 2 (Delete all node_modules)
# 5. Confirm deletion

# Result: All node_modules deleted, 10GB+ freed
```

### Example 2: Clean Up Old Python Projects

```bash
# 1. Scan a specific directory
./scripts/dependency-manager/find-dependencies.sh ~/Developer/python-projects

# 2. Run the removal script
./scripts/dependency-manager/remove-dependencies.sh

# 3. Choose option 3 (Delete Python environments)
# 4. Confirm deletion

# Result: All venv/.venv/env directories deleted
```

### Example 3: Selective Cleanup

```bash
# 1. Scan your Developer directory
./scripts/dependency-manager/find-dependencies.sh ~/Developer

# 2. Run the removal script
./scripts/dependency-manager/remove-dependencies.sh

# 3. Choose option 6 (Interactive deletion)
# 4. Review each directory and decide (y/n/q)

# Result: Only selected directories deleted
```

## 🔄 Regenerating Dependencies

All dependency directories can be regenerated:

### JavaScript/Node.js
```bash
cd /path/to/project
npm install        # or: yarn install, pnpm install
```

### Python
```bash
cd /path/to/project
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### PHP (Composer)
```bash
cd /path/to/project
composer install
```

### Go
```bash
cd /path/to/project
go mod download
```

### Ruby
```bash
cd /path/to/project
bundle install
```

### Rust
```bash
cd /path/to/project
cargo build
```

## ⚙️ Advanced Usage

### Custom Search Path
```bash
# Scan a specific directory
./scripts/dependency-manager/find-dependencies.sh /path/to/custom/directory

# Scan multiple directories (run multiple times)
./scripts/dependency-manager/find-dependencies.sh ~/Developer
./scripts/dependency-manager/find-dependencies.sh ~/Projects
```

### Using Results File
```bash
# Extract just the paths
tail -n +10 dependency-scan-results.txt | grep -E '^[0-9]+\.' | awk '{print $2}'

# Count directories by type
grep 'node_modules$' dependency-scan-results.txt | wc -l

# Find largest directories
head -n 30 dependency-scan-results.txt
```

## 🔍 Technical Details

### First-Level Detection Algorithm

The script detects nested dependencies by checking if any dependency pattern appears in the parent path:

**Example:**
- `/Developer/Project/node_modules` → **First-level** ✅
  - Parent: `/Developer/Project` (no dependency pattern found)
- `/Developer/Project/node_modules/pkg/node_modules` → **Nested** ❌
  - Parent: `/Developer/Project/node_modules/pkg` (contains "node_modules")

### Performance

- **Scan time:** ~1-2 minutes for 100GB Developer directory
- **Memory usage:** Minimal (uses temporary files, not arrays)
- **Disk usage:** Results file typically < 500KB (with filtering)

### Safety Mechanisms

1. **Confirmation prompts** - Must type exact phrases to confirm
2. **Backup lists** - Timestamped files with all deleted paths
3. **Skip missing** - Handles directories that no longer exist
4. **Dry run mode** - Preview before deletion
5. **Progress tracking** - Shows current status during deletion

## 📝 Files in This Directory

| File | Description |
|------|-------------|
| `find-dependencies.sh` | Main scanning script |
| `remove-dependencies.sh` | Interactive deletion script |
| `dependency-scan-results.txt` | Output file from scans (generated) |
| `deleted-dependencies-*.txt` | Backup lists of deleted directories (generated) |
| `find-dependencies.sh.backup` | Backup of original script |
| `README.md` | This file |

## 🐛 Troubleshooting

### "Results file not found" Error
**Problem:** Running `remove-dependencies.sh` before scanning.

**Solution:**
```bash
# Run the scan first
./scripts/dependency-manager/find-dependencies.sh ~/Developer
```

### No Directories Found
**Problem:** Search path doesn't contain dependency directories.

**Solution:**
- Check the search path is correct
- Ensure you have dependency directories in that location
- Try scanning a parent directory

### Permission Denied
**Problem:** Script doesn't have execute permissions.

**Solution:**
```bash
chmod +x scripts/dependency-manager/*.sh
```

### Deleted Wrong Directory
**Problem:** Accidentally deleted an important directory.

**Solution:**
1. Check the backup list: `deleted-dependencies-*.txt`
2. Regenerate dependencies (see "Regenerating Dependencies" above)
3. Restore from Time Machine/backup if needed

## 💡 Tips & Best practices

1. **Always run dry run first** - Use option 1 to preview before deleting
2. **Keep project dependencies** - Only delete from inactive projects
3. **Regular cleanup** - Run monthly to free up space
4. **Before backups** - Clean dependencies before Time Machine/cloud backups
5. **Check disk space** - Use `df -h` to see space freed after deletion
6. **Backup important projects** - Ensure you have backups before bulk deletion
7. **Use type-specific deletion** - Safer than deleting all at once

## 🔗 Integration with Git

**Tip:** These directories are typically in `.gitignore` and safe to delete:
```gitignore
node_modules/
venv/
.venv/
env/
vendor/
target/
build/
dist/
__pycache__/
```

## 📊 Expected Space Savings

Based on typical project structures:

| Project Type | Avg Size per Project | Typical Savings (10 projects) |
|--------------|----------------------|------------------------------|
| Node.js/React | 200-500MB | 2-5GB |
| Python (with ML libs) | 500-1000MB | 5-10GB |
| Rust | 50-200MB | 0.5-2GB |
| Mixed development | Varies | 10-25GB |

## 🤝 Contributing

Found a bug or want to add support for more dependency types? Edit the scripts:

**Add new pattern:**
1. Edit `find-dependencies.sh`
2. Add pattern to `PATTERNS` array (line 25-38)
3. Test with a small directory first

**Example:**
```bash
PATTERNS=(
    "node_modules"
    "venv"
    ".venv"
    "vendor"
    # ... existing patterns
    "new_pattern"  # Add your new pattern here
)
```

## 📄 License

This tool is part of the claude-config-template project. Free to use and modify.

---

**Made with ❤️ for developers who want their disk space back!**
