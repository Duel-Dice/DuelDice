import { Router } from 'express';

import StaticsRouter from './statics.js';
import UserRouter from './user.js';
import DuelRouter from './duel.js';

export default () => {
  const router = Router();

  router.use('/statics', StaticsRouter);
  router.use('/users', UserRouter);
  router.use('/duels', DuelRouter);

  return router;
};
