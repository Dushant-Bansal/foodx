const { responseHandler, errorHandler } = require("../../middlewares/response-handler");
const service = require('../../service/product/product');
const { default: mongoose } = require("mongoose");
const { API_CALL } = require("../../utils/apiCall");
const { search } = require("../../queries/product");

exports.create = async (req, res, next) => {
    try {
        const value = req.value;

        const userId = req.user.id;
        value.userId = userId;

        let response, data, body;

        if (value.mode === "scanner") {
            data = await API_CALL(value.barcode)
            body = {
                name: data?.data?.products[0]?.title,
                description: data?.data?.products[0]?.description,
                image: data?.data?.products[0]?.image,
                userId: userId,
                barcode: value.barcode,
                mode: value.mode,
                status: value.status,
                stock: value.stock
            }
            response = await service.create(body)
        } else if (value.mode === "manual") {
            response = await service.create(value)
        }

        responseHandler(response, res);

    } catch (error) {
        console.error("error is: ", error)
        next(error)
    }
}

exports.getList = async (req, res, next) => {
    try {
        let queryFilter = req.query ? req.query : {};

        let filter = { active: true };
        // handling pagination ...
        const pagination = { skip: 0, limit: 10 };
        if (queryFilter.pageNo && queryFilter.pageSize) {
            pagination.skip = parseInt((queryFilter.pageNo - 1) * queryFilter.pageSize);
            pagination.limit = parseInt(queryFilter.pageSize);
        };

        if (queryFilter.name) {
            filter["name"] = { $regex: queryFilter.name, $options: "i" };
        };

        if (queryFilter.id) {
            filter["_id"] = { $in: queryFilter.id.split(',').map(el => new mongoose.Types.ObjectId(el)) }
        };

        const queries = search(filter, pagination);

        let response = await service.aggregate(queries);

        responseHandler(response, res);

    } catch (error) {
        console.error("error is ", error);
        next(err);
    }
}

exports.update = async (req, res, next) => {
    try {
        const id = req.params.id;

        const value = req.value;

        const response = await service.update({ _id: id }, value)
        
        responseHandler(response, res);

    } catch (error) {
        console.error("error is ", error);
        next(err);
    }
}

exports.deleteOne = async (req, res, next) => {
    try {
        const id = req.params.id;

        const response = await service.delete(id);
        if (!response) {
            return responseHandler(null, res, "Error Occurred", 400);
        };

        responseHandler("deleted", res);

    } catch (error) {
        console.error("error is ", error);
        next(err);
    }
}
exports.deleteOneHard = async (req, res, next) => {
    try {
        const id = req.params.id;

        const response = await service.hardDelete(id);
        if (!response) {
            return responseHandler(null, res, "Error Occurred", 400);
        };

        responseHandler("deleted", res);

    } catch (error) {
        console.error("error is ", error);
        next(err);
    }
}