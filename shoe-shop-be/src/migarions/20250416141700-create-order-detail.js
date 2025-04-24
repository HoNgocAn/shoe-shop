'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('Order_Detail', {
            id: {
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER
            },
            quantity: {
                type: Sequelize.INTEGER
            },
            price: {
                type: Sequelize.DECIMAL(10, 2) // 99999999.99
            },
            subtotal: {
                type: Sequelize.DECIMAL(10, 2)
            },
            orderId: {
                type: Sequelize.INTEGER,
                allowNull: false,
                references: {
                    model: 'Order',
                    key: 'id'
                },
                onDelete: "CASCADE"
            },
            productId: {
                type: Sequelize.INTEGER,
                allowNull: false,
                references: {
                    model: 'Product',
                    key: 'id'
                },
                onDelete: "CASCADE"
            },
            createdAt: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.fn("NOW"),
            },
            updatedAt: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.fn("NOW"),
            }
        });
    },
    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('Order_Detail');
    }
};