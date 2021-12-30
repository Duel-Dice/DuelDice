import express from 'express';
import 'express-async-errors';

import { StatisticController } from '../controllers/statistic.js';

const router = express.Router();

router.get('/users/:dice_count', StatisticController.getUser);

export default router;
