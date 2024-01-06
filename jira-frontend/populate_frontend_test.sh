#!/bin/bash

# Assuming you're in the jira-frontend directory

# Populate SprintBoard.test.js with test cases
cat > src/test/SprintBoard.test.js <<EOF
import React from 'react';
import { render, screen } from '@testing-library/react';
import SprintBoard from '../components/SprintBoard';

describe('SprintBoard Component', () => {
    test('renders SprintBoard component', () => {
        render(<SprintBoard />);
        expect(screen.getByText(/Sprint Board/i)).toBeInTheDocument();
    });

    // Add more tests as needed
});
EOF

echo "Frontend test file populated."
