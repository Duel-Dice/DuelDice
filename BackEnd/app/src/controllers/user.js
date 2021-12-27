import { UserService } from '../services/user.js';
import { firebaseAuth } from '../modules/firebase.js';
import ApiError from '../modules/error.js';

async function getUser(req, res, next) {
  const user_id = req.params.user_id || req.user.user_id;

  if (user_id == req.user.user_id) return res.status(200).json(req.user);

  const user = await UserService.getUser(user_id);

  return res.status(200).json(user);
}

async function registerUser(req, res, next) {
  const { firebase_jwt, nickname } = req.body;

  const firebase_uid = await firebaseAuth(firebase_jwt);

  const exist_user = await UserService.loginUser(firebase_uid).catch(err => {});
  if (exist_user)
    throw new ApiError(403, `User already exist: ${firebase_uid}`);

  const user = await UserService.registerUser(firebase_uid, nickname);

  return res.status(200).json(user);
}

async function updateUserNickname(req, res, next) {
  const { user_id } = req.user;
  const { nickname } = req.body;

  const user = await UserService.updateUserNickname(user_id, nickname);

  return res.sendStatus(200);
}

export const UserController = {
  getUser,
  registerUser,
  updateUserNickname,
};
