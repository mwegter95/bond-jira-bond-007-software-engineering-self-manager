import React from "react";
import { render, screen } from "@testing-library/react";
import App from "./App";

test("renders Sprint Board and Backlog sections", () => {
  render(<App />);
  const sprintBoardElement = screen.getByText(/Sprint Board/i);
  const backlogElement = screen.getByText(/Backlog/i);
  expect(sprintBoardElement).toBeInTheDocument();
  expect(backlogElement).toBeInTheDocument();
});
