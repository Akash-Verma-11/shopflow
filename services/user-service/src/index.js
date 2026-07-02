require('dotenv').config();
const express = require('express');
const client = require('prom-client');
const app = express();
const PORT = process.env.PORT || 3001;

const register = new client.Registry();
client.collectDefaultMetrics({ register });
const httpRequestCounter = new client.Counter({
  name: 'http_requests_total',
  help: 'Total HTTP requests',
  labelNames: ['method', 'route', 'status'],
  registers: [register],
});

app.use(express.json());
app.use((req, res, next) => {
  res.on('finish', () => {
    httpRequestCounter.inc({ method: req.method, route: req.path, status: res.statusCode });
  });
  next();
});

app.use('/api/users', require('./routes/users'));
app.get('/health', (req, res) => res.json({ status: 'ok', service: 'user-service', timestamp: new Date() }));
app.get('/ready', (req, res) => res.json({ status: 'ready' }));
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

app.listen(PORT, () => console.log(`User Service running on port ${PORT}`));
module.exports = app;
