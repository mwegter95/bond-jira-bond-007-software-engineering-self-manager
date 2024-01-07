#!/bin/bash

HTML_FILE="ui_design.html"
EXPECTED_CONTENT="    <div class="main-content">
        <!-- Additional main content can be added here -->            
        <nav class="navigation-bar">New Navigation Bar</nav>            
        <div class="sprint-board">
            <div class="column">To Do</div>
            <div class="column">Accepted</div>
            <div class="column">In Progress</div>
            <div class="column">Done</div>
        </div>
        <div class="backlog">Backlog</div>
    </div>"
echo "${EXPECTED_CONTENT}" > temp_content
sed -i '' '/<div class="main-content">/,/<\/div>/c\' "$HTML_FILE"
cat temp_content >> "$HTML_FILE"
rm temp_content

echo "Format corrections applied to the HTML file."
