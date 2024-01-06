import React from 'react';
import { TaskProvider } from './context/TaskContext.js';
import SprintBoard from './components/SprintBoard.js';
import Backlog from './components/Backlog.js';
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
