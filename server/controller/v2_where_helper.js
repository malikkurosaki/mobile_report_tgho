
function WhereHelper(query) {
     /**@type {String} */
     let tg2 = query.tgl2??"";

     /**@type {String} */
     let tg1 = query.tgl1??"";
    let where = {
        tanggal: {
            lte: new Date(tg2.includes(" ")? tg2.split(" ")[0]: tg2),
            gte: new Date(tg1.includes(" ")? tg1.split(" ")[0]: tg2)
        },
        cdept: query.dep,
        kode_out: query.out,
    }

    if (query.dep == "" || query.dep == "All" || query.dep == null) delete where.cdept;
    if (query.out == "" || query.out == "All" || query.out == null) delete where.kode_out;
    if (query.tgl1 == "" || query.tgl1 == null || query.tgl2 == "" || query.tgl2 == null) delete where.tanggal

    return where;
}


module.exports = WhereHelper

