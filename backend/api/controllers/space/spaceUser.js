const { responseHandler, clientHandler } = require("../../middlewares/response-handler");
const spaceService = require('../../service/space/space');
const service = require('../../service/space/spaceUsers');
const { default: mongoose } = require("mongoose");
const { search } = require("../../queries/space");

exports.create = async (req, res, next) => {
    try {
        const value = req.value;
        value.userId = req.user.id;
        let response;
        response = await service.find({ userId: value.userId })
        if (response >= 5) return clientHandler("Space unable to create, Max Limit reached to create your spaces !!", res);

        response = await service.create(value)

        if (!response) return clientHandler("Space unable to create", res);
        const body = {
            userId: value.userId,
            spaceId: response._id,
            roles: "admin"
        }
        await spaceUserService.create(body)

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

        let filter = { active: true, userId: new mongoose.Types.ObjectId(userId) };
        // handling pagination ...
        const pagination = { skip: 0, limit: 10 };
        if (queryFilter.pageNo && queryFilter.pageSize) {
            pagination.skip = parseInt((queryFilter.pageNo - 1) * queryFilter.pageSize);
            pagination.limit = parseInt(queryFilter.pageSize);
        };

        if (queryFilter.status) {
            filter["status"] = queryFilter.status
        }

        if (queryFilter.name) {
            filter["name"] = { $regex: queryFilter.name, $options: "i" };
        };

        if (queryFilter.userId) {
            filter["userId"] = { $in: queryFilter.userId.split(',').map(el => new mongoose.Types.ObjectId(el)) }
        };

        if (queryFilter.id) {
            filter["_id"] = { $in: queryFilter.id.split(',').map(el => new mongoose.Types.ObjectId(el)) }
        };

        const queries = search(filter, pagination);

        let response = await service.search(queries);

        responseHandler(response, res);

    } catch (error) {
        console.error(error)
        next(error)
    }
}