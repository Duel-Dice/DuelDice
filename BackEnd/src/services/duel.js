// user 정보를 token 에 저장하고있어도 되는거아닌가?
// result -> true : win, false : lose
async function updateUserDice(user_id, result) {
  const user = await UserModel.getByUserId(user_id);

  if (result == true) {
    user.dice_count *= 2;
    user.win_count += 1;
    user.highest_score = max(user.highest_score, user.dice_count);
  } else {
    user.dice_count = 1;
    user.lose_count += 1;
  }

  const updated = await UserModel.update(
    user_id, //
    user.nickname,
    user.dice_count,
    user.highest_score,
    user.win_count,
    user.lose_count,
  );

  return updated;
}
