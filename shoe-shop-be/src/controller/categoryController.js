import { getListCategory } from "../service/categoryService";

const handleGetListCategory = async (req, res) => {
    try {
        let data = await getListCategory();

        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT
        });

    } catch (error) {
        // Lỗi thực sự (exception)
        return res.status(500).json({
            EM: "error from controller",
            EC: -1,
            DT: ""
        });
    }
};

export {
    handleGetListCategory
}