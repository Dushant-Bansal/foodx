const Joi = require("joi");

const spaceUser = Joi.object({
    name: Joi.string().trim().required(),
    description: Joi.string().trim().required(),
    status: Joi.string().valid("active", "inactive").default("active"),
});

const spaceUpdateUser = Joi.object({
    name: Joi.string().trim(),
    description: Joi.string().trim(),
    status: Joi.string().valid("active", "inactive").default("active"),
});

const defaults = {
    'abortEarly': false, // include all errors
    'allowUnknown': true, // ignore unknown props
    'stripUnknown': true // remove unknown props
};

const message = (error) => { return `${error.details.map(x => x.message).join(', ')}`; };

module.exports = {
    spaceUser,
    spaceUpdateUser,
    defaults,
    message
}