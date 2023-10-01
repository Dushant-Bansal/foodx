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
                $lookup: {
                    from: "spaceusers",
                    localField: "_id",
                    foreignField: "spaceId",
                    as: "spaceId",
                    pipeline: [
                        {
                            $match: {
                                active: true,
                            },
                        },
                        {
                            $project: {
                                userId: 1,
                                roles: 1,
                                isLeave: 1,
                                status: 1,
                            },
                        },
                        {
                            $lookup: {
                                from: "users",
                                localField: "userId",
                                foreignField: "_id",
                                pipeline: [
                                    {
                                        $project: {
                                            createdAt: 0,
                                            updatedAt: 0,
                                            password: 0,
                                            active: 0,
                                            notifyTime: 0,
                                            oAuth: 0,
                                            __v: 0,
                                        },
                                    },
                                ],
                                as: "userId",
                            },
                        },
                        {
                            $unwind: "$userId",
                        },
                    ],
                }
            },
            {
                $sort: {
                    createdAt: -1,
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