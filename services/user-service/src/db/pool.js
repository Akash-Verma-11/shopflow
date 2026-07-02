const { Pool } = require('pg');
const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'shopflowdb',
  user: process.env.DB_USER || 'shopflow',
  password: process.env.DB_PASS || 'secret123',
  max: 10,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});
pool.connect((err, client, release) => {
  if (err) console.error('DB connection failed:', err.message);
  else { console.log('DB connected successfully'); release(); }
});
module.exports = pool;
