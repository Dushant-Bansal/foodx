const express = require("express");
const app = express();

const user = require('./auth/user');
const refreshToken = require("./auth/refreshToken");
const product = require('./product/product');
const space = require('./space/spcace');
const upload = require('./upload');

app.use('/refreshToken', refreshToken);
app.use('/user', user);
app.use('/product', product);
app.use('/space', space);
app.use('/Uploader', upload);


module.exports = app;
