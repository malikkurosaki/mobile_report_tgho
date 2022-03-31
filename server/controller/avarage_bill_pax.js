const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

/**
 * 
 * @param {import("../models").ParamController} params 
 */
async function AvarageBillPax(params) {

    let where = {
        tanggal: {
            lte: new Date(params.tgl2),
            gte: new Date(params.tgl1)
        },
        cdept: params.cdep,
        kode_out: params.out
    };

    if(params.cdep == "All" || params.cdep == null) delete where.cdept;
    if(params.out == "All" || params.out == null) delete where.kode_out;

    let avg = await prisma.listbill.aggregate({
        _avg: {
            net: true,
            gtotal: true,
            total: true,
        },
        where: where
    })

    return avg._avg
}

module.exports = AvarageBillPax