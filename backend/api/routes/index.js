const express = require("express");
const app = express();

const user = require('./auth/user');
const refreshToken = require("./auth/refreshToken");
const product = require('./product/product');

app.use('/refreshToken', refreshToken);
app.use('/user', user);
app.use('/product', product);


module.exports = app;
