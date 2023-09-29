const { responseHandler } = require("../../middlewares/response-handler");
const service = require('../../service/product/product');
const { default: mongoose } = require("mongoose");
const { API_CALL } = require("../../utils/apiCall");
const { search } = require("../../queries/product");