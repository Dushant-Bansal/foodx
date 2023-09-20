const Joi = require("joi");

const addUser = Joi.object({
    phone: Joi.string().trim(),
    userId: Joi.string().trim().required(),
    email: Joi.string().email().trim().required(),
    password: Joi.string().required()
});

const loginSchema = Joi.object({
    email: Joi.string().email(),
    phone: Joi.string().trim(),
    password: Joi.string()
});

const defaults = {
    'abortEarly': false, // include all errors
    'allowUnknown': true, // ignore unknown props
    'stripUnknown': true // remove unknown props
};

const message = (error) => { return `${error.details.map(x => x.message).join(', ')}`; };

module.exports = {
    addUser,
    loginSchema,
    defaults,
    message
}