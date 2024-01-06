import React from "react";
import { useTasks } from "../context/TaskContext.js";
import TaskList from "./TaskList.js";

const SprintBoard = () => {
  const { state } = useTasks(); // Using useTasks hook here
  const sprintTasks = state.tasks.filter((task) => task.sprintId === "current");

  return (
    <div className="sprint-board">
      <h2>Sprint Board</h2>
      <TaskList tasks={sprintTasks} />
    </div>
  );
};

export default SprintBoard;
