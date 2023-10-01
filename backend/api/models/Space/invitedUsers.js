const mongoose = require('mongoose')
const Schema = mongoose.Schema

const invitedUserSchema = Schema({
    by: {
        type: String
    },
    roles: {
        type: String,
        enum: ["collaborator", "viewer"]
    },
    spaceId: {
        type: Schema.Types.ObjectId,
        ref: "spaces"
    },
    addedBy: {
        type: Schema.Types.ObjectId,
        ref: "users"
    },
    status: {
        type: String,
        enum: ["pending", "joined", "rejected"]
    },
    active: {
        type: Boolean,
        default: true
    },
}, {
    timestamps: true
})

module.exports = mongoose.model("invitedUsers", invitedUserSchema);