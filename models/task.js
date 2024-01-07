import mongoose from 'mongoose';
import Counter from './counter.js'; // Import the counter model


const taskSchema = new mongoose.Schema({
  issueId: { type: Number, index: true },
  title: String,
  description: String,
  status: String,
  priority: String,
  assignee: String,
  reporter: String,
  createdDate: { type: Date, default: Date.now },
  startDate: Date,
  dueDate: Date,
  labels: [String],
  comments: [{ body: String, date: Date }],
  attachments: [{ filename: String, url: String }],
  timeTracking: {
    estimate: Number,
    timeSpent: Number,
    timeRemaining: Number,
  },
});

taskSchema.pre("save", async function (next) {
  try {
    // Increment the counter and wait for the result
    const counter = await Counter.findByIdAndUpdate(
      { _id: "taskId" },
      { $inc: { seq: 1 } },
      { new: true, upsert: true }
    );

    // Set the issueId from the incremented counter
    this.issueId = counter.seq;
    next();
  } catch (error) {
    next(error);
  }
});


const Task = mongoose.model('Task', taskSchema);
export default Task;
