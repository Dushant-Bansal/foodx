const { responseHandler, clientHandler } = require("../../middlewares/response-handler");
const spaceService = require('../../service/space/space');
const productService = require('../../service/product/product');
const userService = require('../../service/auth/user');
const invitedUsersService = require('../../service/space/invitedUsers');
const service = require('../../service/space/spaceUsers');
const { default: mongoose } = require("mongoose");
const { search } = require("../../queries/spaceUsers");

exports.create = async (req, res, next) => {
    try {
        const value = req.value
        const userId = req.user.id

        let data, response, user;

        user = await userService.findOne({ _id: userId })
        if (!user) return clientHandler("Not in the Database", res)

        data = await invitedUsersService.findOne({ by: user.email, spaceId: value.spaceId })
        if (!data) {
            data = await invitedUsersService.findOne({ by: user.phone, spaceId: value.spaceId })
            if (!data) return clientHandler("You'r not invited in this space", res)
        }

        response = await spaceService.findOne({ _id: value.spaceId })
        if (!response) return clientHandler("Space not exist", res)

        response = await service.findOne({ userId: userId, spaceId: value.spaceId })
        if (response) return clientHandler("You'r already here in this space !!", res)

        const body = {
            spaceId: value.spaceId,
            userId: userId,
            roles: data.roles,
        }

        response = await service.create(body)
        if (!response) return clientHandler("Not able to add in this space")
        await invitedUsersService.update({ by: data.by, spaceId: value.spaceId }, { roles: "joined" })

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

        let filter = { active: true };
        // handling pagination ...
        const pagination = { skip: 0, limit: 100 };
        if (queryFilter.pageNo && queryFilter.pageSize) {
            pagination.skip = parseInt((queryFilter.pageNo - 1) * queryFilter.pageSize);
            pagination.limit = parseInt(queryFilter.pageSize);
        };
        if (queryFilter.roles) {
            filter["roles"] = queryFilter.roles
        }
        if (queryFilter.status) {
            filter["status"] = queryFilter.status
        }

        if (queryFilter.isLeave) {
            filter["isLeave"] = queryFilter.isLeave === "true" ? true : false
        }

        if (queryFilter.id) {
            filter["_id"] = { $in: queryFilter.id.split(',').map(el => new mongoose.Types.ObjectId(el)) }
        };

        if (queryFilter.spaceId) {
            filter["spaceId"] = { $in: queryFilter.spaceId.split(',').map(el => new mongoose.Types.ObjectId(el)) }
        };

        const queries = search(filter, pagination);

        let response = await service.search(queries);

        responseHandler(response, res);
    } catch (error) {
        console.error(error)
        next(error)
    }
}


exports.updateSpace = async (req, res, next) => {
    try {
        const id = req.params.id;

        const value = req.value;
        let response;

        response = await service.findOne({ _id: id })
        if (response.roles !== "admin") return clientHandler("Not allowed to do changes", res)

        response = await spaceService.update({ _id: response.spaceId }, value)

        responseHandler(response, res);

    } catch (error) {
        console.error("error is ", error);
        next(error);
    }
}

exports.updateProduct = async (req, res, next) => {
    try {
        const { id, productId } = req.params;

        const value = req.value;
        let response;

        response = await service.findOne({ _id: id })
        if (response.roles === "viewer") return clientHandler("Not allowed to do changes", res)
        response = await productService.findOne({ _id: productId, active: true })
        const body = {
            isSpace: !response.isSpace,
            spaceId: response.isSpace ? value.spaceId : null
        }
        response = await productService.update({ _id: productId, active: true }, body)
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
        console.error("error is ", error);
        next(error);
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