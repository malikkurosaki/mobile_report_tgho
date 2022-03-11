const { PrismaClient, Prisma } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();
const moment = require("moment");

/**@type Prisma.ListbillAggregateArgs */
const options = {
    _avg: {
        total: true,
        net: true
    },
}

const YearReport = expressAsyncHandler(async (req, res) => {
    let year = await prisma.listbill.aggregate({
        _avg: options._avg,
        where: {
            tanggal: {
                gte: new Date(moment().startOf('year').format("YYYY-MM-DD")),
                lte: new Date(moment().endOf('year').format("YYYY-MM-DD"))
            }
        }

    })

    let month = await prisma.listbill.aggregate({
        _avg: options._avg,
        where: {
            tanggal: {
                gte: new Date(moment().startOf('month').format("YYYY-MM-DD")),
                lte: new Date(moment().endOf('month').format("YYYY-MM-DD"))
            }
        }
    })

    let week = await prisma.listbill.aggregate({
        _avg: options._avg,
        where: {
            tanggal: {
                gte: new Date(moment().startOf('week').format("YYYY-MM-DD")),
                lte: new Date(moment().endOf('week').format("YYYY-MM-DD"))
            }
        }
    })


    res.json({
        "year": {
            "first": moment().startOf('year').format("YYYY-MM-DD"),
            "last": moment().endOf('year').format("YYYY-MM-DD"),
            "data": year
        },
        "month": {
            "first": moment().startOf('month').format("YYYY-MM-DD"),
            "last": moment().endOf('month').format("YYYY-MM-DD"),
            "data": month
        },
        "week": {
            "first": moment().startOf('week').format("YYYY-MM-DD"),
            "last": moment().endOf('week').format("YYYY-MM-DD"),
            "data": week
        }
    })

})

module.exports = { YearReport };