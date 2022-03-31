const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

/**
 * 
 * @param {V2ModelDashboardWhere} where 
 * @param {V2ModelDashboardQuery} query 
 * @returns 
 */
async function V2DashboardHelper(where, query){
    if (query.dep == "" || query.dep == "All" || query.dep == null) delete where.cdept;
    if (query.out == "" || query.out == "All" || query.out == null) delete where.kode_out;
    if (query.tgl1 == "" || query.tgl1 == null || query.tgl2 == "" || query.tgl2 == null) delete where.tanggal

    let data = await prisma.listbill.aggregate({
        _sum: {
            net: true,
            gtotal: true,
            total: true,
        },
        where: where
    });

    let nomerBill = await prisma.listbill.findMany({
        select: {
            nobill: true
        },
        where: where
    })

    let totalBill = await prisma.bill.count({
        where: {
           nobill: {
               in: nomerBill.map((e) =>e.nobill)
           } 
        }
    })

    let compliment = await prisma.bill.aggregate({
        _sum: {
            compli: true
        },
        where: {
            nobill: {
                in: nomerBill.map((e) => e.nobill)
            }
        }
    })

    let compliHitung = await prisma.bill.groupBy({
        by: ['nobill'],
        where: {
            nobill: {
                in: nomerBill.map((e) => e.nobill)
            }
        }
    })

    let hasil = {
        "net": data._sum.net,
        "gtotal": data._sum.gtotal,
        "total": data._sum.total,
        "bill": totalBill,
        "compliTotal": compliment._sum.compli, 
        "compliLength": compliHitung.length,
        "where": where,
        "query": query
    }

    console.log(hasil);

    if(query.query == "null" || query.query == "false") {
        delete hasil.query;
        delete hasil.where
    }

    return hasil
}


module.exports = V2DashboardHelper