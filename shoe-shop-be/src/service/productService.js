
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
                EM: "Error 404",
                EC: 1,
                DT: ""
            });
        }
    } catch (error) {

        return ({
            EM: "Error from server",
            EC: -1,
            DT: []
        });
    }
}

const getAllProducts = async () => {
    try {
        const data = await db.Product.findAll();

        if (data && data.length > 0) {
            return {
                EM: "Get list product successful",
                EC: 0,
                DT: data
            };
        } else {
            return {
                EM: "Not found data",
                EC: 1,
                DT: data
            };
        }

    } catch (error) {
        return {
            EM: "Error from server",
            EC: -1,
            DT: []
        };
    }
};


const createNewProduct = async (data) => {
    try {
        const product = await db.Product.create(data);
        if (product) {
            return {
                EM: "Create new product successful",
                EC: 0,
            };
        } else {
            return {
                EM: "Failed to create product",
                EC: 1,
            };
        }
    } catch (error) {
        return {
            EM: "Error from server",
            EC: -1,
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

