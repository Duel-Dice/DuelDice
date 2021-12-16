import { Sequelize, DataTypes } from '../database.js';
import { Duel } from './duel.js';

export const User = Sequelize.define(
  'user',
  {
    user_id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      allowNull: false,
      primaryKey: true,
    },
    firebase_uid: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    nickname: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    dice_count: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
    },
    highest_score: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
    },
    win_count: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    lose_count: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
  },
  {
    freezeTableName: true,
    underscored: true,
    paranoid: true, // 이거 작동하는지?
  },
);

// User.hasMany(Duel, {
//   sourceKey: 'user_id',
//   foreignKey: 'player_1',
//   onUpdate: 'cascade',
//   onDelete: 'set null',
// });

// User.hasMany(Duel, {
//   sourceKey: 'user_id',
//   foreignKey: 'player_2',
//   onUpdate: 'cascade',
//   onDelete: 'set null',
// });

async function getByUserId(user_id) {
  return await User.findOne({
    attributes: [
      'user_id',
      'nickname',
      'dice_count',
      'highest_score',
      'win_count',
      'lose_count',
    ],
    where: { user_id },
    raw: true,
  });
}

async function getByFirebaseUid(firebase_uid) {
  return await User.findOne({
    attributes: [
      'user_id',
      'nickname',
      'dice_count',
      'highest_score',
      'win_count',
      'lose_count',
    ],
    where: { firebase_uid },
    raw: true,
  });
}

async function create(firebase_uid, nickname) {
  return User.create(
    {
      firebase_uid, //
      nickname,
    },
    {
      raw: true,
    },
  );
}

// 존재하지 않는 값이 들어오면 어떻게 되나?
//User.update 앞에 await 들어가야하나?
// return 값이 user 가 맞는지...?
async function update(
  user_id, //
  nickname,
  dice_count,
  highest_score,
  win_count,
  lose_count,
) {
  return User.update(
    {
      nickname, //
      dice_count,
      highest_score,
      win_count,
      lose_count,
    },
    {
      where: { user_id },
    },
  );
}

async function remove(user_id) {
  return User.destroy({
    where: { user_id },
  });
}

export const UserModel = {
  getByFirebaseUid,
  getByUserId,
  create,
  update,
  remove,
};
