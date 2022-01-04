import express from 'express';
import 'express-async-errors';

import { UserController } from '../controllers/user.js';
import { Auth } from '../middleware/auth.js';

const router = express.Router();

router.get('/', Auth, UserController.getUser);
router.get('/login', Auth, UserController.getUser);
router.get('/history', Auth, UserController.getUserHistory);
router.get('/:user_id', Auth, UserController.getUser);
router.post('/register', UserController.registerUser);
router.put('/nickname', Auth, UserController.updateUserNickname);

export default router;
