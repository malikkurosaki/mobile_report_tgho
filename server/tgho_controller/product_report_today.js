const expressAsyncHandler = require("express-async-handler");
const moment = require("moment");
const _ = require("lodash");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const ProductReportToday = expressAsyncHandler(async (req, res) => {
    let topProductToday = await prisma.produk.findMany({
        select: {
            nama_pro: true,
            _count: {
                select:{
                    bill: true
                }
            }
        },
        orderBy: {
            bill: {
                _count: "desc"
            }
        },
        where: {
            bill: {
                every: {
                    tanggal: {
                        gte: new Date(moment().startOf("day").format("YYYY-MM-DD")),
                        lte: new Date(moment().endOf("day").format("YYYY-MM-DD"))
                    }
                }
            }
        },
        take: 20
    })

    let resultToday = []
    for(let p of topProductToday ){
        let { nama_pro, _count } = p
        let tottal = await prisma.bill.aggregate({
            _sum: {
                harga_pro: true
            },
            where: {
                Produk: {
                    nama_pro: nama_pro
                }
            }
        })

        let data = {
            "nama_pro": nama_pro,
            "totalBill": _count.bill,
            "tottalValue": tottal._sum.harga_pro
        }

        resultToday.push(data)
    }

    res.json(resultToday)
})

module.exports = {ProductReportToday}