const { PrismaClient } = require("@prisma/client");
const { Decimal } = require("@prisma/client/runtime");
const prisma = new PrismaClient();
const lodash = require("lodash");
const moment = require('moment');

/**
 * 
 * @param {import("../models").ParamController} params
 */
async function SalesAnalisisByAvarageBill(params) {

    try {
        // let tanggal = new Date(params.tgl1);
        // let first = new Date(`${tanggal.getUTCFullYear()}-01-01`)
        // let last = new Date(`${tanggal.getUTCFullYear()}-12-31`)

        let where = {
            tanggal: {
                lte: new Date(params.tgl2),
                gte: new Date(params.tgl1)
            },
            cdept: params.cdep,
            kode_out: params.out
        }

        if (params.cdep == "All" || params.cdep == null) delete where.cdept
        if (params.out == null || params.out == "All") delete where.kode_out

        let sls = await prisma.listbill.groupBy({
            by: ["tanggal"],
            _avg: {
                net: true,
            },
            where: where
        })

        let grb = lodash.groupBy(sls.map((e) => {
            return {
                "tanggal": e.tanggal,
                "net": e._avg.net
            }
        }), (a) => moment(a.tanggal).month() );
        let ky = Object.keys(grb);

        let hasil = []
        if(sls.length > 0 && ky.length > 0){
            for(let k in ky){
                let target = grb[ky[k]].map((e) => e.net)
                let subHasil = {
                    "bulan" : Number( ky[k]) + 1,
                    "net": target.length > 1 ? target.reduce((a, b) => Number(a) + Number(b)): Number(target[0])
                }
                hasil.push(subHasil)
            }
        }

        return hasil
    } catch (error) {
        console.log(error)
        return []
    }
}

module.exports = SalesAnalisisByAvarageBill