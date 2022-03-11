const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const WhereHelper = require("./v2_where_helper");
const prisma = new PrismaClient();


const V2TotalRevenue = expressAsyncHandler(async(req, res) => {
    
    let data = await prisma.listbill.aggregate({
        _sum: {
            gtotal: true,
            total: true,
            net: true,
        },
        where: WhereHelper(req.query)
    })

    res.json({
        "gtotal": data._sum.gtotal,
        "total": data._sum.total,
        "net": data._sum.net
    });
});


module.exports = V2TotalRevenue