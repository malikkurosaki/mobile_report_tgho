const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();
// moment js
const moment = require("moment");

const Revenue = expressAsyncHandler(async(req, res) => {

    // generate list month number
    const listMonth = [1,2,3,4,5,6,7,8,9,10,11,12];
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


    res.json({
        success: hasil.length > 0,
        data: hasil
    });

});

module.exports = {Revenue}