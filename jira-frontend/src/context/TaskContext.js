// TaskContext.js
import { createContext, useContext, useReducer } from 'react';
import { useEffect } from "react";
import { default as axios } from "axios";


const fetchTasks = async () => {
  try {
    const response = await axios.get("http://localhost:3003/tasks");
    console.log("response.data ", response.data)
    return response.data; // Assuming the data is directly in the response
  } catch (error) {
    console.error("Error fetching tasks:", error);
    // Handle error appropriately
  }
};


export const TaskContext = createContext();

export const useTasks = () => {
  const context = useContext(TaskContext);
  if (!context) {
    throw new Error("useTasks must be used within a TaskProvider");
  }
  return context;
};

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
  const [state, dispatch] = useReducer(taskReducer, {
    tasks: [],
    loading: true,
    error: null,
  });

  useEffect(() => {
    const loadData = async () => {
      dispatch({ type: "TASKS_LOADING" });
      try {
        const tasks = await fetchTasks();
        console.log("tasks ",tasks)
        dispatch({ type: "TASKS_LOADED", payload: tasks });
      } catch (error) {
        dispatch({ type: "TASKS_ERROR", payload: error });
      }
    };

    loadData();
  }, []);

  return (
    <TaskContext.Provider value={{ state, dispatch }}>
      {children}
    </TaskContext.Provider>
  );
};

