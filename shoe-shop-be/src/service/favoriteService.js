import db from "../models/index";

const toggleFavorite = async ({ userId, productId }) => {
    try {

        const existing = await db.Favorite.findOne({
            where: { userId, productId }
        });

        if (existing) {

            const newFavoriteStatus = !existing.isFavorite;

            await db.Favorite.update(
                { isFavorite: newFavoriteStatus },
                { where: { userId, productId } }
            );

            return {
                EM: newFavoriteStatus ? "Added to favorites" : "Removed from favorites",
                EC: 0,
                DT: newFavoriteStatus
            };
        } else {

            const favorite = await db.Favorite.create({ userId, productId, isFavorite: true });

            return {
                EM: "Added to favorites successfully",
                EC: 0,
                DT: favorite
            };
        }
    } catch (error) {
        console.error("Error in toggleFavorite:", error);
        return {
            EM: "Server error",
            EC: -1,
            DT: null
        };
    }
};

const getFavoritesByUser = async (userId) => {
    try {
        const favorites = await db.Favorite.findAll({
            where: { userId },
            include: {
                model: db.Product,
                attributes: ['id', 'name', 'price', 'image', 'quantity', 'categoryId']
            }
        });

        return {
            EM: "Get favorite products successfully",
            EC: 0,
            DT: favorites
        };
    } catch (error) {
        console.error("Error in getFavoritesByUser:", error);
        return {
            EM: "Server error",
            EC: 1,
            DT: []
        };
    }
};

export { toggleFavorite, getFavoritesByUser }