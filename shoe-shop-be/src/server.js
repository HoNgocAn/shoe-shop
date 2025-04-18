import express from "express";
import connection from "./config/connectionDB.js";


const app = express();

connection();

const port = process.env.PORT || 8080;

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});