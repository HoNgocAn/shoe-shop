'use strict';
const {
    Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class GroupRole extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {

        }
    }
    GroupRole.init({
        groupId: {
            type: DataTypes.INTEGER,
            references: {
                model: 'Group',
                key: 'id'
            }
        },
        roleId: {
            type: DataTypes.INTEGER,
            references: {
                model: 'Role',
                key: 'id'
            }
        }
    }, {
        sequelize,
        modelName: 'GroupRole',
        tableName: 'Group_Role',
    });
    return GroupRole;
};