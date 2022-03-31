const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

/**
 * 
 * @param {import("../models").ParamController} param 
 */
async function TotalRevenue(param){
    let where = {
        cdept: param.cdep,
        kode_out: param.out,
        tanggal: {
            lte: new Date(param.tgl2),
            gte: new Date(param.tgl1)
        }
    };

    if(param.cdep == null || param.cdep == "All") delete where.cdept;
    if(param.out == null || param.out == "All") delete where.kode_out

    let ttl = await prisma.listbill.aggregate({
        _sum: {
            net: true,
            gtotal: true,
            total: true,
            pax: true,
        },
        _count: {
            nobill: true
        },
        where: where
    })

    // let bill = await prisma.bill.count({
    //     where: where
    // })

    let hasil = {
        "net": ttl._sum.net,
        "gross": ttl._sum.gtotal,
        "total": ttl._sum.total,
        "pax": ttl._sum.pax,
        "bill": ttl._count.nobill
    }

    return hasil;
}

module.exports = TotalRevenue