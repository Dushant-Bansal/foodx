const mongoose = require('mongoose')
const Schema = mongoose.Schema

const invitedUserSchema = Schema({
    by: {
        type: String
    },
    roles: {
        type: String,
        enum: ["admin", "collaborator", "viewer"]
    },
    active: {
        type: Boolean,
        default: false
    },
}, {
    timestamps: true
})

module.exports = mongoose.model("invitedUsers", invitedUserSchema);