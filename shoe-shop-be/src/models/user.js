'use strict';
const {
    Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class User extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            User.belongsTo(models.Group, { foreignKey: 'groupId' });
            User.hasMany(models.Order, { foreignKey: 'userId' });
            User.hasOne(models.Cart, { foreignKey: 'userId' });
            User.hasMany(models.Favorite, { foreignKey: 'userId' })
            User.hasMany(models.Review, { foreignKey: 'userId' })
        }
    }
    User.init({
        username: DataTypes.STRING,
        password: DataTypes.STRING,
        groupId: DataTypes.INTEGER,
    }, {
        sequelize,
        modelName: 'User',
    });
    return User;
};