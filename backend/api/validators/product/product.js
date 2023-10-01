const Joi = require("joi");

const createProduct = Joi.object({
    name: Joi.string().trim().required(),
    description: Joi.string().trim().required(),
    status: Joi.string().valid("active", "expired"),
    image: Joi.string().trim().required(),
    mfgDate: Joi.string().trim(),
    expDate: Joi.string().trim(),
    stock: Joi.number().default(1),
    price: Joi.number(),
    mode: Joi.string().valid("scanner", "manual").required(),
    barcode: Joi.string().trim()
});
const updateProduct = Joi.object({
    name: Joi.string().trim(),
    description: Joi.string().trim(),
    status: Joi.string().valid("active", "expired"),
    mfgDate: Joi.string().trim(),
    expDate: Joi.string().trim(),
    stock: Joi.number().default(1),
    price: Joi.number(),
    isShop: Joi.bool(),
});

const defaults = {
    'abortEarly': false, // include all errors
    'allowUnknown': true, // ignore unknown props
    'stripUnknown': true // remove unknown props
};

const message = (error) => { return `${error.details.map(x => x.message).join(', ')}`; };

module.exports = {
    createProduct,
    updateProduct,
    defaults,
    message
}