const express = require('express');
const router = express.Router();
const Review = require('../models/Review');

// Submit a review
router.post('/', async (req, res) => {
  const { doctor, patient, rating, reviewText } = req.body;
  try {
    const review = new Review({ doctor, patient, rating, reviewText });
    await review.save();
    res.status(201).json(review);
  } catch (error) {
    res.status(500).json({ error: 'Failed to submit review.' });
  }
});

// Get all reviews for a doctor
router.get('/:doctorId', async (req, res) => {
  try {
    const reviews = await Review.find({ doctor: req.params.doctorId });
    res.status(200).json(reviews);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch reviews.' });
  }
});

module.exports = router;
