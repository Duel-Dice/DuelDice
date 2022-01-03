import { Sequelize, DataTypes } from '../database.js';
import pkg from 'sequelize';
const { Op } = pkg;

export const Duel = Sequelize.define(
  'duel',
  {
    duel_id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      allowNull: false,
      primaryKey: true,
    },
    is_done: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
    player_1_id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      allowNull: false,
      references: {
        model: 'user',
        key: 'user_id',
      },
    },
    player_2_id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      allowNull: false,
      references: {
        model: 'user',
        key: 'user_id',
      },
    },
    player_1_left: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    player_2_left: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    player_1_value: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    player_2_value: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
  },
  {
    freezeTableName: true,
    underscored: true,
  },
);

// Duel.belongsTo(User);

async function getActiveByUserId(user_id) {
  return await Duel.findOne({
    where: {
      [Op.or]: [{ player_1_id: user_id }, { player_2_id: user_id }],
      is_done: false,
    },
    raw: true,
  });
}

async function getHistoryByUserId(user_id) {
  return await Duel.findAll({
    where: {
      [Op.or]: [{ player_1_id: user_id }, { player_2_id: user_id }],
      is_done: true,
    },
    order: [['created_at', 'DESC']],
    raw: true,
  });
}

async function getByDuelId(duel_id) {
  return await Duel.findOne({
    where: { duel_id },
    raw: true,
  });
}

async function create(
  player_1_id, //
  player_2_id,
  player_1_left,
  player_2_left,
) {
  return Duel.create(
    {
      player_1_id, //
      player_2_id,
      player_1_left,
      player_2_left,
    },
    {
      raw: true,
    },
  );
}

async function update(
  duel_id, //
  is_done,
  player_1_left,
  player_2_left,
  player_1_value,
  player_2_value,
) {
  return Duel.update(
    {
      is_done, //
      player_1_left,
      player_2_left,
      player_1_value,
      player_2_value,
    },
    {
      where: { duel_id },
    },
  );
}

export const DuelModel = {
  getActiveByUserId,
  getHistoryByUserId,
  getByDuelId,
  create,
  update,
};
