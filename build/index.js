"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const users_1 = __importDefault(require("./routes/users"));
const app = express_1.default();
app.use(express_1.default.json());
app.use(cors_1.default());
// Routes
app.use('/users', users_1.default);
app.get('/', (req, res) => {
    res.status(200).json({
        msg: 'Hey !',
    });
});
app.use((err, req, res, next) => {
    const statusCode = res.statusCode !== 200 ? res.statusCode : 500;
    res.status(statusCode).json(Object.assign(Object.assign({}, err), { stack: process.env.NODE_ENV === 'production' ? '🥞' : err.stack }));
});
app.listen(5000, () => {
    console.log('Running on 5000...');
});
