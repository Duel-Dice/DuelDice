import { UserModel } from '../db/models/user.js';
import ApiError from '../modules/error.js';

async function getUser(user_id) {
  const user = await UserModel.getByUserId(user_id);

  if (!user) throw new ApiError(404, `User not found: ${user_id}`);

  return user;
}

async function loginUser(firebase_uid) {
  const user = await UserModel.getByFirebaseUid(firebase_uid);

  if (!user) throw new ApiError(404, `User not found: ${firebase_uid}`);

  return user;
}

// Firebase_uid 가 날조되어있다면, 감지할 방법이 없다.
async function registerUser(firebase_uid, nickname) {
  return await UserModel.create(firebase_uid, nickname);
}

async function unregisterUser(user_id) {
  return await UserModel.remove(user_id);
}

async function updateUserNickname(user_id, nickname) {
  return await UserModel.update(user_id, nickname);
}

export const UserService = {
  getUser,
  loginUser,
  registerUser,
  unregisterUser,
  updateUserNickname,
};
