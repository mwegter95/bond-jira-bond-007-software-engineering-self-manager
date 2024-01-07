#!/bin/bash

HTML_FILE="ui_design.html"

# Example of adding a new navigation bar under the header (macOS compatible version)
sed -i '' '/<!-- Additional main content can be added here -->/a \
<nav class="navigation-bar">New Navigation Bar</nav>' "$HTML_FILE"

echo "New sections added to the HTML file."
