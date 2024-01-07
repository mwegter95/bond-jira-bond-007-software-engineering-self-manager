// SprintBoard.js
import React from "react";
import { useTasks } from "../context/TaskContext.js";
import TaskList from "./TaskList.js";

const SprintBoard = () => {
  const { state } = useTasks(); // Using useTasks hook here
  console.log("state in SprintBoard: ", state);

  // Check if tasks is undefined and initialize it as an empty array if it is
  const tasks = state.tasks || [];

  const sprintTasks = tasks.filter((task) => task.sprintId === "current");

  return (
    <div className="sprint-board">
      <h2>Sprint Board</h2>
      <TaskList tasks={sprintTasks} />
    </div>
  );
};

export default SprintBoard;
