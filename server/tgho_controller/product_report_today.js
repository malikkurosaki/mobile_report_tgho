const expressAsyncHandler = require("express-async-handler");
const moment = require("moment");
const _ = require("lodash");
const { PrismaClient } = require("@prisma/client");
const { storage } = require("../storage");
const prisma = new PrismaClient();

async function dataProductReportToday() {

    /**@type [] */
    let resultToday = [];

    let topProductToday = await prisma.produk.findMany({
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
                        gte: new Date(moment().startOf("day").format("YYYY-MM-DD")),
                        lte: new Date(moment().endOf("day").format("YYYY-MM-DD"))
                    }
                }
            }
        },
        take: 20
    })



    for (let p of topProductToday) {
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

        resultToday.push(data)
    }

    let hasil = {
        "date": {
            "start": moment().startOf("day").format("YYYY-MM-DD"),
            "end": moment().endOf("day").format("YYYY-MM-DD")
        },
        "data": resultToday
    }

    storage.setItem("productReportToday", JSON.stringify(hasil));
    console.log("productReportToday saved");
    return hasil;
    
}

const ProductReportToday = expressAsyncHandler(async (req, res) => {
    const data = storage.getItem("productReportToday");
    if(data == null){
        let hasil = await dataProductReportToday();
        res.json({
            success: true,
            data: hasil
        })
    }else{
        res.json({
            success: true,
            data: JSON.parse(data)
        })
        if(!Tunggu.productReportToday){
            Tunggu.productReportToday = true;
            dataProductReportToday();
            Tunggu.productReportToday = false;
        }
    }
})

module.exports = { ProductReportToday }