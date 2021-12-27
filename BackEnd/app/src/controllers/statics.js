import { StaticsService } from '../services/statics.js';

async function getUser(req, res, next) {
  const dice_count = req.params.dice_count;

  const users = await StaticsService.getUser(dice_count);

  return res.status(200).json(users);
}

export const StaticsController = {
  getUser,
};
