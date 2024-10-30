// server.js
const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');

dotenv.config();

const app = express();

// Import routes
const userRoutes = require('./routes/users');
const appointmentRoutes = require('./routes/appointments');

// Middleware to parse JSON
app.use(express.json());

// Connect to MongoDB
mongoose.connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
.then(() => console.log("Connected to MongoDB"))
.catch((err) => console.log("Failed to connect to MongoDB", err));

// Basic route to test the server
app.get('/', (req, res) => {
    res.send("Welcome to the Care Connect API");
});

// Use routes
app.use('/users', userRoutes);
app.use('/appointments', appointmentRoutes);
app.use('/messages', messageRoutes);
app.use('/reviews', reviewRoutes);

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
