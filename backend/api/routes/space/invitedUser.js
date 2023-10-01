const router = require('express').Router();
const { verifyAccessToken } = require("../../middlewares/auth");

const validate = require('../../middlewares/validator');
const space = require('../../controllers/space/invitedUser')

const validatorSchema = require("../../validators/space/invitedUsers")

router.route('/').post(verifyAccessToken, validate(validatorSchema.inviteUser), space.create)
router.route('/').get(verifyAccessToken, space.getList);
router.route('/:id').put(verifyAccessToken, validate(validatorSchema.invitedUserUpdate), space.update);
router.route('/:id').delete(verifyAccessToken, space.deleteOne);
router.route('/hardDelete/:id').delete(verifyAccessToken, space.deleteOneHard);

module.exports = router;