const mongoose = require('mongoose')
const Schema = mongoose.Schema

const spaceUserSchema = Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: "users"
    },
    spaceId: {
        type: Schema.Types.ObjectId,
        ref: "spaces"
    },
    roles: {
        type: String,
        enum: ["admin", "collaborator", "viewer"]
    },
    isLeave: {
        type: Boolean
    },
    status: {
        type: String,
        enum: ["active", "inactive"],
        default: "active"
    },
    active: {
        type: Boolean,
        default: false
    },
}, {
    timestamps: true
})

module.exports = mongoose.model("spaceUsers", spaceUserSchema);