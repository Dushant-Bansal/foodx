const dal = require('../../dal/dal')
const model = require('../../models/Space/space')

exports.create = async (body) => {
    return await dal.create(model, body);
};

exports.findOne = async (filter) => {
    return await dal.findOne(model, filter, {});
};

exports.find = async (filter) => {
    return await dal.find(model, filter, {});
};

exports.search = async (query) => {
    const data = await dal.aggregate(model, query);
    return {
        data: data[0].data,
        totalCount: data[0].count[0] ? data[0].count[0].count : 0
    };
};

exports.upsert = async (filter, body) => {
    if (body.values) {
        return await dal.findOneAndUpsert(model, filter, { $push: { values: body.values } });
    }
    return await dal.findOneAndUpsert(model, filter, body);
};
exports.update = async (filter, body) => {
    return await dal.findOneAndUpdate(model, filter, body);
};

exports.delete = async (id) => {
    return await dal.findOneAndUpdate(model, { _id: id }, { active: false });
};

exports.hardDelete = async (id) => {
    return await dal.findOneAndDelete(model, { _id: id });
};