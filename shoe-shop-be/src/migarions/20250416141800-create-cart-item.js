'use strict';
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('CartItem', {
            id: {
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER
            },
            cartId: {
                type: Sequelize.INTEGER,
                allowNull: false,
                references: {
                    model: 'Cart', // Tên bảng
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE'
            },
            productId: {
                type: Sequelize.INTEGER,
                allowNull: false,
                references: {
                    model: 'Product',
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE'
            },
            quantity: {
                type: Sequelize.INTEGER,
                allowNull: false,
                defaultValue: 1
            },
            price: {
                type: Sequelize.DECIMAL,
                allowNull: false
            },
            createdAt: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.fn('NOW')
            },
            updatedAt: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.fn('NOW')
            }
        });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('CartItem');
    }
};