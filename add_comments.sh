#!/bin/bash

# File to be modified
HTML_FILE="ui_design.html"

# Adding comments for future expansions (macOS compatible version)
sed -i '' '/<meta name="viewport"/a \
<!-- Additional meta tags can be added here -->' "$HTML_FILE"

sed -i '' '/.container {/a \
/* Additional global styles can be added here */' "$HTML_FILE"

sed -i '' '/.column {/a \
/* Additional component styles can be added here */' "$HTML_FILE"

sed -i '' '/<div class="main-content">/a \
<!-- Additional main content can be added here -->' "$HTML_FILE"

sed -i '' '/<footer>/i \
<!-- Additional elements can be added to the body here -->' "$HTML_FILE"

echo "Comments added for future expansions."
