const expressAsyncHandler = require("express-async-handler");
const moment = require("moment");
const _ = require("lodash");
const { PrismaClient } = require("@prisma/client");
const { storage } = require("../storage");
const prisma = new PrismaClient();

async function dataTotalListBillReport() {
    let year = await prisma.listbill.count({
        where: {
            tanggal: {
                gte: new Date(moment().startOf("year").format("YYYY-MM-DD")),
                lte: new Date(moment().endOf("year").format("YYYY-MM-DD"))
            }
        }
    })

    let monnt = await prisma.listbill.count({
        where: {
            tanggal: {
                gte: new Date(moment().startOf("month").format("YYYY-MM-DD")),
                lte: new Date(moment().endOf("month").format("YYYY-MM-DD"))
            }
        }
    })

    let week = await prisma.listbill.count({
        where: {
            tanggal: {
                gte: new Date(moment().startOf("week").format("YYYY-MM-DD")),
                lte: new Date(moment().endOf("week").format("YYYY-MM-DD"))
            }
        }
    })

    let day = await prisma.listbill.count({
        where: {
            tanggal: {
                gte: new Date(moment().startOf("day").format("YYYY-MM-DD")),
                lte: new Date(moment().endOf("day").format("YYYY-MM-DD"))
            }
        }
    })

    let data = {
        "year": {
            "name": "year",
            "time": {
                "start": moment().startOf("year").format("YYYY-MM-DD"),
                "end": moment().endOf("year").format("YYYY-MM-DD")
            },
            "count": year
        },
        "month": {
            "name": "month",
            "time": {
                "start": moment().startOf("month").format("YYYY-MM-DD"),
                "end": moment().endOf("month").format("YYYY-MM-DD")
            },
            "count": monnt
        },
        "week": {
            "name": "week",
            "time": {
                "start": moment().startOf("week").format("YYYY-MM-DD"),
                "end": moment().endOf("week").format("YYYY-MM-DD")
            },
            "count": week
        },
        "day": {
            "name": "day",
            "time": {
                "start": moment().startOf("day").format("YYYY-MM-DD"),
                "end": moment().endOf("day").format("YYYY-MM-DD")
            },
            "count": day
        }
    }

    storage.setItem("totalListBillReport", JSON.stringify(data, null, 2));
    console.log("totalListBillReport saved");
    return data;
}
const TotalListBillreport = expressAsyncHandler(async (req, res) => {
   let data = storage.getItem("totalListBillReport");
    if (data == null) {
        res.json({
            success: true,
            data: await dataTotalListBillReport()
        })
    } else {
        res.json({
            success: true,
            data: JSON.parse(data)

        });
        dataTotalListBillReport();
    }
})

module.exports = { TotalListBillreport }