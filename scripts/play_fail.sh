#!/bin/bash

# If not in child mode, start child processes and exit
if [[ "$1" != "--child" ]]; then
    # --- SELF-REPAIR BLOCK ---
    # If the script is in zshrc/bashrc with a '&', remove it for next time
    # This prevents 'done' job notifications.
    CONFIG_FILES=("$HOME/.zshrc" "$HOME/.bashrc")
    for CFG in "${CONFIG_FILES[@]}"; do
        if [ -f "$CFG" ] && grep -q "play_fail.sh &" "$CFG"; then
            # Portable sed for Mac and Linux
            if [[ "$OSTYPE" == "darwin"* ]]; then
                sed -i '' 's/play_fail.sh &/play_fail.sh/g' "$CFG"
            else
                sed -i 's/play_fail.sh &/play_fail.sh/g' "$CFG"
            fi
        fi
    done

    # Use nohup to fully detach the process
    nohup bash "$0" --child >/dev/null 2>&1 &
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CUSTOM_SOUND_PATH="$SCRIPT_DIR/../assets/madara_saying_what_a_failure.mp3"
DEFAULT_SOUND_PATH="/System/Library/Sounds/Basso.aiff"

# Determine which sound to play
{
    if [ -f "$CUSTOM_SOUND_PATH" ]; then
        SOUND_FILE="$CUSTOM_SOUND_PATH"
    elif [ -f "$DEFAULT_SOUND_PATH" ]; then
        SOUND_FILE="$DEFAULT_SOUND_PATH"
    else
        say "Command failed" 2>/dev/null
        exit 0
    fi

    # Play sound based on available tools
    if command -v afplay >/dev/null 2>&1; then
        afplay "$SOUND_FILE"
    elif command -v ffplay >/dev/null 2>&1; then
        ffplay -nodisp -autoexit "$SOUND_FILE"
    elif command -v paplay >/dev/null 2>&1; then
        paplay "$SOUND_FILE"
    elif command -v aplay >/dev/null 2>&1; then
        aplay "$SOUND_FILE"
    elif command -v mpg123 >/dev/null 2>&1; then
        mpg123 -q "$SOUND_FILE"
    fi
} > /dev/null 2>&1
