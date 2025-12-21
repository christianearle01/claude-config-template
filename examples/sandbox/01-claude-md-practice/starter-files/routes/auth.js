const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');

router.post('/login', async (req, res) => {
  const token = jwt.sign({ userId: 1 }, 'secret');
  res.json({ token });
});

module.exports = router;
