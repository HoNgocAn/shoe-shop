'use strict';

module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('Review', {
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
            },
            rating: {
                type: Sequelize.INTEGER,
                allowNull: false,
                validate: {
                    min: 1,
                    max: 5,
                }
            },
            comment: {
                type: Sequelize.TEXT,
                allowNull: true,
            },
            userId: {
                type: Sequelize.INTEGER,
                allowNull: false,
                references: {
                    model: 'User', // Tên bảng User mà Review tham chiếu
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE', // Khi User bị xóa, các review liên quan cũng sẽ bị xóa
            },
            productId: {
                type: Sequelize.INTEGER,
                allowNull: false,
                references: {
                    model: 'Product', // Tên bảng Product mà Review tham chiếu
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE', // Khi Product bị xóa, các review liên quan cũng sẽ bị xóa
            },
            createdAt: {
                allowNull: false,
                type: Sequelize.DATE,
            },
            updatedAt: {
                allowNull: false,
                type: Sequelize.DATE,
            },
        });
    },

    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('Review');
    },
};