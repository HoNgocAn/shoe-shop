'use strict';
const {
    Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Order extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            Order.belongsTo(models.User, { foreignKey: 'userId' })
            Order.belongsToMany(models.Product, { through: "Order_Detail", foreignKey: 'orderId' });
        }
    }
    Order.init({
        totalAmount: DataTypes.DECIMAL,
        userId: DataTypes.INTEGER,
        status: {
            type: DataTypes.ENUM('pending', 'completed', 'cancelled'),
            allowNull: false,
        },
    }, {
        sequelize,
        modelName: 'Order',
    });
    return Order;
};