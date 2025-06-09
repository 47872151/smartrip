import axios from 'axios';
import jwt from 'jsonwebtoken';
import fs from 'fs';
import path from 'path';

// Cargar clave desde el archivo JSON
const keyFilePath = path.resolve('./SMARTRIP ASSIMETRIC PRIVATE KEY.json');
const keyData = JSON.parse(fs.readFileSync(keyFilePath, 'utf8'));

const UBER_AUTH_URL = 'https://login.uber.com/oauth/v2/token';
const UBER_API_BASE_URL = 'https://sandbox-api.uber.com/v1.2';

async function getAccessToken() {
  const now = Math.floor(Date.now() / 1000);
  const payload = {
    iss: keyData.application_id,
    sub: keyData.application_id,
    aud: 'https://login.uber.com',
    exp: now + 300,
    iat: now,
  };

  const jwtToken = jwt.sign(payload, keyData.private_key, {
    algorithm: 'RS256',
    keyid: keyData.key_id,
  });

  const params = new URLSearchParams();
  params.append('grant_type', 'client_credentials');
  params.append('client_id', keyData.application_id);
  params.append('client_secret', jwtToken);
  params.append('scope', 'rides.request');

  const response = await axios.post(UBER_AUTH_URL, params.toString(), {
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  });

  return response.data.access_token;
}

export async function getPriceEstimates(startLat, startLng, endLat, endLng) {
  const token = await getAccessToken();
  const response = await axios.get(`${UBER_API_BASE_URL}/estimates/price`, {
    headers: { Authorization: `Bearer ${token}` },
    params: {
      start_latitude: startLat,
      start_longitude: startLng,
      end_latitude: endLat,
      end_longitude: endLng,
    },
  });
  return response.data.prices;
}

export async function getTimeEstimates(startLat, startLng) {
  const token = await getAccessToken();
  const response = await axios.get(`${UBER_API_BASE_URL}/estimates/time`, {
    headers: { Authorization: `Bearer ${token}` },
    params: {
      start_latitude: startLat,
      start_longitude: startLng,
    },
  });
  return response.data.times;
}

export async function createRide(productId, startLat, startLng, endLat, endLng) {
  const token = await getAccessToken();
  const response = await axios.post(`${UBER_API_BASE_URL}/requests`, {
    product_id: productId,
    start_latitude: startLat,
    start_longitude: startLng,
    end_latitude: endLat,
    end_longitude: endLng,
  }, {
    headers: {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json'
    },
  });
  return response.data;
}
