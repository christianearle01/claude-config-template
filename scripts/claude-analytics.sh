#!/bin/bash

################################################################################
# Claude Code Template Analytics (Privacy-First, Opt-In)
# Version: 2.1.0
# Purpose: Track usage metrics to improve template (opt-in only, local storage)
# Storage: ~/.claude/analytics/ (never leaves your machine)
################################################################################

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
ANALYTICS_DIR="$HOME/.claude/analytics"
ANALYTICS_ENABLED_FILE="$HOME/.claude/analytics-enabled"
ANALYTICS_DATA_FILE="$ANALYTICS_DIR/usage.json"
ANALYTICS_SESSIONS_FILE="$ANALYTICS_DIR/sessions.jsonl"

################################################################################
# Privacy Notice
################################################################################

show_privacy_notice() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                            ║${NC}"
    echo -e "${CYAN}║         📊 Claude Template Analytics (Opt-In)             ║${NC}"
    echo -e "${CYAN}║                                                            ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Privacy-First Analytics${NC}"
    echo ""
    echo "We'd like to collect anonymous usage data to improve this template."
    echo ""
    echo -e "${GREEN}What we collect:${NC}"
    echo "  • Setup completion rates (did wizard finish?)"
    echo "  • Time to complete setup (how long?)"
    echo "  • Persona distribution (which profile?)"
    echo "  • Feature usage (which wizards used?)"
    echo ""
    echo -e "${GREEN}What we DON'T collect:${NC}"
    echo "  ❌ Personal information (name, email, etc.)"
    echo "  ❌ Project code or content"
    echo "  ❌ File paths or directory names"
    echo "  ❌ API keys or sensitive data"
    echo "  ❌ IP addresses or device IDs"
    echo ""
    echo -e "${BLUE}Data Storage:${NC}"
    echo "  • Stored locally: $ANALYTICS_DIR"
    echo "  • Never sent to external servers"
    echo "  • You can view/delete anytime"
    echo ""
    echo -e "${CYAN}Benefits:${NC}"
    echo "  • Helps us improve the template"
    echo "  • Identifies pain points in setup"
    echo "  • Validates new features work well"
    echo ""
}

################################################################################
# Enable/Disable Analytics
################################################################################

enable_analytics() {
    show_privacy_notice

    echo -n -e "${YELLOW}Enable analytics? (y/n): ${NC}"
    read -r response

    if [[ $response =~ ^[Yy]$ ]]; then
        mkdir -p "$ANALYTICS_DIR"
        touch "$ANALYTICS_ENABLED_FILE"

        # Initialize analytics file
        if [ ! -f "$ANALYTICS_DATA_FILE" ]; then
            cat > "$ANALYTICS_DATA_FILE" << 'EOF'
{
  "version": "2.1.0",
  "enabled_at": "",
  "sessions": {
    "total": 0,
    "completed": 0,
    "abandoned": 0
  },
  "personas": {
    "first-time": 0,
    "quick-setup": 0,
    "advanced": 0,
    "team-lead": 0,
    "returning": 0
  },
  "features_used": {
    "wizard": 0,
    "visual_guides": 0,
    "quick_reference": 0,
    "update_check": 0
  },
  "performance": {
    "avg_setup_time_minutes": 0,
    "token_savings_avg_percent": 0
  },
  "satisfaction": {
    "ratings": [],
    "average": 0
  }
}
EOF
            # Add timestamp
            if command -v jq &> /dev/null; then
                jq --arg date "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
                   '.enabled_at = $date' \
                   "$ANALYTICS_DATA_FILE" > "$ANALYTICS_DATA_FILE.tmp" && \
                   mv "$ANALYTICS_DATA_FILE.tmp" "$ANALYTICS_DATA_FILE"
            fi
        fi

        echo ""
        echo -e "${GREEN}✅ Analytics enabled!${NC}"
        echo ""
        echo "Thank you for helping improve this template!"
        echo ""
        echo -e "${CYAN}Manage analytics:${NC}"
        echo "  View data: ./scripts/claude-analytics.sh --show"
        echo "  Disable:   ./scripts/claude-analytics.sh --disable"
        echo "  Delete:    ./scripts/claude-analytics.sh --delete"
        echo ""
    else
        echo ""
        echo -e "${CYAN}Analytics not enabled.${NC}"
        echo "You can enable anytime with: ./scripts/claude-analytics.sh --enable"
        echo ""
    fi
}

disable_analytics() {
    if [ -f "$ANALYTICS_ENABLED_FILE" ]; then
        rm "$ANALYTICS_ENABLED_FILE"
        echo -e "${GREEN}✅ Analytics disabled${NC}"
        echo ""
        echo "Your data is still stored locally at: $ANALYTICS_DIR"
        echo "To delete it: ./scripts/claude-analytics.sh --delete"
        echo ""
    else
        echo -e "${YELLOW}Analytics already disabled${NC}"
    fi
}

delete_analytics_data() {
    echo -e "${YELLOW}⚠️  This will permanently delete all analytics data.${NC}"
    echo ""
    echo -n "Are you sure? (y/n): "
    read -r response

    if [[ $response =~ ^[Yy]$ ]]; then
        rm -rf "$ANALYTICS_DIR"
        rm -f "$ANALYTICS_ENABLED_FILE"
        echo ""
        echo -e "${GREEN}✅ All analytics data deleted${NC}"
        echo ""
    else
        echo ""
        echo "Deletion cancelled."
        echo ""
    fi
}

################################################################################
# Check if Analytics is Enabled
################################################################################

is_analytics_enabled() {
    [ -f "$ANALYTICS_ENABLED_FILE" ]
}

################################################################################
# Track Event
################################################################################

track_event() {
    local event_type=$1
    local event_data=$2

    # Only track if enabled
    if ! is_analytics_enabled; then
        return 0
    fi

    # Ensure analytics directory exists
    mkdir -p "$ANALYTICS_DIR"

    # Create session entry
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    local session_id=$(date +%s%N | md5sum | cut -c1-8)

    cat >> "$ANALYTICS_SESSIONS_FILE" << EOF
{"timestamp":"$timestamp","session_id":"$session_id","event":"$event_type","data":$event_data}
EOF

    # Update summary statistics
    if command -v jq &> /dev/null && [ -f "$ANALYTICS_DATA_FILE" ]; then
        # Increment counters based on event type
        case $event_type in
            "wizard_started")
                jq '.sessions.total += 1' "$ANALYTICS_DATA_FILE" > "$ANALYTICS_DATA_FILE.tmp" && \
                mv "$ANALYTICS_DATA_FILE.tmp" "$ANALYTICS_DATA_FILE"
                ;;
            "wizard_completed")
                jq '.sessions.completed += 1' "$ANALYTICS_DATA_FILE" > "$ANALYTICS_DATA_FILE.tmp" && \
                mv "$ANALYTICS_DATA_FILE.tmp" "$ANALYTICS_DATA_FILE"
                ;;
            "wizard_abandoned")
                jq '.sessions.abandoned += 1' "$ANALYTICS_DATA_FILE" > "$ANALYTICS_DATA_FILE.tmp" && \
                mv "$ANALYTICS_DATA_FILE.tmp" "$ANALYTICS_DATA_FILE"
                ;;
        esac
    fi
}

################################################################################
# Track Wizard Session
################################################################################

track_wizard_start() {
    local persona=$1
    track_event "wizard_started" "{\"persona\":\"$persona\"}"

    # Increment persona counter
    if command -v jq &> /dev/null && [ -f "$ANALYTICS_DATA_FILE" ]; then
        jq ".personas[\"$persona\"] += 1" "$ANALYTICS_DATA_FILE" > "$ANALYTICS_DATA_FILE.tmp" && \
        mv "$ANALYTICS_DATA_FILE.tmp" "$ANALYTICS_DATA_FILE"
    fi
}

track_wizard_complete() {
    local persona=$1
    local duration_minutes=$2
    track_event "wizard_completed" "{\"persona\":\"$persona\",\"duration_minutes\":$duration_minutes}"
}

track_wizard_abandoned() {
    local persona=$1
    local step=$2
    track_event "wizard_abandoned" "{\"persona\":\"$persona\",\"step\":\"$step\"}"
}

track_feature_usage() {
    local feature=$1
    track_event "feature_used" "{\"feature\":\"$feature\"}"

    # Increment feature counter
    if command -v jq &> /dev/null && [ -f "$ANALYTICS_DATA_FILE" ]; then
        jq ".features_used[\"$feature\"] += 1" "$ANALYTICS_DATA_FILE" > "$ANALYTICS_DATA_FILE.tmp" && \
        mv "$ANALYTICS_DATA_FILE.tmp" "$ANALYTICS_DATA_FILE"
    fi
}

################################################################################
# Show Analytics Data
################################################################################

show_analytics() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                            ║${NC}"
    echo -e "${CYAN}║         📊 Your Analytics Data                            ║${NC}"
    echo -e "${CYAN}║                                                            ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    if ! is_analytics_enabled; then
        echo -e "${YELLOW}Analytics is disabled.${NC}"
        echo ""
        echo "Enable with: ./scripts/claude-analytics.sh --enable"
        echo ""
        return 0
    fi

    if [ ! -f "$ANALYTICS_DATA_FILE" ]; then
        echo -e "${YELLOW}No analytics data yet.${NC}"
        return 0
    fi

    # Pretty print JSON data
    if command -v jq &> /dev/null; then
        echo -e "${CYAN}Summary Statistics:${NC}"
        echo ""

        # Sessions
        TOTAL=$(jq -r '.sessions.total' "$ANALYTICS_DATA_FILE")
        COMPLETED=$(jq -r '.sessions.completed' "$ANALYTICS_DATA_FILE")
        ABANDONED=$(jq -r '.sessions.abandoned' "$ANALYTICS_DATA_FILE")

        echo -e "${BLUE}Sessions:${NC}"
        echo "  Total:     $TOTAL"
        echo "  Completed: $COMPLETED"
        echo "  Abandoned: $ABANDONED"

        if [ "$TOTAL" -gt 0 ]; then
            COMPLETION_RATE=$(echo "scale=2; $COMPLETED * 100 / $TOTAL" | bc)
            echo "  Completion Rate: ${COMPLETION_RATE}%"
        fi
        echo ""

        # Personas
        echo -e "${BLUE}Persona Usage:${NC}"
        jq -r '.personas | to_entries[] | "  \(.key): \(.value)"' "$ANALYTICS_DATA_FILE"
        echo ""

        # Features
        echo -e "${BLUE}Features Used:${NC}"
        jq -r '.features_used | to_entries[] | "  \(.key): \(.value)"' "$ANALYTICS_DATA_FILE"
        echo ""

        # Performance
        AVG_TIME=$(jq -r '.performance.avg_setup_time_minutes' "$ANALYTICS_DATA_FILE")
        if [ "$AVG_TIME" != "0" ]; then
            echo -e "${BLUE}Performance:${NC}"
            echo "  Avg Setup Time: ${AVG_TIME} minutes"
            echo ""
        fi
    else
        # Fallback without jq
        cat "$ANALYTICS_DATA_FILE"
    fi

    echo -e "${CYAN}Data Location:${NC} $ANALYTICS_DIR"
    echo ""
    echo -e "${YELLOW}Privacy Note:${NC} This data never leaves your machine."
    echo ""
}

################################################################################
# Export Analytics
################################################################################

export_analytics() {
    local export_file="${1:-analytics-export-$(date +%Y%m%d).json}"

    if [ ! -f "$ANALYTICS_DATA_FILE" ]; then
        echo -e "${YELLOW}No analytics data to export.${NC}"
        return 1
    fi

    cp "$ANALYTICS_DATA_FILE" "$export_file"
    echo -e "${GREEN}✅ Analytics exported to: $export_file${NC}"
    echo ""
    echo "You can share this file with the template maintainers"
    echo "to help improve the template (it contains no personal data)."
    echo ""
}

################################################################################
# Main
################################################################################

case "${1:-}" in
    --enable|-e)
        enable_analytics
        ;;
    --disable|-d)
        disable_analytics
        ;;
    --delete)
        delete_analytics_data
        ;;
    --show|-s)
        show_analytics
        ;;
    --export)
        export_analytics "$2"
        ;;
    --track)
        # Internal use by wizards
        track_event "$2" "$3"
        ;;
    --help|-h)
        echo "Usage: claude-analytics.sh [OPTION]"
        echo ""
        echo "Options:"
        echo "  --enable, -e       Enable analytics tracking"
        echo "  --disable, -d      Disable analytics tracking"
        echo "  --delete           Delete all analytics data"
        echo "  --show, -s         Show your analytics data"
        echo "  --export [file]    Export analytics to file"
        echo "  --help, -h         Show this help message"
        echo ""
        echo "Privacy:"
        echo "  • All data stored locally in ~/.claude/analytics/"
        echo "  • Never sent to external servers"
        echo "  • Opt-in only (disabled by default)"
        echo "  • Delete anytime with --delete"
        echo ""
        ;;
    *)
        # Interactive mode
        echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║                                                            ║${NC}"
        echo -e "${CYAN}║         📊 Analytics Manager                              ║${NC}"
        echo -e "${CYAN}║                                                            ║${NC}"
        echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
        echo ""

        if is_analytics_enabled; then
            echo -e "${GREEN}Status: Enabled${NC}"
        else
            echo -e "${YELLOW}Status: Disabled${NC}"
        fi
        echo ""

        echo "What would you like to do?"
        echo ""
        echo "1) Enable analytics"
        echo "2) Disable analytics"
        echo "3) Show my data"
        echo "4) Export data"
        echo "5) Delete all data"
        echo "6) Exit"
        echo ""

        read -p "Select option (1-6): " OPTION

        case $OPTION in
            1) enable_analytics ;;
            2) disable_analytics ;;
            3) show_analytics ;;
            4)
                read -p "Export filename (default: analytics-export-$(date +%Y%m%d).json): " filename
                export_analytics "$filename"
                ;;
            5) delete_analytics_data ;;
            6) exit 0 ;;
            *) echo "Invalid option" ;;
        esac
        ;;
esac
