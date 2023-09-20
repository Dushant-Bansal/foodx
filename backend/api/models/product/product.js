const mongoose = require('mongoose')
const Schema = mongoose.Schema

const productSchema = Schema({
    name: {
        type: String,
        index: true
    },
    image:{
        type:String,
    },
    productId: {
        type: String,
        index: true
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
        default: false,
        index: true
    },
    status: {
        type: String,
        enum: ["active", "expired"],
        default: "active",
        index: true
    },
    stock: {
        type: Number
    },
    addedBy: {
        type: Schema.Types.ObjectId
    },
    isShop: {
        type: Boolean,
        default: false
    },
    isSpace: {
        type: Boolean,
        default: false
    },
    spaceIds: {
        type: Schema.Types.ObjectId
    }
}, {
    timestamps: true
})

module.exports = mongoose.model("products", productSchema);