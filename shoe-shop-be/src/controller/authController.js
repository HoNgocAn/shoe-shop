import { registerNewUser, loginUser } from "../service/authService";
import { verifyRefreshToken } from "../middleware/JWTAction";
import jwt from 'jsonwebtoken';
import redisClient from "../config/connection_redis";


const testAPI = (req, res) => {
    return res.status(200).json({
        message: "ok",
        data: "test API"
    })
}

const handleRegister = async (req, res, next) => {
    try {
        let data = await registerNewUser(req.body)
        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT
        })

    } catch (e) {
        console.log(e);
        return res.status(500).json({
            EM: "error from server",
            EC: -1,
            DT: ""
        })

    }

}


const handleLogin = async (req, res, next) => {

    try {

        let data = await loginUser(req.body);

        if (data && data.EC === 0) {
            return res.status(200).json({
                EM: data.EM,
                EC: data.EC,
                DT: {
                    access_token: data.DT.access_token,
                    refresh_token: data.DT.refresh_token,
                    username: data.DT.username,
                    id: data.DT.id,
                    group: data.DT.group
                }
            });
        } else {
            return res.status(401).json({
                EM: "Invalid credentials",
                EC: 1,
                DT: ""
            });
        }

    } catch (e) {
        console.log(e);
        return res.status(500).json({
            EM: "error from server",
            EC: -1,
            DT: ""
        });
    }
};

const handleLogout = async (req, res) => {
    try {
        const { refreshToken } = req.body;

        if (!refreshToken) {
            return res.status(400).json({
                EM: "Missing refresh token",
                EC: 1,
                DT: ""
            });
        }

        const decoded = await verifyRefreshToken(refreshToken);

        if (!decoded || !decoded.id) {
            return res.status(401).json({
                EM: "Invalid token",
                EC: 1,
                DT: ""
            });
        }

        const userId = decoded.id;

        await redisClient.del(`refreshToken:${userId}`);

        return res.status(200).json({
            EM: "User logged out successfully",
            EC: 0,
            DT: ""
        });

    } catch (e) {
        console.error("Logout error:", e);
        return res.status(500).json({
            EM: "Server error",
            EC: -1,
            DT: ""
        });
    }
};
const createNewToken = async (req, res) => {
    const { refreshToken } = req.body;

    if (!refreshToken) {
        return res.status(400).json({
            EM: 'Refresh token is required',
            EC: 1,
            DT: ''
        });
    }

    try {
        const decoded = await verifyRefreshToken(refreshToken);

        if (!decoded) {
            return res.status(403).json({
                EM: 'Invalid or expired refresh token',
                EC: 1,
                DT: ''
            });
        }

        // Không cần truy vấn DB nữa
        const payload = {
            id: decoded.id,
            username: decoded.username,
            group: decoded.group,
        };

        const accessToken = jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET, {
            expiresIn: process.env.JWT_ACCESS_EXPRIES_IN,
        });

        return res.status(200).json({
            EM: "Created new token successfully",
            EC: 0,
            DT: {
                accessToken: accessToken
            }
        });

    } catch (error) {
        console.error('Error refreshing token:', error.message);
        return res.status(500).json({
            EM: 'Server error while refreshing token',
            EC: -1,
            DT: ''
        });
    }
};


export {
    testAPI, handleRegister, handleLogin, handleLogout, createNewToken
};