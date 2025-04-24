'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Favorite extends Model {
    static associate(models) {
      // Favorite thuộc về một user
      Favorite.belongsTo(models.User, { foreignKey: 'userId' });

      // Favorite thuộc về một product
      Favorite.belongsTo(models.Product, { foreignKey: 'productId' });
    }
  }
  Favorite.init({
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    productId: {
      type: DataTypes.INTEGER,
      allowNull: false
    }
  }, {
    sequelize,
    modelName: 'Favorite',
  });
  return Favorite;
};