const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();
// moment js
const moment = require("moment");
const { storage } = require("../storage");

async function dataRevenueReport() {

    // generate list month number
    const listMonth = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    // this month
    const thisMonth = moment().format("MM");

    /**@type [] */
    let hasil = [];

    for (let i = 0; i < thisMonth; i++) {
        const month = listMonth[i];
        // get year number
        const year = moment().format("YYYY");
        const startDate = moment().month(month).year(year).startOf("month").format("YYYY-MM-DD");
        const endDate = moment().month(month).year(year).endOf("month").format("YYYY-MM-DD");
        const revenue = await prisma.listbill.aggregate({
            _sum: {
                total: true
            },
            where: {
                tanggal: {
                    gte: new Date(startDate),
                    lte: new Date(endDate)
                }
            }
        });
        hasil.push({
            month: month,
            revenue: revenue._sum.total
        });
    }

    storage.setItem("revenue", JSON.stringify(hasil, null, 2));
    console.log("revenue report saved");
    return hasil;
}

const Revenue = expressAsyncHandler(async(req, res) => {
    let data = storage.getItem("revenue");  
    if(data == null){
        res.json({
            success: true,
            data: await dataRevenueReport()
        })
    }else{
        res.json({
            success: true,
            data: JSON.parse(data)
        })
        dataRevenueReport();
    }


});

module.exports = {Revenue}