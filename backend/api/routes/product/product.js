const router = require('express').Router();
const { verifyAccessToken } = require("../../middlewares/auth");

const validate = require('../../middlewares/validator');
const product = require('../../controllers/product/product')

const validatorSchema = require("../../validators/product/product")

router.route('/').post(verifyAccessToken, validate(validatorSchema.createProduct), product.create)
router.route('/').get(verifyAccessToken, product.getList);
router.route('/:id').put(verifyAccessToken, validate(validatorSchema.updateProduct),product.update);
router.route('/:id').delete(verifyAccessToken, product.deleteOne);
router.route('/hardDelete/:id').delete(verifyAccessToken, product.deleteOneHard);

module.exports = router;