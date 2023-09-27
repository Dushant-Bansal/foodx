const Joi = require("joi");

const inviteUser = Joi.object({
    by: Joi.string().trim().required(),
    roles: Joi.string().valid("admin", "collaborator", "viewer").required(),
});

const defaults = {
    'abortEarly': false, // include all errors
    'allowUnknown': true, // ignore unknown props
    'stripUnknown': true // remove unknown props
};

const message = (error) => { return `${error.details.map(x => x.message).join(', ')}`; };

module.exports = {
    inviteUser,
    defaults,
    message
}