const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient();


/**
 * 
 * @param {import('../models').ParamController} params 
 */
async function SalesTimeCategory(params){
    

    let data = await prisma.listbill.groupBy({
        by: ['jam_order', "net"],
        where: {
            cdept: params.cdep,
            kode_out: params.out,
            tanggal: {
                lte: new Date(params.tgl2),
                gte: new Date(params.tgl1)
            }
        }
    })

    return data
}

module.exports = SalesTimeCategory