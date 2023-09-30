const mongoose = require('mongoose')
const Schema = mongoose.Schema

const productSchema = Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: "users"
    },
    name: {
        type: String,
        index: true
    },
    image: {
        type: String,
    },
    description: {
        type: String,
    },
    mfgDate: {
        type: Date
    },
    expDate: {
        type: Date
    },
    active: {
        type: Boolean,
        default: true,
        index: true
    },
    status: {
        type: String,
        enum: ["active", "expired"],
        default: "active",
        index: true
    },
    mode: {
        type: String,
        enum: ["scanner", "manual"],
        default: "manual",
    },
    stock: {
        type: Number
    },
    isShop: {
        type: Boolean,
        default: false
    },
    isSpace: {
        type: Boolean,
        default: false
    },
    spaceId: {
        type: Schema.Types.ObjectId,
        ref: "spaces"
    },
    price: {
        type: Number
    },
    barcode: {
        type: String
    }
}, {
    timestamps: true
})

module.exports = mongoose.model("products", productSchema);