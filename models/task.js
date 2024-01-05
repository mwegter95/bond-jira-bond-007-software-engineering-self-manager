const mongoose = require('mongoose');

const taskSchema = new mongoose.Schema({
    issueId: { type: String, required: true },
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
        timeRemaining: Number
    }
});

const Task = mongoose.model('Task', taskSchema);
module.exports = Task;
