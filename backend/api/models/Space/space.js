const mongoose = require('mongoose')
const Schema = mongoose.Schema

const spaceSchema = Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: "users",
        index: true
    },
    name: {
        type: String,
        index: true
    },
    description: {
        type: String
    },
    status: {
        type: String,
        enum: ["active", "inactive"]
    },
    active: {
        type: Boolean,
        default: true
    },

}, {
    timestamps: true
})

module.exports = mongoose.model("spaces", spaceSchema);