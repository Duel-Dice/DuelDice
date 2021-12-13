import { Sequelize, DataTypes } from '../database.js';
import { User } from './user.js';

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
    player_1_state: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    player_2_state: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    player_1_value: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    player_2_value: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
  },
  {
    freezeTableName: true,
    underscored: true,
    timestamps: false,
  },
);

// Duel.belongsTo(User);
