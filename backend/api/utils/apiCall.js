const { default: axios } = require("axios");
// const { responseHandler } = require("../../middleware/response-handler");

exports.API_CALL = async (barcode) => {
    try {
        const response = await axios.get(
            `${process.env.BARCODE_URL}/products?barcode=${barcode}&formatted=${process.env.BARCODE_FORMATTED}&key=${process.env.BARCODE_API_KEY}`,
        );
        if (response.data) {
            return response
        }
    } catch (error) {
        if (error.response) {
            console.error('Error:', error.response.data);
        } else {
            console.error('Error:', error.message);
        }
        throw error;
    }
}