#!/bin/bash


# Install Bootstrap for styling
npm install bootstrap

# Import Bootstrap CSS in index.js
sed -i "1s/^/import 'bootstrap\/dist\/css\/bootstrap.min.css';\n/" src/index.js

# Create TaskList component
cat > src/components/TaskList.js <<EOF
import React from 'react';
import Task from './Task';

const TaskList = ({ tasks }) => {
    return (
        <div className='task-list'>
            {tasks.map(task => <Task key={task.id} task={task} />)}
        </div>
    );
};

export default TaskList;
EOF

# Create Task component
cat > src/components/Task.js <<EOF
import React from 'react';

const Task = ({ task }) => {
    return (
        <div className='card'>
            <div className='card-body'>
                <h5 className='card-title'>{task.title}</h5>
                <p className='card-text'>{task.description}</p>
            </div>
        </div>
    );
};

export default Task;
EOF

# Create SprintBoard component
cat > src/components/SprintBoard.js <<EOF
import React, { useContext } from 'react';
import { TaskContext } from '../context/TaskContext';
import TaskList from './TaskList';

const SprintBoard = () => {
    const { tasks } = useContext(TaskContext);

    // Filter tasks for the Sprint Board
    const sprintTasks = tasks.filter(task => task.status === 'In Sprint');

    return (
        <div className='sprint-board'>
            <h2>Sprint Board</h2>
            <TaskList tasks={sprintTasks} />
        </div>
    );
};

export default SprintBoard;
EOF

# Create Backlog component
cat > src/components/Backlog.js <<EOF
import React, { useContext } from 'react';
import { TaskContext } from '../context/TaskContext';
import TaskList from './TaskList';

const Backlog = () => {
    const { tasks } = useContext(TaskContext);

    // Filter tasks for the Backlog
    const backlogTasks = tasks.filter(task => task.status === 'Backlog');

    return (
        <div className='backlog'>
            <h2>Backlog</h2>
            <TaskList tasks={backlogTasks} />
        </div>
    );
};

export default Backlog;
EOF

# Create CSS file for styling
cat > src/components/styles.css <<EOF
.task-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
}
.sprint-board, .backlog {
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    margin: 10px;
}
EOF

# Import CSS in App.js
sed -i "1s/^/import '.\/components\/styles.css';\n/" src/App.js

echo "Component files expanded with Bootstrap and custom CSS."
