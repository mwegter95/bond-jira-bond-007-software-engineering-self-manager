#!/bin/bash

# Navigate to the backend test directory from jira-frontend
cd ./test

# Populate sprintModel.test.js with test cases
cat > sprintModel.test.js <<EOF
const expect = require('chai').expect;
const Sprint = require('../models/sprint'); // Adjust path as necessary

describe('Sprint Model', function() {
    it('should auto-increment the sprint ID', async function() {
        // Create a new sprint
        const sprint = new Sprint({});
        await sprint.save();

        // Check if the sprint name follows the pattern 'jiraSESM-X'
        expect(sprint.name).to.match(/jiraSESM-\\d+/);
    });

    // Add more tests as needed
});
EOF

echo "Backend test file populated."
