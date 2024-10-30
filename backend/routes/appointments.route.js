
const express = require('express');
const router = express.Router();
const Appointment = require('../models/Appointment');

// Book a new appointment
router.post('/', async (req, res) => {
  const { doctor, patient, date, time, status } = req.body;
  try {
    const appointment = new Appointment({ doctor, patient, date, time, status });
    await appointment.save();
    res.status(201).json({ message: 'Appointment booked successfully', appointment });
  } catch (error) {
    res.status(500).json({ error: 'Failed to book appointment.' });
  }
});

// Get appointments for a user
router.get('/:userId', async (req, res) => {
  try {
    const appointments = await Appointment.find({
      $or: [{ doctor: req.params.userId }, { patient: req.params.userId }],
    });
    res.status(200).json(appointments);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch appointments.' });
  }
});

// Update an appointment
router.put('/:appointmentId', async (req, res) => {
  const { date, time, status } = req.body;
  try {
    const appointment = await Appointment.findByIdAndUpdate(
      req.params.appointmentId,
      { date, time, status },
      { new: true }
    );
    if (!appointment) return res.status(404).json({ error: 'Appointment not found.' });
    res.status(200).json({ message: 'Appointment updated successfully', appointment });
  } catch (error) {
    res.status(500).json({ error: 'Failed to update appointment.' });
  }
});

// Cancel an appointment
router.delete('/:appointmentId', async (req, res) => {
  try {
    const appointment = await Appointment.findByIdAndDelete(req.params.appointmentId);
    if (!appointment) return res.status(404).json({ error: 'Appointment not found.' });
    res.status(200).json({ message: 'Appointment canceled successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to cancel appointment.' });
  }
});

module.exports = router;
