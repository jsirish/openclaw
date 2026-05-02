#!/bin/bash
# Daily Backup Script for OpenClaw Workspace
# Backs up critical databases and configuration files

set -e

BACKUP_DIR="$HOME/.openclaw/backups"
DATE=$(date +%Y-%m-%d)
LOG_FILE="$HOME/.openclaw/logs/backup.log"

mkdir -p "$BACKUP_DIR/$DATE"

echo "[$(date)] Starting daily backup..." >> "$LOG_FILE"

# Backup memory databases
if [ -f "$HOME/.openclaw/memory/main.sqlite" ]; then
    cp "$HOME/.openclaw/memory/main.sqlite" "$BACKUP_DIR/$DATE/"
    echo "  ✅ Backed up main.sqlite" >> "$LOG_FILE"
fi

if [ -f "$HOME/.openclaw/memory/enhancements.db" ]; then
    cp "$HOME/.openclaw/memory/enhancements.db" "$BACKUP_DIR/$DATE/"
    echo "  ✅ Backed up enhancements.db" >> "$LOG_FILE"
fi

# Backup AutoPipe database
if [ -f "$HOME/.openclaw/workspace/autopipe/.autopipe/unified.db" ]; then
    cp "$HOME/.openclaw/workspace/autopipe/.autopipe/unified.db" "$BACKUP_DIR/$DATE/autopipe.db"
    echo "  ✅ Backed up autopipe unified.db" >> "$LOG_FILE"
fi

# Backup openclaw.json config
if [ -f "$HOME/.openclaw/openclaw.json" ]; then
    cp "$HOME/.openclaw/openclaw.json" "$BACKUP_DIR/$DATE/"
    echo "  ✅ Backed up openclaw.json" >> "$LOG_FILE"
fi

# Clean up old backups (keep last 30 days)
find "$BACKUP_DIR" -type d -mtime +30 -exec rm -rf {} + 2>/dev/null || true

echo "[$(date)] Backup complete: $BACKUP_DIR/$DATE" >> "$LOG_FILE"
echo "[$(date)] Backup complete"