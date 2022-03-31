const express = require('express');
const Api = express.Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const expresAsyncHandler = require('express-async-handler');
const lodash = require('lodash');
const moment = require('moment');
const _ = require('lodash');
const TotalRevenue = require('./controller/total_revenue');
const RevenueByGroup = require('./controller/revenue_by_group');
const AvarageBillPax = require('./controller/avarage_bill_pax');
const ComplimentGross = require('./controller/compliment_gross');
const SalesPerformance = require('./controller/sales_performance');
const SalesAnalisisByAvarageBill = require('./controller/sales_analisis_by_avarage_bill');
const SalesTimeCategory = require('./controller/sales_time_category');


Api.get('/display/:param', expresAsyncHandler(async (req, res) => {
    let param = req.params.param;

    /**@type {import('./models').DashboardQuery} */
    let query = req.query;

    switch (param) {
        case "dash":
            let data = await RevenueByGroup({
                cdep: query.dep,
                out: query.out,
                tgl1: query.tgl1,
                tgl2: query.tgl2
            })
            res.json(data);
            break;
        case "totalRevenue":
            let tot = await TotalRevenue({
                cdep: query.dep,
                out: query.out,
                tgl1: query.tgl1,
                tgl2: query.tgl2
            });
            res.json(tot)
            break;
        case "avarageBillPax":
            let avg = await AvarageBillPax({
                cdep: query.dep,
                out: query.out,
                tgl1: query.tgl1,
                tgl2: query.tgl2
            });
            res.json(avg);
            break
        case "complimentGross":
            let com = await ComplimentGross({
                cdep: query.dep,
                out: query.out,
                tgl1: query.tgl1,
                tgl2: query.tgl2
            })

            res.json(com);
            break
        case "salesPerformance":
            let sp = await SalesPerformance({
                cdep: query.dep,
                out: query.out,
                tgl1: query.tgl1,
                tgl2: query.tgl2
            })

            res.json(sp)
            break;
        case "salesAvarage":
            let avgS = await SalesAnalisisByAvarageBill({
                cdep: query.dep,
                out: query.out,
                tgl1: query.tgl1,
                tgl2: query.tgl2
            })
            res.json(avgS)
            break;
        case "salesTimeCategory":
            let stc = await SalesTimeCategory({
                tgl1: query.tgl1,
                tgl2: query.tgl2,
                cdep: query.dep,
                out: query.out
            });

            res.json(stc)
            break;
        case "bestProduct":
            Log("best product");
            res.json(await BestProduct({ req, res, where }))
            break;
        default: res.send("hahah error kayanya , gk cocok tuh ... hemm")
    }


}));

// Api.get('/register', expresAsyncHandler(async (req, res) => {
//     const body = req.query;
//     const data = await prisma.auth.create({
//         data: {
//             email: body.email,
//             name: body.userName,
//             password: body.password
//         }
//     });

//     let success = data != null;
//     res.json({
//         success: success,
//         data: data
//     })

// }));

// Api.post('/login', expresAsyncHandler(async (req, res) => {

//     /**@type {import('./models').ModelUser} */
//     const data = req.body

//     /**@type {import('./models').ModelUser} */
//     const query = {
//         email: data.email,
//         password: data.password
//     }
    

//     const usr = await prisma.auth.findFirst({
//         where: {
//             email: query.email,
//             password: query.password
//         }
//     })

//     const success = usr != null

//     res.json({
//         success: success,
//         data: usr
//     });

// }))

/**@param {import('./models').Parameter} param */
// async function dashboard(param) {
//     let option = (opt) => {
//         let mdl = {
//             _sum: {
//                 total: true,
//                 pax: true,
//                 net: true,
//                 taxrp: true,
//                 serrp: true,
//                 gtotal: true,
//                 cash: true,
//             },
//             _avg: {
//                 total: true,
//                 pax: true,
//                 net: true,
//                 taxrp: true,
//                 serrp: true,
//                 gtotal: true,
//                 cash: true,
//             },
//             _count: {
//                 total: true,
//                 pax: true,
//                 net: true,
//                 taxrp: true,
//                 serrp: true,
//                 gtotal: true,
//                 cash: true,
//             },
//             where: {
//                 bill: {
//                     every: {
//                         product: {

//                         }
//                     }
//                 },
//                 tanggal: {
//                     lte: new Date(param.query.tgl2),
//                     gte: new Date(param.query.tgl1)
//                 },
//                 cdept: param.query.dep,
//                 kode_out: param.query.out
//             }
//         }

//         if (param.query.out == "All" || param.query.out == null) delete mdl.where.kode_out
//         if (param.query.dep == "All" || param.query.dep == null) delete mdl.where.cdept

//         if (opt == 0) {
//             mdl.where.bill.every.product['groupp'] = "FOOD"
//         } else if (opt == 1) {
//             mdl.where.bill.every.product['groupp'] = "BEVERAGE"
//         } else {
//             mdl.where.bill.every.product['groupp'] = {
//                 notIn: ["FOOD", "BEVERAGE"]
//             }
//         }

//         return mdl;
//     }

//     let food = await prisma.listbill.aggregate(option(0))

//     let beverage = await prisma.listbill.aggregate(option(1))

//     let other = await prisma.listbill.aggregate(option(2))

//     let hasil = [
//         {
//             "name": "food",
//             "data": food
//         },
//         {
//             "name": "beverage",
//             "data": beverage
//         },
//         {
//             "name": "other",
//             "data": other
//         }
//     ]


//     // let hasil = {
//     //     "food": food._sum,
//     //     "beverage": beverage._sum,
//     //     "other": other._sum

//     // }

//     // let data = await prisma.groupp.groupBy({
//     //     by: ["nm_groupp"],
//     // })

//     // let hasil = [];
//     // for (let d of data) {

//     //     let whereListbill = {
//     //         bill: {
//     //             every: {
//     //                 product: {
//     //                     groupp: d.nm_groupp
//     //                 }
//     //             }
//     //         },
//     //         kode_out: param.where.outlet.kode_out,
//     //         cdept: param.where.departement.cdept,
//     //         tanggal: {
//     //             gte: param.where.tanggal.gte,
//     //             lte: param.where.tanggal.lte
//     //         }
//     //     }

//     //     if(param.where.departement.cdept == null) delete whereListbill.cdept
//     //     if(param.where.outlet.kode_out == null) delete whereListbill.kode_out;

//     //     let hsl = await prisma.listbill.aggregate({
//     //         _sum: {
//     //             total: true,
//     //             net: true,
//     //         },
//     //         _avg: {
//     //             total: true
//     //         },
//     //         where: whereListbill

//     //     })

//     //     let modelData = {
//     //         group: d.nm_groupp.toString().trim(),
//     //         total: hsl._sum.total,
//     //         net: hsl._sum.net,
//     //         prosentase: Math.round(hsl._sum.net / hsl._sum.total * 100)
//     //     }

//     //     hasil.push(modelData)
//     // }

//     // delete param.where.bill
//     // let jumblah = await prisma.listbill.aggregate({
//     //     _sum: {
//     //         total: true,
//     //         net: true,
//     //         pax: true
//     //     },
//     //     _count: {
//     //         total: true
//     //     },
//     //     where: {
//     //         tanggal: {
//     //             gte: param.where.tanggal.gte,
//     //             lte: param.where.tanggal.lte
//     //         },
//     //         kode_out: param.where.outlet.kode_out,
//     //         cdept: param.where.departement.cdept
//     //     }

//     // })

//     // let avarage = await prisma.listbill.aggregate({
//     //     where: {
//     //         tanggal: {
//     //             lte: param.where.tanggal.lte,
//     //             gte: param.where.tanggal.gte
//     //         }
//     //     },
//     //     _avg: {
//     //         net: true,
//     //         total: true,
//     //     },
//     // });

//     // param.where.compli = {
//     //     gt: 0
//     // }

//     // let compliment = await prisma.bill.aggregate({
//     //     _sum: {
//     //         compli: true,
//     //         pax: true,
//     //     },
//     //     _count: {
//     //         _all: true
//     //     },
//     //     where: {
//     //         listbill: {
//     //             kode_out: param.where.outlet.kode_out,
//     //             cdept: param.where.departement.cdept,
//     //             tanggal: {
//     //                 lte: param.where.tanggal.lte,
//     //                 gte: param.where.tanggal.gte
//     //             }
//     //         }
//     //     }
//     // })

//     // let subHasil = {
//     //     penjualan: [...hasil],
//     //     revenue: {
//     //         "gross": jumblah._sum.total,
//     //         "net": jumblah._sum.net,
//     //         "pax": jumblah._sum.pax,
//     //         "bill": jumblah._count.total
//     //     },
//     //     avarage: {
//     //         "net": avarage._avg.net,
//     //         "gross": avarage._avg.total
//     //     },
//     //     compliment: {
//     //         total: compliment._sum.compli,
//     //         pax: compliment._sum.pax,
//     //         totalBill: compliment._count._all
//     //     }
//     // }

//     // console.log(param.where)
//     // return subHasil
//     return hasil
// }


/**@param {import('./models').Parameter} param */
// async function SalesPerformance(param) {

//     let sls = await prisma.listbill.groupBy({
//         by: ["tanggal"],
//         _sum: {
//             total: true
//         },
//         where: param.where
//     });


//     let hsl = lodash.groupBy(sls.map((e) => {
//         return {
//             "tanggal": e.tanggal,
//             "total": e._sum.total
//         }
//     }), (val) => moment(val.tanggal).month())

//     let subHasil = [];
//     for (let b of Object.keys(hsl)) {
//         let dat = {
//             "bulan": Number(b) + 1,
//             "total": hsl[b].map((e) => e.total).reduce((a, b) => Number(a) + Number(b))
//         }

//         subHasil.push(dat);
//     }

//     return subHasil
// }

/**@param {import('./models').Parameter} param*/
async function SalesAvarage(param) {

    let sls = await prisma.listbill.groupBy({
        by: ["tanggal"],
        _avg: {
            total: true
        },
        where: param.where
    });


    let hsl = lodash.groupBy(sls.map((e) => {
        return {
            "tanggal": e.tanggal,
            "total": e._avg.total
        }
    }), (val) => moment(val.tanggal).month())

    let subHasil = [];
    for (let b of Object.keys(hsl)) {
        let dat = {
            "bulan": Number(b) + 1,
            "total": hsl[b].map((e) => e.total).reduce((a, b) => Number(a) + Number(b))
        }

        subHasil.push(dat);
    }

    return subHasil
}


/**@param {import('./models').Parameter} param */
async function BestDay(param) {
    let sls = await prisma.listbill.groupBy({
        by: ["tanggal"],
        _sum: {
            total: true,
        },
        where: param.where
    });


    let hsl = lodash.groupBy(sls.map((e) => {
        return {
            "tanggal": e.tanggal,
            "total": e._sum.total
        }
    }), (val) => moment(val.tanggal).day())

    let subHasil = [];
    for (let b of Object.keys(hsl)) {
        let dat = {
            "bulan": Number(b) + 1,
            "total": hsl[b].map((e) => e.total).reduce((a, b) => Number(a) + Number(b))
        }

        subHasil.push(dat);
    }

    return subHasil
}

/**@param {import('./models').Parameter} param */
async function BestProduct(param) {
    let grp = await prisma.groupp.groupBy({
        by: ["nm_groupp"]
    });

    for (let g of grp) {
        let
    }

    return grp
}


Api.get('/master/dep', expresAsyncHandler(async (req, res) => {
    let dep = await prisma.acc_dept.findMany({
        select: {
            nama_dept: true,
            unit_bisnis: true
        }
    });
    dep.push({
        nama_dept: "All",
        unit_bisnis: "All"
    })
    res.json(dep.reverse());
}));

Api.get('/master/out', expresAsyncHandler(async (req, res) => {
    let out = await prisma.outlet.findMany({
        select: {
            kode_out: true,
            nama_out: true,

        }
    });

    out.push({
        kode_out: "All",
        nama_out: "All"
    })
    res.json(out.reverse());
}))


function Log(tx) { console.log(tx) }


module.exports = Api;