const model = require('../../models/auth/user');
const refreshTokenModel = require("../../models/auth/refreshToken");
const dal = require('../../dal/dal');
const bcrypt = require('bcryptjs');
const { getAccessToken, getRefreshToken } = require('../../helpers/helper');
require('dotenv').config();

exports.addUser = async (value) => {
    let token;
    value.password = await bcrypt.hash(value.password, 10);
    const count = await dal.find(model, { email: value.email }, { limit: 1 }, { email: -1 })
    if (count.length > 0) {
        return { userData: null, token: null, message: "User Already exist with this email" }
    }

    value.active = true
    const data = await dal.create(model, value)
    const body = {
        id: data._id,
        userId: data.userId,
        name: data.nama,
        email: data?.email,
        phone: data?.phone,
    };
    token = getAccessToken(body);
    let refreshToken = getRefreshToken(body);

    let refreshBody = {
        userId: data._id,
        token: refreshToken
    }

    await dal.create(refreshTokenModel, refreshBody);

    return {
        userData: data, token: token,
        refreshToken: refreshToken,
    }
}

exports.login = async (value) => {
    let token;
    const projections = {
        email: 1,
        name: 1,
        userId: 1,
        phone: 1,
    }
    let user;

    if (value.mode === "Oauth") {
        user = await dal.findOneAndUpsert(model, { email: value.email }, value)
        // user = await dal.findOne(model, { email: value.email }, projections)
    } else if (value.mode === "email") {
        user = await dal.findOne(model, { email: value.email }, projections)
    } else if (value.mode === "phone") {
        user = await dal.findOne(model, { phone: value.phone }, projections)
    } else {
        return { userData: null, token: null, message: "Incorrect mode for login" }
    }

    if (!user) {
        return { userData: null, token: null }
    };

    const userData = {
        id: user._id,
        userId: user?.email,
        phone: user?.phone,
        email: user?.email,
        name: user?.name,
    }

    // can be add password later

    token = getAccessToken(userData)
    let refreshToken = getRefreshToken(userData)

    let refreshBody = {
        userId: user._id,
        token: refreshToken
    }
    let tokenData
    tokenData = await dal.findOne(refreshTokenModel, { userId: user._id })
    if (tokenData) return { userData, token: null, message: "USER ALREADY LOGIN" }
    await dal.create(refreshTokenModel, refreshBody)

    return {
        userData,
        token: token,
        refreshToken: refreshToken
    }
}

exports.logout = async (filter) => {
    const data = await dal.findOneAndDelete(refreshTokenModel, filter)
    if (!data) return { message: "Already Logout", status: 400 }
    return { message: "Logout successful", status: 200 }
}