const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

/**
 * 
 * @param {import("../models").ParamController} params 
 * @returns 
 */
async function RevenueByGroup(params){
    let option = (opt) => {
        let mdl = {
            _sum: {
                total: true,
                pax: true,
                net: true,
                taxrp: true,
                serrp: true,
                gtotal: true,
                cash: true,
            },
            _avg: {
                total: true,
                pax: true,
                net: true,
                taxrp: true,
                serrp: true,
                gtotal: true,
                cash: true,
            },
            _count: {
                total: true,
                pax: true,
                net: true,
                taxrp: true,
                serrp: true,
                gtotal: true,
                cash: true,
            },
            where: {
                bill: {
                    every: {
                        product: {

                        }
                    }
                },
                tanggal: {
                    lte: new Date(params.tgl2),
                    gte: new Date(params.tgl1)
                },
                cdept: params.cdep,
                kode_out: params.out
            }
        }

        if(params.out == "All" || params.out == null) delete mdl.where.kode_out
        if(params.cdep == "All" || params.cdep == null) delete mdl.where.cdept

        if (opt == 0) {
            mdl.where.bill.every.product['groupp'] = "FOOD"
        }else if(opt == 1){
            mdl.where.bill.every.product['groupp'] = "BEVERAGE"
        }else{
            mdl.where.bill.every.product['groupp'] = {
                notIn: ["FOOD", "BEVERAGE"]
            }
        }

        return mdl;
    }

    let food = await prisma.listbill.aggregate(option(0))

    let beverage = await prisma.listbill.aggregate(option(1))

    let other = await prisma.listbill.aggregate(option(2))

    let hasil = [
        {
            "name": "food",
            "data": food
        },
        {
            "name": "beverage",
            "data": beverage
        },
        {
            "name": "other",
            "data": other
        }
    ]

    return hasil
}


module.exports = RevenueByGroup;