import React from "react";
import { useTasks } from "../context/TaskContext.js";
import TaskList from "./TaskList.js";

const Backlog = () => {
  const { state } = useTasks(); // Using useTasks hook here
  const backlogTasks = state.tasks.filter(
    (task) => !task.sprintId || task.sprintId === "past" || task.sprintId
  );

  return (
    <div className="backlog">
      <h2>Backlog</h2>
      <TaskList tasks={backlogTasks} />
    </div>
  );
};

export default Backlog;
