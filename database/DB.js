const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgress',
  host: 'localhost',           // o la IP si es remoto
  database: 'smartrip',
  password: 'root',
  port: 5432,                  
});

module.exports = pool;
