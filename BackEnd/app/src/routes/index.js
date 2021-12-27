import { Router } from 'express';

import AuthRouter from './auth.js';
import UserRouter from './user.js';
import DuelRouter from './duel.js';

export default () => {
  const router = Router();

  router.use('/auth', AuthRouter);
  router.use('/users', UserRouter);
  router.use('/duels', DuelRouter);
  router.get('/', 
  async function getUser(req, res, next) {
    return res.send("hihihihihihi");
  }
  )

  return router;
};
