#!/bin/bash

# Create directory structure
mkdir -p src/components src/context src/hooks src/utils

# Create the TaskContext file
cat > src/context/TaskContext.js <<EOF
import { createContext, useContext, useReducer } from 'react';

const TaskContext = createContext();

export const useTasks = () => useContext(TaskContext);

const taskReducer = (state, action) => {
    // Reducer logic based on action.type
    switch (action.type) {
        case 'TASKS_LOADING':
            return { ...state, loading: true };
        case 'TASKS_LOADED':
            return { ...state, tasks: action.payload, loading: false };
        case 'TASKS_ERROR':
            return { ...state, loading: false, error: action.payload };
        default:
            return state;
    }
};

export const TaskProvider = ({ children }) => {
    const [state, dispatch] = useReducer(taskReducer, { tasks: [], loading: true });

    // Value to be passed to context
    const value = { state, dispatch };

    return <TaskContext.Provider value={value}>{children}</TaskContext.Provider>;
};
EOF

# Create a custom hook for fetching tasks
cat > src/hooks/useFetchTasks.js <<EOF
import { useEffect } from 'react';
import axios from 'axios';
import { useTasks } from '../context/TaskContext';

const useFetchTasks = () => {
    const { dispatch } = useTasks();

    useEffect(() => {
        const fetchTasks = async () => {
            dispatch({ type: 'TASKS_LOADING' });
            try {
                const response = await axios.get('http://localhost:3000/tasks');
                dispatch({ type: 'TASKS_LOADED', payload: response.data });
            } catch (error) {
                dispatch({ type: 'TASKS_ERROR', payload: error });
            }
        };

        fetchTasks();
    }, [dispatch]);

    // Custom logic or additional functions
};

export default useFetchTasks;
EOF

# Create placeholder files for components
touch src/components/TaskList.js src/components/Task.js src/components/SprintBoard.js src/components/Backlog.js

echo "Frontend setup complete."
