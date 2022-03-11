const { PrismaClient } = require("@prisma/client");
const res = require("express/lib/response");
const prisma = new PrismaClient();
const lodash = require("lodash");
const moment = require("moment");

/**
 * 
 * @param {import("../models").ParamController} params
 */
async function SalesPerformance(params) {
    let tanggal = new Date(params.tgl1);

    let first = new Date(`${tanggal.getUTCFullYear()}-01-01`)
    let last = new Date(`${tanggal.getUTCFullYear()}-12-31`)

    let where = {
        cdept: params.cdep,
        kode_out: params.out,
        tanggal: {
            gte: new Date(params.tgl1),
            lte: new Date(params.tgl2),
        }
    }



    if (params.cdep == null || params.cdep == "All") delete where.cdept
    if (params.out == null || params.out == "All") delete where.kode_out

    let sls = await prisma.listbill.groupBy({
        by: ["tanggal"],
        _sum: {
            net: true,
        },
        // _sum: {
        //     total: true,
        //     net: true,
        //     gtotal: true,
        //     pax: true
        // },
        where: where
    });

    let grb = lodash.groupBy(sls.map((e) => {
        return {
            "tanggal": e.tanggal,
            "net": e._sum.net
        }
    }), (e) => moment(e['tanggal']).month())
    let ky = Object.keys(grb);
    let hasil = [];
    if (sls.length > 0 && ky.length > 0) {
        for (let h in ky) {
            let target = grb[ky[h]].map((e) => e['net']);
            hasil.push({
                "bulan": Number(ky[h]) + 1,
                "net": target.length > 0 ? target.reduce((a, b) => Number(a) + Number(b)) : Number(target[0])
            })
        }

    }

    return hasil;

    // console.log(sls)

    // let hsl = lodash.groupBy(sls.map((e) => {
    //     return {
    //         "tanggal": e.tanggal,
    //         "total": e._sum.total,
    //         "net": e._sum.net,
    //         "gtotal": e._sum.gtotal,
    //         "pax": e._sum.pax
    //     }
    // }), (val) => moment(val.tanggal).month())

    // let subHasil = [];
    // if(hsl.length > 0) {
    //     for (let b in Object.keys(hsl)) {
    //         let dat = {
    //             "bulan": Number(b) + 1,
    //             "total": 0, //hsl[b].map((e) => e.total).reduce((a, b) => Number(a) + Number(b)),
    //             "gtotal": 0 ,// hsl[b].map((e) => e.gtotal).reduce((a, b) => Number(a) + Number(b)),
    //             "net": hsl[b].map((e) => e.net).reduce((a, b) => Number(a) + Number(b)),
    //             "pax":0, // hsl[b].map((e) => e.pax).reduce((a, b) => Number(a) + Number(b))
    //         }

    //         subHasil.push(dat);
    //     }
    // }

    // return sls.map((e) => moment(e.tanggal).month())
}



module.exports = SalesPerformance