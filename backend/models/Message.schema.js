const mongoose = require('mongoose');

const messageSchema = new mongoose.Schema({
  conversationId: {
    type: String,
    required: true,
  },
  participants: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
  ],
  lastMessage: {
    type: String,
  },
  lastMessageTime: {
    type: Date,
    default: Date.now,
  },
  unreadMessages: {
    type: Map, // Stores unread message count per participant
    of: Number,
    default: {},
  },
});

module.exports = mongoose.model('Message', messageSchema);
