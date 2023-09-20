const mongoose = require('mongoose')
const Schema = mongoose.Schema

const userSchema = Schema({
    name: {
        type: String,
        index: true
    },
    userId: {
        type: String,
        index: true
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
        default: "1 h"
    },
    spaceIds: {
        type: [
            {
                type: Schema.Types.ObjectId
            }
        ]
    }
}, {
    timestamps: true
})

module.exports = mongoose.model("users", userSchema);