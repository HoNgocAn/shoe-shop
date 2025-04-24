'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('Order', {
            id: {
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER
            },
            totalAmount: {
                type: Sequelize.DECIMAL
            },
            status: {
                type: Sequelize.ENUM('pending', 'completed', 'cancelled'), 
                allowNull: false, 
            },
            userId: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'User',
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
        await queryInterface.dropTable('Order');
    }
};