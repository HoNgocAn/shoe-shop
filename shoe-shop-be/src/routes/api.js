import express from "express";
import { testAPI, handleRegister, handleLogin, handleLogout, createNewToken } from "../controller/authController";
import { validateAuth } from "../middleware/authValidate";
import { registerSchema, loginSchema } from "../helpers/validation";
import { checkUserJWT } from '../middleware/JWTAction';
import { handleGetListProduct, handleGetAllProduct, handleGetProductById } from "../controller/productController";
import { handleGetListGroup } from "../controller/groupController";
import { handleGetListUser, handleCreateUser, handleUpdateUser, handleDeleteUser, getUserAccount, handleGetUserById, handleChangePassword } from "../controller/userController";
import { handleGetListRole, handleCreateRole, handleDeleteRole, handleFetchRolesByGroup, handleAssignRoleToGroup } from "../controller/roleController";
import { handleGetListCategory } from "../controller/categoryController";


const router = express.Router();


const initAPIRoutes = (app) => {

    router.get("/test", checkUserJWT, testAPI);
    router.post("/register", validateAuth(registerSchema), handleRegister);
    router.post("/login", validateAuth(loginSchema), handleLogin);
    router.delete("/logout", handleLogout);
    router.get("/product/list", handleGetListProduct);
    router.get("/product/all", handleGetAllProduct);
    router.get("/product/detail/:id", handleGetProductById);
    router.post("/refresh-token", createNewToken);
    router.get("/category/list", handleGetListCategory);



    // router.use(checkUserJWT);
    router.get("/account", getUserAccount);

    router.get("/group/list", handleGetListGroup);

    router.get("/user/list", handleGetListUser);
    router.get("/user/detail/:id", handleGetUserById);
    router.put("/user/changePassword", handleChangePassword);
    router.post("/user/create", handleCreateUser);
    router.put("/user/update", handleUpdateUser);
    router.delete("/user/delete/:id", handleDeleteUser);

    router.get("/role/by-group/:groupId", handleFetchRolesByGroup);
    router.post("/role/assign-to-group", handleAssignRoleToGroup);

    router.get("/role/list", handleGetListRole);
    router.post("/role/create", handleCreateRole);
    router.delete("/role/delete/:id", handleDeleteRole);

    return app.use("/api", router);
}

export default initAPIRoutes;

