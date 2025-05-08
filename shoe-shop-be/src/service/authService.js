import dotenv from 'dotenv';
dotenv.config();
import db from "../models/index";
import bcrypt from "bcrypt";
import { createJWT, createRefreshToken } from "../middleware/JWTAction";

const hashUserPassword = async (userPassword) => {
    const salt = await bcrypt.genSalt(10);  // Lấy salt bất đồng bộ
    return await bcrypt.hash(userPassword, salt);  // Mã hóa mật khẩu và trả về Promise
}

const checkUser = async (username) => {
    let user = await db.User.findOne({
        where: { username: username }
    })
    if (user) {
        return true;
    }
    return false;
}

const checkPassword = async (inputPassword, hashPassword) => {
    return await bcrypt.compare(inputPassword, hashPassword);
}

const registerNewUser = async (rawUserData) => {
    try {
        let isUserExist = await checkUser(rawUserData.username);

        if (isUserExist) {
            return {
                EM: "Account is already exist",
                EC: 1
            };
        }

        let hashPassword = await hashUserPassword(rawUserData.password);

        await db.User.create({
            username: rawUserData.username,
            password: hashPassword,
            groupId: 3
        });

        return {
            EM: "Account is created successfully",
            EC: 0
        };
    } catch (error) {
        console.error("Error in registerNewUser:", error);
        return {
            EM: "Internal server error",
            EC: -1
        };
    }
}

const getGroupWithRoles = async (user) => {
    let roles = await db.Group.findOne({
        where: { id: user.groupId },
        attributes: ["id", "name"],
        include: {
            model: db.Role,
            attributes: ["id", "url"],
            through: { attributes: [] }
        },

    })
    return roles ? roles : null
}


const loginUser = async (rawData) => {
    try {
        let user = await db.User.findOne({
            where: {
                username: rawData.valueLogin
            }
        });

        if (!user) {
            return {
                EM: "Invalid login information",
                EC: 1
            };
        }


        // Kiểm tra mật khẩu
        let isCorrectPassword = await checkPassword(rawData.password, user.password);
        if (isCorrectPassword) {

            let group = await getGroupWithRoles(user);

            let payload = {
                id: user.id,
                username: user.username,
                group: group,
            }

            let accessToken = createJWT(payload);
            let refreshToken = await createRefreshToken(payload);
            return {
                EM: "Login successfully",
                EC: 0,
                DT: {
                    access_token: accessToken,
                    refresh_token: refreshToken,
                    username: user.username,
                    id: user.id,
                    group: group
                }
            };
        } else {
            return {
                EM: "Invalid login information",
                EC: 1
            };
        }
    } catch (error) {
        console.error("Error during login:", error);
        return {
            EM: "Server error",
            EC: -1
        };
    }
};

export {
    registerNewUser, loginUser, getGroupWithRoles
};

