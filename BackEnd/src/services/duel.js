import { DuelModel } from '../db/models/duel.js';
import { UserModel } from '../db/models/user.js';
import ApiError from '../modules/error.js';

async function getActiveDuel(user_id) {
  const duel = await DuelModel.getActiveByUserId(user_id);

  if (!duel) throw new ApiError(404, `Duel not found from user: ${user_id}`);

  return duel;
}

async function getDuel(duel_id) {
  const duel = await DuelModel.getByDuelId(duel_id);

  if (!duel) throw new ApiError(404, `Duel not found: ${duel_id}`);

  return duel;
}

const match_pull = [];
async function startMatching(user_id, dice_num) {
  if (!match_pull[dice_num]) {
    match_pull[dice_num] = user_id;
    return;
  }

  const player_1_id = match_pull[dice_num];
  const player_2_id = user_id;
  const player_1_left = (await UserModel.getByUserId(player_1_id)).dice_count;
  const player_2_left = (await UserModel.getByUserId(player_2_id)).dice_count;

  await DuelModel.create(
    player_1_id,
    player_2_id,
    player_1_left,
    player_2_left,
  );
}

// user 정보를 token 에 저장하고있어도 되는거아닌가?
// result -> true : win, false : lose
async function updateUserDice(user_id, result) {
  const user = await UserModel.getByUserId(user_id);

  if (result == true) {
    user.dice_count *= 2;
    user.win_count += 1;
    user.highest_score = Math.max(user.highest_score, user.dice_count);
  } else {
    user.dice_count = 1;
    user.lose_count += 1;
  }

  return await UserModel.update(
    user_id, //
    user.nickname,
    user.dice_count,
    user.highest_score,
    user.win_count,
    user.lose_count,
  );
}

async function rollDice(user_id, get_roll_dice) {
  const duel = await getActiveDuel(user_id);

  const player_left = [duel.player_1_left, duel.player_2_left];
  const player_value = [duel.player_1_value, duel.player_2_value];
  const player = +(duel.player_2_id == user_id);
  console.log('player ; ', duel.player_2_id == user_id);
  const roll_dice = get_roll_dice(player_left[player]);
  player_left[player] -= roll_dice;
  if (player_left[player] < 0)
    new ApiError(420, "Can't roll more than you have.");

  for (var i = 0; i < roll_dice; i++)
    player_value[player] += Math.floor(Math.random() * 6) + 1;

  let is_done = false;
  if (player_left[0] == 0 && player_left[1] == 0) {
    is_done = true;
    await updateUserDice(duel.player_1_id, player_value[0] > player_value[1]);
    await updateUserDice(duel.player_2_id, player_value[0] < player_value[1]);
  }

  console.log(player_left);
  console.log(player_value);

  return await DuelModel.update(
    duel.duel_id,
    is_done,
    player_left[0],
    player_left[1],
    player_value[0],
    player_value[1],
  );
}

export const DuelService = {
  getActiveDuel,
  getDuel,
  startMatching,
  rollDice,
};
