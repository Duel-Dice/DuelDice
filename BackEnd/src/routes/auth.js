import express from 'express';
import 'express-async-errors';

import { UserController } from '../controllers/user.js';
import { Auth } from '../middleware/auth.js';

const router = express.Router();

router.post('/login', UserController.loginUser);
router.post('/register', UserController.registerUser);
router.get('/unregister', Auth, UserController.unregisterUser);

export default router;
