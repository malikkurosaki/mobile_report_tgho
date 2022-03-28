const { PrismaClient, Prisma } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();
const moment = require("moment");
const { storage } = require("../storage");

const map = {
    total: true,
    net: true,
    gtotal: true,
    taxrp: true,
    pax: true,
}

// /**@type Prisma.ListbillAggregateArgs */
// const options = {
//     _avg: {
//         total: true,
//         net: true
//     },
//     _count: map
// }

async function dataYearReport(){
    let year = await prisma.listbill.aggregate({
        _avg: map,
        _count: map,
        _max: map,
        _min: map,
        _sum: map,
        where: {
            tanggal: {
                gte: new Date(moment().startOf('year').format("YYYY-MM-DD")),
                lte: new Date(moment().endOf('year').format("YYYY-MM-DD"))
            }
        }

    })

    let month = await prisma.listbill.aggregate({
        _avg: map,
        _count: map,
        _max: map,
        _min: map,
        _sum: map,

        where: {
            tanggal: {
                gte: new Date(moment().startOf('month').format("YYYY-MM-DD")),
                lte: new Date(moment().endOf('month').format("YYYY-MM-DD"))
            }
        }
    })

    let week = await prisma.listbill.aggregate({
        _avg: map,
        _count: map,
        _max: map,
        _min: map,
        _sum: map,
        where: {
            tanggal: {
                gte: new Date(moment().startOf('week').format("YYYY-MM-DD")),
                lte: new Date(moment().endOf('week').format("YYYY-MM-DD"))
            }
        }
    })

    let day = await prisma.listbill.aggregate({
        _avg: map,
        _count: map,
        _max: map,
        _min: map,
        _sum: map,
        where: {
            tanggal: {
                gte: new Date(moment().startOf('day').format("YYYY-MM-DD")),
                lte: new Date(moment().endOf('day').format("YYYY-MM-DD"))
            }
        }
    })

    let data = {
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
        },
        "day": {
            "first": moment().startOf('day').format("YYYY-MM-DD"),
            "last": moment().endOf('day').format("YYYY-MM-DD"),
            "data": day
        }
    }

    storage.setItem("year_report", JSON.stringify(data, null, 2));
    console.log("year_report saved");
    return data;
}

const YearReport = expressAsyncHandler(async (req, res) => {
    let data = storage.getItem("year_report");
    if (data == null) {
        let hasil = await dataYearReport();
        res.json({
            success: true,
            data: hasil
        })
    }
    else {
        res.json({
            success: true,
            data: JSON.parse(data)
        });
        if(!Tunggu.yearReport){
            Tunggu.yearReport = true;
            dataYearReport();
            Tunggu.yearReport = false;
        }
    }

})

module.exports = { YearReport };