const Joi = require("joi");

const spaceUser = Joi.object({
    spaceId: Joi.string().trim().regex(/^[0-9a-fA-F]{24}$/, 'object Id').required(),
    roles: Joi.string().valid("admin", "collaborator", "viewer").default("viewer"),
});
const spaceUserUpdateSpace = Joi.object({
    spaceId: Joi.string().trim().regex(/^[0-9a-fA-F]{24}$/, 'object Id').required(),
});

const defaults = {
    'abortEarly': false, // include all errors
    'allowUnknown': true, // ignore unknown props
    'stripUnknown': true // remove unknown props
};

const message = (error) => { return `${error.details.map(x => x.message).join(', ')}`; };

module.exports = {
    spaceUser,
    spaceUserUpdateSpace,
    defaults,
    message
}