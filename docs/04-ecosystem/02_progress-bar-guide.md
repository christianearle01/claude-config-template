# Progress Bar Configuration

Quick guide to using and customizing the progress bar in scripts.

---

## Basic Usage

```bash
# Source the config
source scripts/progress-bar-config.sh

# Use the function
show_progress 3 5 "Installing dependencies"
# Output: Progress: [██████████░░░░░░░░░] 60% - Installing dependencies
```

---

## Customization (Environment Variables)

### Bar Appearance

- `PROGRESS_BAR_WIDTH=50` - Width in characters (default: 50)
- `PROGRESS_CHAR_FILLED='█'` - Character for filled portion (default: █)
- `PROGRESS_CHAR_EMPTY='░'` - Character for empty portion (default: ░)
- `PROGRESS_BAR_LABEL="Progress"` - Label text (default: "Progress")

### Colors

- `PROGRESS_COLOR_LABEL='\033[0;36m'` - Label color (default: cyan)
- `PROGRESS_COLOR_RESET='\033[0m'` - Reset code (default: reset)

---

## Example: Custom Progress Bar

```bash
# Set custom appearance
export PROGRESS_BAR_WIDTH=30
export PROGRESS_BAR_LABEL="Status"
export PROGRESS_CHAR_FILLED='▓'
export PROGRESS_CHAR_EMPTY='▒'

# Source config
source scripts/progress-bar-config.sh

# Use it
show_progress 2 4 "Processing"
# Output: Status: [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒] 50% - Processing
```

---

## Persistent Configuration

Add to your shell profile (`~/.bashrc` or `~/.zshrc`):

```bash
export PROGRESS_BAR_WIDTH=40
export PROGRESS_BAR_LABEL="⏳"
```

---

## See Also

- **Implementation:** `scripts/wizard-helpers.sh` (show_progress function)
- **Config script:** `scripts/progress-bar-config.sh` (defaults and sourcing)
- **Example usage:** All wizard scripts in `scripts/wizard-*.sh`
