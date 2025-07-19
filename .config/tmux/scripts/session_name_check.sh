#!/bin/bash

SESSION_NAME="$1"
HIGHLIGHT_ICON="" # The icon to display for default names

# Check if the session name is purely numeric (like '0', '1', '2')
# OR if it starts with 'tmux_session_' (like 'tmux_session_12345')
if [[ "$SESSION_NAME" =~ ^[0-9]+$ ]] || \
   [[ "$SESSION_NAME" =~ ^tmux_session_[0-9]+$ ]]; then
    echo "$HIGHLIGHT_ICON"
else
    echo "" # No icon if it's a custom name
fi
