import { UserModel } from '../db/models/user.js';
import { DuelModel } from '../db/models/duel.js';
import ApiError from '../modules/error.js';

async function getUser(user_id) {
  const user = await UserModel.getByUserId(user_id);

  if (!user) throw new ApiError(404, `User not found: ${user_id}`);

  return user;
}

async function getUserHistory(user_id) {
  const history = await DuelModel.getHistoryByUserId(user_id);

  return history;
}

async function loginUser(firebase_uid) {
  const user = await UserModel.getByFirebaseUid(firebase_uid);

  if (!user) throw new ApiError(401, 'Unauthorized');

  return user;
}

async function registerUser(firebase_uid, nickname) {
  const raw_user = await UserModel.create(firebase_uid, nickname);

  const user = await UserModel.getByUserId(raw_user.user_id);

  return user;
}

async function updateUserNickname(user_id, nickname) {
  return await UserModel.updateNickname(user_id, nickname);
}

export const UserService = {
  getUser,
  getUserHistory,
  loginUser,
  registerUser,
  updateUserNickname,
};
