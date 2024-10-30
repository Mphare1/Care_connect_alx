
const express = require('express');
const router = express.Router();
const Message = require('../models/Message');

// Initiate or retrieve a conversation
router.post('/initiate', async (req, res) => {
  const { participants } = req.body;
  try {
    let conversation = await Message.findOne({ participants: { $all: participants } });

    if (!conversation) {
      conversation = new Message({ participants });
      await conversation.save();
    }

    res.status(200).json(conversation);
  } catch (error) {
    res.status(500).json({ error: 'Failed to initiate conversation.' });
  }
});

// Get all conversations for a user
router.get('/:userId', async (req, res) => {
  try {
    const conversations = await Message.find({ participants: req.params.userId });
    res.status(200).json(conversations);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch conversations.' });
  }
});

module.exports = router;
