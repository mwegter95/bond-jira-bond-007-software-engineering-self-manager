#!/bin/bash

# Update the test file for checking data rendering in components
cat > src/test/DataRender.test.js <<EOF
import React, { useReducer } from 'react';
import { render, screen } from '@testing-library/react';
import { TaskContext } from '../context/TaskContext'; // Import TaskContext
import SprintBoard from '../components/SprintBoard';
import Backlog from '../components/Backlog';

// Mock data
const mockTasks = [
    { id: 1, title: 'Task 1', sprintId: 'current' },
    { id: 2, title: 'Task 2', sprintId: 'backlog' }
];

// Custom implementation of a mock provider for testing
const MockTaskProvider = ({ children }) => {
    const mockDispatch = jest.fn(); // Mock dispatch function
    const initialState = { tasks: mockTasks, loading: false };
    const [state] = useReducer(() => initialState, initialState);

    return (
        <TaskContext.Provider value={{ state, dispatch: mockDispatch }}>
            {children}
        </TaskContext.Provider>
    );
};

describe('Data Rendering in Components', () => {
    test('SprintBoard renders tasks', () => {
        render(
            <MockTaskProvider>
                <SprintBoard />
            </MockTaskProvider>
        );
        expect(screen.getByText('Task 1')).toBeInTheDocument();
    });

    test('Backlog renders tasks', () => {
        render(
            <MockTaskProvider>
                <Backlog />
            </MockTaskProvider>
        );
        expect(screen.getByText('Task 2')).toBeInTheDocument();
    });
});
EOF

echo "Frontend data render test file updated."
