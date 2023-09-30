const mongoose = require("mongoose");

let bucket;
mongoose.connection.on("connected", () => {
    var db = mongoose.connections[0].db;
    bucket = new mongoose.mongo.GridFSBucket(db, {
        bucketName: process.env.DB_BUCKET
    });
});

exports.connectBucket = async (req, res, next) => {
    req.bucket = bucket;
    next();
}