import db from "../models/index";

const getListCategory = async () => {
    try {
        const data = await db.Category.findAll();
        const message = data.length > 0 ? "Get list category successful" : "No categories found";

        return {
            EM: message,
            EC: 0,
            DT: data,
        };
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
