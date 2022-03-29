const expressAsyncHandler = require("express-async-handler");
const moment = require("moment");
const _ = require("lodash");
const { PrismaClient } = require("@prisma/client");
const { storage } = require("../storage");
const prisma = new PrismaClient();
const {Tunggu} = require("../tunggu");
async function dataProductReportWeek() {
    /**@type [] */
    let resultWeek = [];

    let topProductWeek = await prisma.produk.findMany({
        select: {
            nama_pro: true,
            _count: {
                select: {
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


    for (let p of topProductWeek) {
        let { nama_pro, _count } = p
        let tottal = await prisma.bill.aggregate({
            _sum: {
                harga_pro: true
            },
            orderBy: {
                qty: "desc"
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
            "totalValue": tottal._sum.harga_pro
        }

        resultWeek.push(data)
    }

    let hasil = {
        "date": {
            "start": moment().startOf("week").format("YYYY-MM-DD"),
            "end": moment().endOf("week").format("YYYY-MM-DD")
        },
        "data": resultWeek
    }
    storage.setItem("productReportWeek", JSON.stringify(hasil, null, 2));
    console.log("productReportWeek saved");
    return hasil;

}

const ProductreportWeek = expressAsyncHandler(async (req, res) => {
    let data = storage.getItem("productReportWeek");
    if (data == null) {
        let result = await dataProductReportWeek();
        res.json({
            "success": true,
            "data": result
        })
    } else {
        res.json({
            "success": true,
            "data": JSON.parse(data)
        })
        if(!Tunggu.productReportWeek){
            Tunggu.productReportWeek = true;
            dataProductReportWeek();
            Tunggu.productReportWeek = false;
        }
    }

})

module.exports = { ProductreportWeek }