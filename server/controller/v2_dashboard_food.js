const {PrismaClient} = require('@prisma/client');
const expressAsyncHandler = require('express-async-handler');
const V2DashboardHelper = require('./v2_dahboard_helper');
const prisma = new PrismaClient();

const V2DashboardFood = expressAsyncHandler(async (req, res) => {

    /**@type {V2ModelDashboardQuery} */
    let query = req.query;

    /**@type {String} */
    let tg2 = query.tgl2;

    /**@type {String} */
    let tg1 = query.tgl1;
    
    let where = {
        tanggal: {
            lte: new Date(tg2.includes(" ")? tg2.split(" ")[0]: tg2),
            gte: new Date(tg1.includes(" ")? tg1.split(" ")[0]: tg2)
        },
        cdept: query.dep,
        kode_out: query.out,
        bill: {
            every: {
                product: {
                    groupp: "FOOD"
                }
            }
        }
    };

    let hasil = await V2DashboardHelper(where, query);

    res.json(hasil);
});

module.exports = V2DashboardFood