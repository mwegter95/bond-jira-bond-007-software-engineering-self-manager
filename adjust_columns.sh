#!/bin/bash

HTML_FILE="ui_design.html"
TEMP_FILE="ui_design_temp.html"
BACKUP_FILE="ui_design_backup.html"

# Backup original file
cp "$HTML_FILE" "$BACKUP_FILE"

# Duplicate the file for editing
cp "$HTML_FILE" "$TEMP_FILE"

# Edit the file to adjust column layout
sed -i '' '/.sprint-board {/a \
    display: flex;' "$TEMP_FILE"
sed -i '' '/.column {/a \
    flex: 1; /* Adjusting column flex property */' "$TEMP_FILE"

# Function to confirm the file edit
confirm_edit() {
    local sprint_board_check=$(grep -A 1 '.sprint-board {' "$TEMP_FILE" | grep 'display: flex;')
    local column_check=$(grep -A 1 '.column {' "$TEMP_FILE" | grep 'flex: 1;')
    [[ $sprint_board_check && $column_check ]]
    return $?
}

# Debugging function
debug_output() {
    echo "Expected '.sprint-board' to have 'display: flex;'"
    grep -A 2 '.sprint-board {' "$TEMP_FILE"
    echo "Expected '.column' to have 'flex: 1;'"
    grep -A 2 '.column {' "$TEMP_FILE"
}

# Process the confirmation and overwrite if correct
if confirm_edit; then
    mv "$TEMP_FILE" "$HTML_FILE"
    git add "$HTML_FILE"
    git commit -m "Adjusted column layout for side-by-side display"
    echo "File processed and committed successfully."
else
    echo "Edit confirmation failed. Original file is unchanged."
    debug_output
    # Restore original file
    mv "$BACKUP_FILE" "$HTML_FILE"
fi

# Cleanup
rm -f "$TEMP_FILE"
