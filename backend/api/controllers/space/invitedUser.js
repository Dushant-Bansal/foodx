const { responseHandler, clientHandler } = require("../../middlewares/response-handler");
const spaceService = require('../../service/space/space');
const service = require('../../service/space/invitedUsers');
const { default: mongoose } = require("mongoose");
const { search } = require("../../queries/invitedUsers");

exports.create = async (req, res, next) => {
    try {
        const value = req.value;
        value.addedBy = req.user.id;

        let response
        response = await service.findOne({ spaceId: value.spaceId })
        if (response) return clientHandler("Invite Already Sent", res)

        response = await service.create(value)
        if (!response) return clientHandler("Not able to sent the invite", res)

        responseHandler(response, res)
    } catch (error) {
        console.error(error)
        next(error)
    }
}

exports.getList = async (req, res, next) => {
    try {
        let queryFilter = req.query ? req.query : {};
        const userId = req.user.id

        let filter = { active: true, addedBy: new mongoose.Types.ObjectId(userId) };

        // handling pagination ...
        const pagination = { skip: 0, limit: 100 };
        if (queryFilter.pageNo && queryFilter.pageSize) {
            pagination.skip = parseInt((queryFilter.pageNo - 1) * queryFilter.pageSize);
            pagination.limit = parseInt(queryFilter.pageSize);
        };

        if (queryFilter.roles) {
            filter["roles"] = queryFilter.roles
        }
        if (queryFilter.spaceId) {
            filter["spaceId"] = { $in: queryFilter.spaceId.split(',').map(el => new mongoose.Types.ObjectId(el)) }
        };

        const queries = search(filter, pagination);

        let response = await service.search(queries);

        responseHandler(response, res)
    } catch (error) {
        console.error(error)
        next(error)
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
        next(error);
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
        console.error(error)
        next(error)
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
        next(error);
    }
}