import db from "../models/index";

const getListCategory = async () => {

    try {
        const data = await db.Category.findAll({
            attributes: ['id', 'name', 'image']
        });
        if (data && data.length > 0) {
            return {
                EM: "Get list category successful",
                EC: 0,
                DT: data,
            };
        } else {
            return {
                EM: "Not found data",
                EC: 1,
                DT: data,
            };
        }
    } catch (error) {
        console.error("Error getting category list:", error.message || error);
        return {
            EM: "Error from server",
            EC: -1,
            DT: [],
        };
    }
};

export {
    getListCategory
}
