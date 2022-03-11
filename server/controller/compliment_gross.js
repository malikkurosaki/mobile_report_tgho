const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();


/**
 * 
 * @param {import("../models").ParamController} params 
 * @returns 
 */
async function ComplimentGross(params) {

    /**
     * 
     * @param {String} par 
     * @returns 
     */
    let nobill = async function (par) {

        let where = {
            tanggal: {
                gte: new Date(params.tgl1),
                lte: new Date(params.tgl2)
            },
            compli: {
                not: 0
            },
            product: {
                groupp: par
            }

        }

        if (par == "OTHERS") {
            delete where.product
            where.product = {
                groupp: {
                    notIn: ["FOOD", "BEVERAGE"]
                }
            }
        }

        let com = await prisma.bill.groupBy({
            by: ["nobill"],
            where: where,
            _sum: {
                compli: true
            }
        })

        return com
    }

    let listFood = await nobill("FOOD");
    let listBeverage = await nobill("BEVERAGE");
    let targetFood = listFood.map((e) => e._sum.compli)
    let targetBeverage = listBeverage.map((e) => e._sum.compli);
    let hasil = {
        "food": targetFood > 1? targetFood.reduce((a, b) => a+b ): targetFood[0],
        "beverage": targetBeverage > 1? targetBeverage.reduce((a, b) => a+b): targetBeverage[0]
    }

    
    return hasil
}

module.exports = ComplimentGross