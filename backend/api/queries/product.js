exports.search = (filter, pagination) => {
    try {

        const baseQuery = [
            {
                $match: {
                    ...filter,
                },
            },
        ];
        const dataQuery = [
            ...baseQuery,

            {
                $sort: {
                    createdAt: -1,
                    updatedAt: -1,
                },
            },
            {
                $skip: pagination?.skip || 0,
            },
            {
                $limit: pagination?.limit || 10,
            },
        ];

        const countQuery = [
            ...baseQuery,
            {
                $count: 'count'
            }
        ];

        return [
            {
                $facet: {
                    data: dataQuery,
                    count: countQuery,
                },
            },
        ];
    } catch (error) {
        console.error("error is ", err);
        errorHandler(null, res, "INTERNAL SERVER ERROR")
    }
};