const Joi = require("joi");

const inviteUser = Joi.object({
    by: Joi.string().trim().required(),
    spaceId: Joi.string().trim().regex(/^[0-9a-fA-F]{24}$/, 'object Id').required(),
    roles: Joi.string().valid("collaborator", "viewer").required(),
    status: Joi.string().trim().valid("pending", "joined", "rejected").default("pending")
});
const invitedUserUpdate = Joi.object({
    spaceId: Joi.string().trim().regex(/^[0-9a-fA-F]{24}$/, 'object Id'),
    roles: Joi.string().valid("collaborator", "viewer"),
    status: Joi.string().trim().valid("pending", "joined", "rejected").default("pending")
});

const defaults = {
    'abortEarly': false, // include all errors
    'allowUnknown': true, // ignore unknown props
    'stripUnknown': true // remove unknown props
};

const message = (error) => { return `${error.details.map(x => x.message).join(', ')}`; };

module.exports = {
    inviteUser,
    invitedUserUpdate,
    defaults,
    message
}