const {PrismaClient} = require('@prisma/client');
const expressAsyncHandler = require('express-async-handler');
const WhereHelper = require('./v2_where_helper');
const prisma = new PrismaClient();
const lodas = require('lodash');

const V2Top10Food = expressAsyncHandler(async (req, res) => {

    let whereHelper = WhereHelper(req.query);

    whereHelper['product'] = {
        groups: {
            equals: "FOOD"
        }
    };

    let data = await prisma.bill.findMany({
        orderBy: {
            product: {
                nama_pro: 'asc'
            }
        },
        select: {
           product: {
               select: {
                   nama_pro: true
               },

           }
        },
        where: whereHelper
    })

    let hasil = data.map((e) => {
        return {
            "id": e.product.nama_pro,
            "qty": 1
        }
    });

    /**
     * @typedef {{
            "id": "",
            "qty": 1
        }} ModelHasil
     */
    
    /**
     * @type {ModelHasil[]} 
     */
    let result = [];
    var hsl = [];

    if(data.length > 0){
        hasil.reduce(function(rs, value) {
            if(!rs[value.id]){
                rs[value.id] = { Id: value.id, qty: 0 };
                result.push(rs[value.id]);
            }
            rs[value.id].qty += value.qty
            return rs
        }, {});
    
        hsl = lodas.sortBy(result, (a) => a.qty).reverse().slice(0, 10)
    }

    res.json(hsl)

})

module.exports = V2Top10Food