require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const ngrok = require('@ngrok/ngrok');
const pool = require('./DB');
(async () => {
  await ngrok.authtoken('2yS6ar6uqsBDZ5rbzgDDX6R9Ayo_78tbtfKCku8KXZ3q1C5wQ');

  try {
    const listener = await ngrok.connect(3000);
    console.log("Ngrok está corriendo en:", listener.url());
  } catch (err) {
    console.error("Error al iniciar ngrok:", err);
  }
})();

const app = express();
app.use(cors());
app.use(express.json());



app.post('/loginMail', async (req, res) => {
  const { email, password } = req.body;
  try {
    const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Usuario no encontrado' });
    }
    const user = result.rows[0];
    const isPasswordValid = bcrypt.compareSync(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Contraseña incorrecta' });
    }
    const token = jwt.sign({ id: user.id, email: user.email }, process.env.JWT_SECRET, { expiresIn: '20h' });
    res.json({ token });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error del servidor' });
  }
});
app.post('/loginTel', async (req, res) => {
    const { tel, password } = req.body;
    try {
    const result = await pool.query('SELECT * FROM users WHERE telefono = $1', [tel]);
    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'Usuario no encontrado' });
    }
    const user = result.rows[0];
    const isPasswordValid = bcrypt.compareSync(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Contraseña incorrecta' });
    }
    const token = jwt.sign({ id: user.id, tel: user.tel }, process.env.JWT_SECRET, { expiresIn: '20h' });
    res.json({ token });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error del servidor' });
  }
  });

app.listen(3000, () => console.log('API escuchando en http://localhost:3000'));
