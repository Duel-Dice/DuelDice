import jwt from 'jsonwebtoken';
import config from '../config/index.js';
import { UserService } from '../services/user.js';

async function getUser(req, res, next) {
  const user_id = req.params.user_id || req.user.user_id;

  const user = await UserService.getUser(user_id);

  return res.status(200).json(user);
}

async function loginUser(req, res, next) {
  const { firebase_uid } = req.body;

  const user = await UserService.loginUser(firebase_uid);
  const token = jwt.sign({ user_id: user.user_id }, config.jwt.secret);

  return res.status(200).json({ token });
}

async function registerUser(req, res, next) {
  const { firebase_uid, nickname } = req.body;

  const user = await UserService.registerUser(firebase_uid, nickname);

  return res.status(200).json(user);
}

async function unregisterUser(req, res, next) {
  const { user_id } = req.user;

  await UserService.unregisterUser(user_id);

  return res.sendStatus(200);
}

async function updateUserNickname(req, res, next) {
  const { user_id } = req.user;
  const { nickname } = req.body;

  const user = await UserService.updateUserNickname(user_id, nickname);

  return res.status(200).json(user);
}

export const UserController = {
  getUser,
  loginUser,
  registerUser,
  unregisterUser,
  updateUserNickname,
};
