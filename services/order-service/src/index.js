require('dotenv').config();
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3002;
app.use(express.json());
app.use('/api/orders', require('./routes/orders'));
app.get('/health', (req, res) => res.json({ status: 'ok', service: 'order-service' }));
app.get('/ready', (req, res) => res.json({ status: 'ready' }));
app.listen(PORT, () => console.log(`Order Service running on port ${PORT}`));
