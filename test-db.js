const { Pool } = require('pg');

// IMPORTANTE: Pega aquí tu DATABASE_URL, la misma que tienes en Render.
const connectionString = 'postgresql://postgres.aavmxjmkiaevxyiyztsc:bajaditas_angelo_2025@aws-1-us-east-2.pooler.supabase.com:6543/postgres';

if (connectionString.includes('PASTE_YOUR_URL')) {
  console.error('Error: Reemplaza el texto con tu DATABASE_URL de Supabase.');
  process.exit(1);
}

console.log('Intentando conectar a la base de datos...');

const pool = new Pool({
  connectionString: connectionString,
  ssl: {
    rejectUnauthorized: false
  }
});

pool.connect((err, client, release) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
    process.exit(1);
  }
  console.log('¡Conexión a la base de datos exitosa!');
  client.query('SELECT NOW()', (err, result) => {
    release();
    if (err) {
      console.error('Error durante la consulta:', err.stack);
    } else {
      console.log('Consulta exitosa. Hora actual de la BD:', result.rows[0].now);
    }
    pool.end();
  });
});