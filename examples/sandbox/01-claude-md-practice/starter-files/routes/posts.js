const express = require('express');
const router = express.Router();

router.get('/', async (req, res) => {
  res.json({ posts: [] });
});

router.post('/', async (req, res) => {
  res.json({ post: req.body });
});

module.exports = router;
