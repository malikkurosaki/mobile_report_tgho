const expressAsyncHandler = require("express-async-handler");
const moment = require("moment");
const _ = require("lodash");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const ProductreportWeek = expressAsyncHandler(async (req, res) => {
    let topProductWeek = await prisma.produk.findMany({
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
                        gte: new Date(moment().startOf("week").format("YYYY-MM-DD")),
                        lte: new Date(moment().endOf("week").format("YYYY-MM-DD"))
                    }
                }
            }
        },
        take: 20
    })

    let resultWeek = []
    for(let p of topProductWeek ){
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

        resultWeek.push(data)
    }

    res.json(resultWeek)
})

module.exports = {ProductreportWeek}