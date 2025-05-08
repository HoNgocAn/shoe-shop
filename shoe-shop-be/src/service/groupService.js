import db from "../models/index";

const getListGroup = async () => {
    try {

        let data = await db.Group.findAll({
            order: [["name", "ASC"]]
        })

        if (data && data.length > 0) {
            return {
                EM: "Get list group successful",
                EC: 0,
                DT: data
            }
        } else {
            return {
                EM: "Not found data",
                EC: 1,
                DT: []
            }
        }

    } catch (error) {
        console.log(error);
        return {
            EM: "Error from server",
            EC: -1,
            DT: [],
        };
    }
}

module.exports = {
    getListGroup
}