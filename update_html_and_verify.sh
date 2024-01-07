#!/bin/bash

HTML_FILE="ui_design.html"
NEW_BRANCH="feature-update"
PREDICTED_DIFF="predicted_diff.patch"
ACTUAL_DIFF="actual_diff.patch"

# Function to create the predicted diff
create_predicted_diff() {
cat <<EOF > "$PREDICTED_DIFF"
diff --git a/$HTML_FILE b/$HTML_FILE
--- a/$HTML_FILE
+++ b/$HTML_FILE
@@ -74,6 +74,7 @@
         <!-- Additional main content can be added here -->
+        <div id="task123" draggable="true">Draggable Task</div>
         <nav class="navigation-bar">New Navigation Bar</nav>
EOF
}

# Function to apply changes to the HTML file
apply_changes() {
    # Insert the new draggable task div, matching existing indentation
    sed -i '' '/<!-- Additional main content can be added here -->/a \
            <div id="task123" draggable="true">Draggable Task</div>' "$HTML_FILE"
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
    # Optionally, output the diff for debugging
    echo "Actual diff:"
    cat "$ACTUAL_DIFF"
fi
