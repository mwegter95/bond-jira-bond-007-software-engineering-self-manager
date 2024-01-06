import React from "react";
import { render, screen } from "@testing-library/react";
import { TaskProvider } from "../context/TaskContext";
import SprintBoard from "../components/SprintBoard";

describe("SprintBoard Component", () => {
  test("renders SprintBoard component", () => {
    render(
      <TaskProvider>
        <SprintBoard />
      </TaskProvider>
    );
    expect(screen.getByText(/Sprint Board/i)).toBeInTheDocument();
  });
});
