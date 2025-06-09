import express from 'express';
import { getPriceEstimates, getTimeEstimates, createRide } from '../apis/UberAPI.js';

const router = express.Router();

router.get('/estimate', async (req, res) => {
  const { startLat, startLng, endLat, endLng } = req.query;
  try {
    const prices = await getPriceEstimates(startLat, startLng, endLat, endLng);
    const times = await getTimeEstimates(startLat, startLng);
    res.json({ prices, times });
  } catch (error) {
    console.error('Estimation error:', error.response?.data || error);
    res.status(500).json({ error: 'Failed to get estimates' });
  }
});

router.post('/ride', async (req, res) => {
  const { productId, startLat, startLng, endLat, endLng } = req.body;
  try {
    const ride = await createRide(productId, startLat, startLng, endLat, endLng);
    res.json(ride);
  } catch (error) {
    console.error('Create ride error:', error.response?.data || error);
    res.status(500).json({ error: 'Failed to create ride' });
  }
});

export default router;
