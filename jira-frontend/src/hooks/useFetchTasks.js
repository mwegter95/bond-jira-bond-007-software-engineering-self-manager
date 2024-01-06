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
