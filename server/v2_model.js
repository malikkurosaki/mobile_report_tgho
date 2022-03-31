
/**
 * @typedef {{
  "tgl1": String,
  "tgl2": String,
  "dep": String,
  "out": String,
  "query": Boolean
}} V2ModelDashboardQuery
 */


/**
 * @typedef {{
        tanggal: {
            lte: Date,
            gte: Date
        },
        cdept: String,
        kode_out: String,
        bill: {
            every: {
                product: {
                    groupp: String
                }
            }
        }
    }} V2ModelDashboardWhere
 */