const router = require('express').Router();
var multipart = require("connect-multiparty");
var multipartMiddleware = multipart();

const {
    getFile,
    deleteFile,
    getFileName
} = require("../controllers/upload");

const { verifyAccessToken } = require('../middlewares/auth');
const { connectBucket } = require('../middlewares/bucket');
const { upload } = require('../helpers/uploadBucket');


router.route('/').post(verifyAccessToken, connectBucket, upload.single("file"), getFileName);
router.route('/:filename').get(connectBucket, getFile);
// router.route('/').delete(verifyAccessToken, deleteFile);

module.exports = router;