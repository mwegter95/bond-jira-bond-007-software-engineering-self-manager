import React from 'react';
import Task from './Task.js';

const TaskList = ({ tasks }) => {
    return (
        <div className='task-list'>
            {tasks.map(task => <Task key={task.id} task={task} />)}
        </div>
    );
};

export default TaskList;
