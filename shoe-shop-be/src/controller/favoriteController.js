import { toggleFavorite, getFavoritesByUser } from "../service/favoriteService";

const handleToggleFavorite = async (req, res) => {
    try {
        const { userId, productId } = req.body;

        // Kiểm tra tham số đầu vào
        if (!userId || !productId) {
            return res.status(400).json({
                EM: "Missing required parameters",
                EC: 1,
                DT: null
            });
        }

        // Gọi hàm toggleFavorite để thêm hoặc xóa yêu thích
        const data = await toggleFavorite({ userId, productId });

        // Trả về kết quả cho client
        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT
        });

    } catch (error) {
        // Xử lý lỗi server
        console.error("Error in handleToggleFavorite:", error);
        return res.status(500).json({
            EM: "Server error",
            EC: -1,
            DT: null
        });
    }
};

const handleGetFavoritesByUser = async (req, res) => {
    try {
        const userId = req.params.id;

        if (isNaN(userId)) {
            return res.status(400).json({
                EM: "Invalid user ID",
                EC: 1,
                DT: null
            });
        }

        const data = await getFavoritesByUser(userId);

        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT
        });
    } catch (error) {
        console.log(error);

        return res.status(500).json({
            EM: "Error from server",
            EC: -1,
            DT: null
        });
    }
};

export { handleToggleFavorite, handleGetFavoritesByUser };