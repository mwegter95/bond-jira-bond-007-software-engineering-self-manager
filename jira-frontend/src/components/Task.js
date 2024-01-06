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
