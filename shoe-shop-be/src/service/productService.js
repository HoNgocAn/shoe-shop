
import db from "../models/index"
import { Op } from 'sequelize';

const getListProducts = async (page, limit, nameSearch, minPrice, maxPrice) => {
    try {
        let offset = (page - 1) * limit;

        const { count, rows } = await db.Product.findAndCountAll({
            where: {
                name: {
                    [Op.like]: `%${nameSearch}%`
                },
                price: {
                    [Op.between]: [minPrice, maxPrice]
                }
            },
            offset: offset,
            limit: limit
        });

        let totalPages = Math.ceil(count / limit);

        let data = {
            totalRows: count,
            totalPages: totalPages,
            products: rows
        }

        if (data) {
            return ({
                EM: "Get list product successful",
                EC: 0,
                DT: data
            });
        } else {
            return ({
                EM: "Get list product successful",
                EC: 0,
                DT: []
            });
        }

    } catch (error) {
        console.log("Lỗi khi getListProducts:", error.message, error.stack);
        return ({
            EM: "Error when getting list of products",
            EC: 1,
            DT: []
        });
    }
}

const getAllProducts = async () => {
    try {
        const data = await db.Product.findAll();

        return {
            EM: data.length > 0 ? "Get list product successful" : "No products found",
            EC: 0,
            DT: data
        };
    } catch (error) {
        console.log(error);
        return {
            EM: "Something went wrong when fetching products",
            EC: -1,
            DT: []
        };
    }
};


const createNewProduct = async (data) => {
    try {
        await db.Product.create(data);
        return {
            EM: "Create new product successful",
            EC: 0,
        };
    } catch (error) {
        console.error("Error creating new product:", error);
        return {
            EM: "Failed to create new product",
            EC: 1,
        };
    }
};

const getProductById = async (id) => {
    try {
        const data = await db.Product.findOne({ where: { id } });

        if (data) {
            return {
                EM: "Get product by ID successful",
                EC: 0,
                DT: data,
            };
        } else {
            return {
                EM: "Product not found",
                EC: 1,
                DT: null,
            };
        }
    } catch (error) {
        console.error("Error getting product by ID:", error);
        return {
            EM: "Error from server",
            EC: -1,
            DT: null,
        };
    }
};

export {
    getListProducts, getAllProducts, createNewProduct, getProductById
}

