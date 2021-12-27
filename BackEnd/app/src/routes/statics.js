import express from 'express';
import 'express-async-errors';

import { StaticsController } from '../controllers/statics.js';

const router = express.Router();

router.get('/users/:dice_count', StaticsController.getUser);

export default router;
