import express from 'express';
import 'express-async-errors';

import { DuelController } from '../controllers/duel.js';
import { Auth } from '../middleware/auth.js';

const router = express.Router();

router.get('/', Auth, DuelController.getActiveDuel);
router.get('/:duel_id', Auth, DuelController.getDuel);
router.post('/start', Auth, DuelController.startMatching);
router.put('/roll/half', Auth, DuelController.rollHalf);
router.put('/roll/all', Auth, DuelController.rollAll);

export default router;
