const router = require('express').Router();
const { verifyAccessToken } = require("../../middlewares/auth");

const validate = require('../../middlewares/validator');
const space = require('../../controllers/space/spaceUser')

const validatorSchema = require("../../validators/space/spaceUsers")

router.route('/').post(verifyAccessToken, validate(validatorSchema.spaceUser), space.create)
router.route('/').get(verifyAccessToken, space.getList);
// router.route('/space/:id').put(verifyAccessToken, space.updateSpace);
router.route('/product/:productId').put(verifyAccessToken, validate(validatorSchema.spaceUserUpdateSpace), space.updateProduct);
// router.route('/:id').delete(vererifyAccessToken, validate(vaifyAccessToken, space.deleteOne);
// router.route('/hardDelete/:id').delete(verifyAccessToken, space.deleteOneHard);

module.exports = router;