const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres.tqyfxzfddptecafavjey',
  host: 'aws-0-sa-east-1.pooler.supabase.com',           
  database: 'smartrip',
  password: 'SmarTrip_2025',
  port: 5432,                  
});

module.exports = pool;
