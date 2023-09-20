const model = require("../../models/auth/refreshToken");
const dal = require("../../dal/dal");
const jwt = require("jsonwebtoken");
require("config");

exports.getToken = async (filter, projection = {}) => await dal.findOne(model, filter, projection);

let generateAccessToken = (body) => {
    return jwt.sign(body, process.env.ACCESS_TOKEN_PRIVATE_KEY, { expiresIn: process.env.ACCESS_TOKEN_EXPIRY_DAY})
}

exports.generateAccessToken = async (user) => {

    const body = {
        userId: user.userId,
        roles: user.roles,
        phone: user.phone,
        email: user?.email
    }

    const accessToken = generateAccessToken(body);
    return accessToken;
};

exports.deleteToken = async (filter) => {
    return await dal.findOneAndDelete(model, filter);
}