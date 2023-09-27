const Joi = require("joi");

const createProduct = Joi.object({
    name: Joi.string().trim(),
    description: Joi.string().trim(),
    status: Joi.string().valid("active", "inactive").default("active"),
    image: Joi.string().trim(),
    mfgDate: Joi.string().trim(),
    expDate: Joi.string().trim(),
    stock: Joi.number().default(1),
    price: Joi.number(),
    mode: Joi.string().valid("scanner", "manual"),
    barcode: Joi.string().trim()
});
const updateProduct = Joi.object({
    name: Joi.string().trim(),
    description: Joi.string().trim(),
    status: Joi.string().valid("active", "inactive").default("active"),
    mfgDate: Joi.string().trim(),
    expDate: Joi.string().trim(),
    stock: Joi.number().default(1),
    price: Joi.number(),
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