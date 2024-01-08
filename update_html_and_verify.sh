#!/bin/bash

HTML_FILE="ui_design.html"
NEW_BRANCH="feature-update"
PREDICTED_DIFF="predicted_diff.patch"
ACTUAL_DIFF="actual_diff.patch"

# Function to find the line number of a specific pattern
find_line_number() {
    grep -n '<div class="column">Done</div>' "$HTML_FILE" | cut -d : -f 1
}

# Function to create the predicted diff with the correct line number
create_predicted_diff() {
cat <<EOF > "$PREDICTED_DIFF"
diff --git a/$HTML_FILE b/$HTML_FILE
--- a/$HTML_FILE
+++ b/$HTML_FILE
@@ -79,6 +79,7 @@
                 <div class="column">Done</div>
+                <div id="task123" draggable="true" style="margin: 10px;">Draggable Task</div>
             </div>
EOF
}



# Function to apply changes to the HTML file
apply_changes() {
    # Find the line number for insertion
    local line_number=$(find_line_number)

    # Correctly insert the new line with proper indentation for macOS
    sed -i '' $line_number'{
        n
        a\
        \            <div id="task123" draggable="true" style="margin: 10px;">Draggable Task</div>
    }' "$HTML_FILE"
}






# Function to check git diff
check_git_diff() {
    git diff "$HTML_FILE" > "$ACTUAL_DIFF"
    diff "$PREDICTED_DIFF" "$ACTUAL_DIFF" > /dev/null
}

# Function to create a new branch and commit changes
commit_changes() {
    # Check if the branch exists and create it if not
    if ! git rev-parse --verify "$NEW_BRANCH" > /dev/null 2>&1; then
        git checkout -b "$NEW_BRANCH"
    else
        git checkout "$NEW_BRANCH"
    fi

    git add "$HTML_FILE"
    git commit -m "Added draggable task to main content"
}

# Main execution
create_predicted_diff
apply_changes
if check_git_diff; then
    echo "Changes match the predicted difference. Committing to a new branch."
    commit_changes
else
    echo "Changes do not match the predicted difference. Aborting commit."
    echo "Displaying diff for debugging:"
    # Use colordiff for better readability if available
    if command -v colordiff > /dev/null; then
        colordiff "$PREDICTED_DIFF" "$ACTUAL_DIFF"
    else
        diff "$PREDICTED_DIFF" "$ACTUAL_DIFF"
    fi

fi