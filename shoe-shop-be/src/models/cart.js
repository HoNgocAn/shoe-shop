'use strict';
const {
    Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Cart extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // Một giỏ hàng thuộc về một người dùng
            Cart.belongsTo(models.User, { foreignKey: 'userId' });
            // Một giỏ hàng có thể chứa nhiều sản phẩm thông qua bảng trung gian 'Cart_Product'
            Cart.belongsToMany(models.CartItem, { through: 'Cart_Item', foreignKey: 'cartId' });
        }
    }
    Cart.init({
        totalAmount: DataTypes.DECIMAL, // Tổng giá trị giỏ hàng
        userId: DataTypes.INTEGER, // Tham chiếu đến người dùng sở hữu giỏ hàng
    }, {
        sequelize,
        modelName: 'Cart',
    });
    return Cart;
};