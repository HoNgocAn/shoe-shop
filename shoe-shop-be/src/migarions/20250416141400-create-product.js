'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('Product', {
            id: {
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER
            },
            name: {
                type: Sequelize.STRING
            },
            price: {
                type: Sequelize.DECIMAL(10, 2) // 99999999.99
            },
            quantity: {
                type: Sequelize.INTEGER
            },
            image: {
                type: Sequelize.STRING
            },
            categoryId: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'Category',
                    key: 'id'
                },
                onDelete: 'CASCADE',
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
        await queryInterface.dropTable('Product');
    }
};