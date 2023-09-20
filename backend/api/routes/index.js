const express = require("express");
const app = express();

const user = require('./auth/user');

app.use('/user', user);


module.exports = app;
