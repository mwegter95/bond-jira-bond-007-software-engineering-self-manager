#!/bin/bash

# Install necessary Node.js packages
npm install express mongoose body-parser

# Create a directory for models
mkdir models
# Create a Task model
cat > models/task.js <<EOF
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
EOF

# Create the main server file
cat > index.js <<EOF
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const Task = require('./models/task');

const app = express();
const port = 3000;

// Connect to MongoDB
mongoose.connect('mongodb://localhost/jiraSESM', { useNewUrlParser: true, useUnifiedTopology: true });

// Middleware
app.use(bodyParser.json());

// CRUD operations
app.post('/tasks', async (req, res) => {
    const task = new Task(req.body);
    try {
        await task.save();
        res.status(201).send(task);
    } catch (e) {
        res.status(400).send(e);
    }
});

app.get('/tasks', async (req, res) => {
    try {
        const tasks = await Task.find({});
        res.send(tasks);
    } catch (e) {
        res.status(500).send();
    }
});

app.get('/tasks/:id', async (req, res) => {
    const _id = req.params.id;
    try {
        const task = await Task.findById(_id);
        if (!task) {
            return res.status(404).send();
        }
        res.send(task);
    } catch (e) {
        res.status(500).send();
    }
});

app.patch('/tasks/:id', async (req, res) => {
    const updates = Object.keys(req.body);
    try {
        const task = await Task.findById(req.params.id);
        if (!task) {
            return res.status(404).send();
        }
        updates.forEach((update) => task[update] = req.body[update]);
        await task.save();
        res.send(task);
    } catch (e) {
        res.status(400).send(e);
    }
});

app.delete('/tasks/:id', async (req, res) => {
    try {
        const task = await Task.findByIdAndDelete(req.params.id);
        if (!task) {
            return res.status(404).send();
        }
        res.send(task);
    } catch (e) {
        res.status(500).send();
    }
});

app.listen(port, () => {
    console.log(\`Server running on port \${port}\`);
});
EOF

echo "Backend setup complete. Run 'node index.js' to start the server."
