import { Router } from 'express';

import statisticRouter from './statistic.js';
import UserRouter from './user.js';
import DuelRouter from './duel.js';

export default () => {
  const router = Router();

  router.use('/statistic', statisticRouter);
  router.use('/users', UserRouter);
  router.use('/duels', DuelRouter);

  return router;
};
