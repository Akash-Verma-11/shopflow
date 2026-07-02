const express = require('express');
const axios = require('axios');
const pool = require('../db/pool');
const router = express.Router();

router.post('/', async (req, res) => {
  const { userId, productId, quantity } = req.body;
  if (!userId || !productId || !quantity) return res.status(400).json({ error: 'userId, productId, quantity required' });
  try {
    const productUrl = `${process.env.PRODUCT_SERVICE_URL}/api/products/${productId}`;
    const productRes = await axios.get(productUrl);
    const product = productRes.data;
    if (product.stock < quantity) return res.status(400).json({ error: 'Insufficient stock' });
    const totalPrice = product.price * quantity;
    const result = await pool.query(
      `INSERT INTO orders (user_id, product_id, quantity, total_price, status) VALUES ($1, $2, $3, $4, 'pending') RETURNING *`,
      [userId, productId, quantity, totalPrice]
    );
    res.status(201).json({ message: 'Order created', order: result.rows[0] });
  } catch (err) {
    console.error('Order creation error:', err.message);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.get('/:userId', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM orders WHERE user_id = $1 ORDER BY created_at DESC', [req.params.userId]);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: 'Internal server error' });
  }
});
module.exports = router;
