import dotenv from 'dotenv';
dotenv.config();
import express from "express";
import connection from "./config/connectionDB.js";
import initAPIbRoutes from "./routes/api.js";
import bodyParser from 'body-parser';
import './config/connection_redis.js';
import helmet from 'helmet';

const app = express();


app.use(helmet());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

connection();

initAPIbRoutes(app);

app.use((req, res, next) => {
    res.status(404).json({
        message: "API not found",
    });
});


const port = process.env.PORT || 8080;

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});