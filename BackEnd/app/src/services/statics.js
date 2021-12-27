import { UserModel } from '../db/models/user.js';

async function getUser(dice_count) {
  const users = await UserModel.getByDiceCount(dice_count);

  return users;
}

export const StaticsService = {
  getUser,
};
