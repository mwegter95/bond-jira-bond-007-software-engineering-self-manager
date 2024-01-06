#!/bin/bash

# Assuming you're in the jira-frontend directory

# Update App.js to include new components and context
cat > src/App.js <<EOF
import React from 'react';
import { TaskProvider } from './context/TaskContext';
import SprintBoard from './components/SprintBoard';
import Backlog from './components/Backlog';
import './App.css'; // Assuming you have an App.css for general styling

const App = () => {
    return (
        <TaskProvider>
            <div className="app-container">
                <SprintBoard />
                <Backlog />
            </div>
        </TaskProvider>
    );
}

export default App;
EOF

echo "Frontend App.js updated with new features."
