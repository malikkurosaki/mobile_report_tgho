const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient()
const moment = require("moment");
const _ = require("lodash");
const { storage } = require("../storage");
const { Tunggu } = require("../tunggu");

async function dataProductReportYear() {
    let resultYear = [];
    let topProductYear = await prisma.produk.findMany({
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
                        gte: new Date(moment().startOf("year").format("YYYY-MM-DD")),
                        lte: new Date(moment().endOf("year").format("YYYY-MM-DD"))
                    }
                }
            }
        },
        take: 10
    })



    for (let p of topProductYear) {
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
            "totalValue": tottal._sum.harga_pro
        }

        resultYear.push(data)
    }

    let hasil = {
        "date": {
            "start": moment().startOf("year").format("YYYY-MM-DD"),
            "end": moment().endOf("year").format("YYYY-MM-DD")
        },
        "data": resultYear
    }

    storage.setItem("productReportYear", JSON.stringify(hasil, null, 2));
    console.log("productReportYear saved");
    return hasil;
}

const ProductReportYear = expressAsyncHandler(async (req, res) => {

    let data = storage.getItem("productReportYear");
    if (data == null) {
        data = await dataProductReportYear();
        res.json({
            success: true,
            data: data
        })
    } else {
        res.json({
            success: true,
            data: JSON.parse(data)
        })
        if (!Tunggu.productReportYear) {
            Tunggu.productReportYear = true;
            dataProductReportYear();
            Tunggu.productReportYear = false;
        }
    }


});

module.exports = { ProductReportYear }