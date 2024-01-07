#!/bin/bash

HTML_FILE="ui_design.html"
EXPECTED_CONTENT=$(cat <<-END
    <div class="main-content">
        <!-- Additional main content can be added here -->            
        <nav class="navigation-bar">New Navigation Bar</nav>            
        <div class="sprint-board">
            <div class="column">To Do</div>
            <div class="column">Accepted</div>
            <div class="column">In Progress</div>
            <div class="column">Done</div>
        </div>
        <div class="backlog">Backlog</div>
    </div>
END
)
NEW_SCRIPT_NAME="update_html_format_corrected.sh"

# Function to check the whole file contents for a specific block of text
check_full_content() {
    # Using diff to compare the expected content with the actual content in the file
    diff <(echo "$EXPECTED_CONTENT") <(grep -A 10 "<div class=\"main-content\">" "$HTML_FILE") > /dev/null
}

# Function to generate a corrected script for formatting
generate_format_corrected_script() {
    echo "#!/bin/bash" > "$NEW_SCRIPT_NAME"
    echo "" >> "$NEW_SCRIPT_NAME"
    echo "HTML_FILE=\"$HTML_FILE\"" >> "$NEW_SCRIPT_NAME"
    echo "EXPECTED_CONTENT=\"$EXPECTED_CONTENT\"" >> "$NEW_SCRIPT_NAME"
    echo "echo \"\${EXPECTED_CONTENT}\" > temp_content" >> "$NEW_SCRIPT_NAME"
    echo "sed -i '' '/<div class=\"main-content\">/,/<\/div>/c\\' \"\$HTML_FILE\"" >> "$NEW_SCRIPT_NAME"
    echo "cat temp_content >> \"\$HTML_FILE\"" >> "$NEW_SCRIPT_NAME"
    echo "rm temp_content" >> "$NEW_SCRIPT_NAME"
    echo "" >> "$NEW_SCRIPT_NAME"
    echo "echo \"Format corrections applied to the HTML file.\"" >> "$NEW_SCRIPT_NAME"
    chmod +x "$NEW_SCRIPT_NAME"
}

# Apply initial changes
sed -i '' "/<!-- Additional main content can be added here -->/a \\
<nav class=\"navigation-bar\">New Navigation Bar</nav>" "$HTML_FILE"

# Check if the entire file content is as expected
if ! check_full_content; then
    echo "Update didn't match the expected format. Generating a corrected script."
    generate_format_corrected_script
else
    echo "Update successful. HTML file content and format are as expected."
fi
