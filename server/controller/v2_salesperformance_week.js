const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler")
const prisma = new PrismaClient();
const moment = require('moment');


const SalesPerformanceWeek = expressAsyncHandler(async (req, res) => {
   
    let tanggal = req.query.date?? Date.now()
    let weekStart = moment(tanggal).startOf('week');
    let weekEnd = moment(tanggal).endOf('week');

    let food = await prisma.listbill.groupBy({
        by: ["tanggal"],
        _sum: {
            total: true,
            gtotal: true,
            net: true
        },
        where: {
            bill: {
                every: {
                    product: {
                        groups: {
                            equals: "FOOD"
                        }
                    }
                }
            },
            tanggal: {
                gte: weekStart.toDate(),
                lte: weekEnd.toDate()
            }
        }
    })

    let beverage = await prisma.listbill.groupBy({
        by: ["tanggal"],
        _sum: {
            total: true,
            gtotal: true,
            net: true
        },
        where: {
            bill: {
                every: {
                    product: {
                        groups: {
                            equals: "BEVERAGE"
                        }
                    }
                }
            },
            tanggal: {
                gte: weekStart.toDate(),
                lte: weekEnd.toDate()
            }
        }
    })

    let other = await prisma.listbill.groupBy({
        by: ["tanggal"],
        _sum: {
            total: true,
            gtotal: true,
            net: true
        },
        where: {
            bill: {
                every: {
                    product: {
                        groups: {
                            notIn: ["BEVERAGE", "FOOD"]
                        }
                    }
                }
            },
            tanggal: {
                gte: weekStart.toDate(),
                lte: weekEnd.toDate()
            }
        }
    })

    res.json({
        "food": food.map((e) => {
            return {
                "gtotal": e._sum.gtotal,
                "net": e._sum.net,
                "total": e._sum.total,
                "tanggal": e.tanggal
            }
        }),
        "beverage": beverage.map((e) => {
            return {
                "gtotal": e._sum.gtotal,
                "net": e._sum.net,
                "total": e._sum.total,
                "tanggal": e.tanggal
            }
        }),
        "other": other.map((e) => {
            return {
                "gtotal": e._sum.gtotal,
                "net": e._sum.net,
                "total": e._sum.total,
                "tanggal": e.tanggal
            }
        })
    });
});


module.exports = SalesPerformanceWeek