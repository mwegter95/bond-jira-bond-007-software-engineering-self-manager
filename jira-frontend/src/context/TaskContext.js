import { createContext, useContext, useReducer } from 'react';
import axios from "axios";

const fetchTasks = async () => {
  try {
    const response = await axios.get("/api/tasks");
    return response.data; // Assuming the data is directly in the response
  } catch (error) {
    console.error("Error fetching tasks:", error);
    // Handle error appropriately
  }
};

export const TaskContext = createContext();

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

