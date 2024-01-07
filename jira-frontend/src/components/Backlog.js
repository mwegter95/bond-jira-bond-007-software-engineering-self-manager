// Backlog.js
import React from "react";
import { useTasks } from "../context/TaskContext.js";
import TaskList from "./TaskList.js";
import "./styles.css";


const Backlog = () => {
  const { state } = useTasks(); // Using useTasks hook here
  console.log("state here: ", state);

  // Check if tasks is undefined and initialize it as an empty array if it is
  const tasks = state.tasks || [];

  const backlogTasks = tasks.filter(
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
