const model = require('../../models/auth/user');
const refreshTokenModel = require("../../models/auth/refreshToken");
const dal = require('../../dal/dal');
const bcrypt = require('bcryptjs');
const { getAccessToken, getRefreshToken, generateUsername } = require('../../helpers/helper');
require('dotenv').config();


exports.findOne = async (filter) => {
    return await dal.findOne(model, filter, {});
};

exports.addUser = async (value) => {
    let token;
    value.password = await bcrypt.hash(value.password, 10);
    value.userName = generateUsername(value.name)
    let count
    if (value.email) {
        count = await dal.find(model, { email: value.email }, { limit: 1 }, { email: -1 })
        if (count.length > 0) {
            return { userData: null, token: null, message: "User Already exist with this email" }
        }
    } else if (value.phone) {
        count = await dal.find(model, { phone: value.phone }, { limit: 1 }, { email: -1 })
        if (count.length > 0) {
            return { userData: null, token: null, message: "User Already exist with this phone" }
        }
    } else {
        return { userData: null, token: null, message: "Invalid mode to signup" }
    }

    const data = await dal.create(model, value)
    const body = {
        id: data._id,
        userName: data.userName,
        name: data.nama,
        email: data?.email || null,
        phone: data?.phone || null,
        active: data.active
    };
    token = getAccessToken(body);
    let refreshToken = getRefreshToken(body);

    let refreshBody = {
        userId: data._id,
        token: refreshToken
    }

    await dal.create(refreshTokenModel, refreshBody);

    return {
        userData: body, token: token,
        refreshToken: refreshToken,
    }
}

exports.login = async (value) => {
    let token;
    const projections = {
        email: 1,
        name: 1,
        userName: 1,
        phone: 1,
        password: 1,
    }
    let user;

    if (value.mode === "Oauth") {
        value.active = true;
        user = await dal.findOneAndUpsert(model, { email: value.email }, value)
        // user = await dal.findOne(model, { email: value.email }, projections)
    } else if (value.mode === "email") {
        user = await dal.findOne(model, { email: value.email }, projections)
        if (value.password) {
            const result = await bcrypt.compare(value.password, user.password);
            if (!result) return { userData: null, token: null, message: "Please double check the credentials" }
        }
    } else if (value.mode === "phone") {
        user = await dal.findOne(model, { phone: value.phone }, projections)
        if (value.password) {
            const result = await bcrypt.compare(value.password, user.password);
            if (!result) return { userData: null, token: null, message: "Please double check the credentials" }
        }
    } else {
        return { userData: null, token: null, message: "Incorrect mode for login" }
    }

    if (!user) {
        return { userData: null, token: null }
    };

    const userData = {
        id: user._id,
        userName: user?.userName,
        phone: user?.phone,
        email: user?.email,
        name: user?.name,
        oAuth: user.oAuth || null
    }

    token = getAccessToken(userData)
    let refreshToken = getRefreshToken(userData)

    let refreshBody = {
        userId: user._id,
        token: refreshToken
    }
    let tokenData
    tokenData = await dal.findOne(refreshTokenModel, { userId: user._id })
    if (tokenData && value.mode !== "Oauth") return { userData, token: null, message: "USER ALREADY LOGIN" }
    if (value.mode === "Oauth") await dal.findOneAndUpsert(refreshTokenModel, { userId: user._id }, refreshBody)
    if (!tokenData && value.mode !== "Oauth") await dal.create(refreshTokenModel, { userId: user._id }, refreshBody)


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