const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    enum: ['doctor', 'patient'],
    required: true,
  },
  city: {
    type: String,
    required: function() { return this.role === 'doctor'; }, // Only required for doctors
  },
  rates: {
    type: Number,
    required: function() { return this.role === 'doctor'; }, // Only required for doctors
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('User', userSchema);
