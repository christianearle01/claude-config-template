const express = require('express');
const router = express.Router();
const twilioService = require('../services/twilio');

router.get('/', async (req, res) => {
  // Get all users
  res.json({ users: [] });
});

router.post('/', async (req, res) => {
  // Create user and send SMS welcome
  await twilioService.sendSMS(req.body.phone, 'Welcome!');
  res.json({ user: req.body });
});

module.exports = router;
