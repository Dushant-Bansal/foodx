const mongoose = require('mongoose')
const Schema = mongoose.Schema

const userSchema = Schema({
    name: {
        type: String,
        index: true
    },
    userName: {
        type: String,
        index: true
    },
    password: {
        type: String
    },
    email: {
        type: String,
        index: true
    },
    countryCode: {
        type: String
    },
    phone: {
        type: String,
        index: true
    },
    active: {
        type: Boolean,
        default: false
    },
    notifyTime: {
        type: String,
        default: "3 hrs"
    },
    mode: {
        type: String,
        enum: ["phone", "email", "oAuth"]
    },
    oAuth: {
        type: String
    }
}, {
    timestamps: true
})

module.exports = mongoose.model("users", userSchema);