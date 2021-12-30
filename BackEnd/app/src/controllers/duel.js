import { DuelService } from '../services/duel.js';

async function getActiveDuel(req, res, next) {
  const { user_id } = req.user;

  const duel = await DuelService.getActiveDuel(user_id);

  return res.status(200).json(duel);
}

async function getDuel(req, res, next) {
  const { duel_id } = req.params;

  const duel = await DuelService.getDuel(duel_id);

  return res.status(200).json(duel);
}

async function startMatching(req, res, next) {
  const { user_id, dice_count } = req.user;

  await DuelService.startMatching(user_id, dice_count);

  return res.sendStatus(200);
}

async function rollHalf(req, res, next) {
  const { user_id } = req.user;

  const get_roll_dice = dice_count => Math.ceil(dice_count / 2);
  const updated = await DuelService.rollDice(user_id, get_roll_dice);

  return res.status(200).json(updated);
}

async function rollAll(req, res, next) {
  const { user_id } = req.user;

  const get_roll_dice = dice_count => dice_count;
  const updated = await DuelService.rollDice(user_id, get_roll_dice);

  return res.status(200).json(updated);
}

export const DuelController = {
  getActiveDuel,
  getDuel,
  startMatching,
  rollHalf,
  rollAll,
};
