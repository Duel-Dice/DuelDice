import { Router } from 'express';

import StatisticRouter from './statistic.js';
import UserRouter from './user.js';
import DuelRouter from './duel.js';

export default () => {
  const router = Router();

  router.use('/statistics', StatisticRouter);
  router.use('/users', UserRouter);
  router.use('/duels', DuelRouter);

  return router;
};
