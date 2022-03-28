const asynchandler = require('express-async-handler')
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
// moment js
const moment = require('moment');
const r = require('rethinkdb');


var Selection = {
    /**@type {{
        nm_groupp: string;
    }[]} */
    group: [],
    /**@type {{
        nama_dept: string;
    }[]} */
    dept: [],
    /**@type {{
        nama_out: string;
        kode_out: string;
    }[]} */
    outlet: [],
    /**@type {{
        "nama_dep": string,
        "kode_out": string,
        "groupp": string
    }} */
    query: {},
    async get() {
        this.group = await prisma.groupp.findMany({
            select: {
                nm_groupp: true,

            }
        })
        this.dept = await prisma.acc_dept.findMany({
            select: {
                nama_dept: true,

            }
        })

        this.outlet = await prisma.outlet.findMany({
            select: {
                nama_out: true,
                kode_out: true,
            }
        })
    },

}

async function dataDashboard(conn) {
    // let { tgl1, tgl2, dept, out } = req.query
    await Selection.get();

    let reportGroup = [];
    for (let i of Selection.group) {
        reportGroup.push(await ReportByGroup(i.nm_groupp))

    }

    let reportDept = [];
    for (let i of Selection.dept) {
        reportDept.push(await ReportByDept(i.nama_dept))
    }

    let reportOut = [];
    for (let i of Selection.outlet) {
        reportOut.push(await ReportByOut(i.kode_out))
    }

    let reportTotal = await ReportByTotal();

    let hasilData = {
        "master": {
            "group": Selection.group,
            "dept": Selection.dept,
            "out": Selection.outlet
        },
        // "data": data,
        "report": {
            "date": moment().format('YYYY-MM-DD'),
            "byGroup": reportGroup,
            "byTotal": reportTotal,
            "byDept": reportDept,
            "byOut": reportOut
        }
    }

    r.table('dashboard').delete().run(conn);
    r.table('dashboard').insert(hasilData).run(conn);
    console.log("load data dashboard")
    return hasilData;
}

// with query
const Dashboard = asynchandler(async (req, res) => {
    let conn = await r.connect({ host: 'localhost', port: 28015, db: 'tgho' });
    let dash = await (await r.table('dashboard').run(conn)).toArray();

    if (dash.length > 0) {
        
        res.json({
            success: true,
            data: dash[0]
        });
        dataDashboard(conn);
    } else {
        let data = await dataDashboard(conn);
        res.json({
            success: true,
            data: data
        });
    }
})

// first month this year
let firstMonth = moment().startOf('year').format('YYYY-MM-DD');
// last month this year
let lastMonth = moment().format('YYYY-MM-DD');
// first day this month
let firstDay = moment().startOf('month').format('YYYY-MM-DD');
// last day this month
let lastDay = moment().endOf('month').format('YYYY-MM-DD');
// first day this week
let firstDayWeek = moment().startOf('week').format('YYYY-MM-DD');
// last day this week
let lastDayWeek = moment().endOf('week').format('YYYY-MM-DD');
// first today
let firstToday = moment().startOf('day').format('YYYY-MM-DD');
// last today
let lastToday = moment().endOf('day').format('YYYY-MM-DD');

async function ReportByTotal() {
    // year report
    let year = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstMonth),
                lte: new Date(lastMonth)
            }
        }
    })

    // month report
    let month = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstDay),
                lte: new Date(lastDay)
            }
        }
    })

    // week report
    let week = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstDayWeek),
                lte: new Date(lastDayWeek)
            },
        }
    })

    // today report
    let today = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstToday),
                lte: new Date(lastToday)
            }
        }
    })

    let report = {
        "year": year,
        "month": month,
        "week": week,
        "day": today,
    }

    return report;
}

async function ReportByGroup(group) {
    // // first month this year
    // let firstMonth = moment().startOf('year').format('YYYY-MM-DD');
    // // last month this year
    // let lastMonth = moment().endOf('year').format('YYYY-MM-DD');
    // // first day this month
    // let firstDay = moment().startOf('month').format('YYYY-MM-DD');
    // // last day this month
    // let lastDay = moment().endOf('month').format('YYYY-MM-DD');
    // // first day this week
    // let firstDayWeek = moment().startOf('week').format('YYYY-MM-DD');
    // // last day this week
    // let lastDayWeek = moment().endOf('week').format('YYYY-MM-DD');
    // // first today
    // let firstToday = moment().startOf('day').format('YYYY-MM-DD');
    // // last today
    // let lastToday = moment().endOf('day').format('YYYY-MM-DD');
    // year report
    let year = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstMonth),
                lte: new Date(lastMonth)
            },
            bill: {
                every: {
                    Produk: {
                        groupp: {
                            equals: group
                        }
                    }
                }
            },
        }
    })

    // month report
    let month = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstDay),
                lte: new Date(lastDay)
            },
            bill: {
                every: {
                    Produk: {
                        groupp: {
                            equals: group
                        }
                    }
                }
            },
        }
    })

    // week report
    let week = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,

        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstDayWeek),
                lte: new Date(lastDayWeek)
            },
            bill: {
                every: {
                    Produk: {
                        groupp: {
                            equals: group
                        }
                    }
                }
            },
        }
    })

    // today report
    let today = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstToday),
                lte: new Date(lastToday)
            },
            bill: {
                every: {
                    Produk: {
                        groupp: {
                            equals: group
                        }
                    }
                }
            },
        }
    })

    let report = {
        "group": group,
        "data": {
            "year": {
                "date": {
                    "start": firstMonth,
                    "end": lastMonth
                },
                "data": year
            },
            "month": {
                "date": {
                    "start": firstDay,
                    "end": lastDay
                },
                "data": month
            },
            "week": {
                "date": {
                    "start": firstDayWeek,
                    "end": lastDayWeek
                },
                "data": week
            },
            "day": {
                "date": {
                    "start": firstToday,
                    "end": lastToday
                },
                "data": today
            },
        }
    }

    return report;
}

async function ReportByDept(dept) {
    // // first month this year
    // let firstMonth = moment().startOf('year').format('YYYY-MM-DD');
    // // last month this year
    // let lastMonth = moment().endOf('year').format('YYYY-MM-DD');
    // // first day this month
    // let firstDay = moment().startOf('month').format('YYYY-MM-DD');
    // // last day this month
    // let lastDay = moment().endOf('month').format('YYYY-MM-DD');
    // // first day this week
    // let firstDayWeek = moment().startOf('week').format('YYYY-MM-DD');
    // // last day this week
    // let lastDayWeek = moment().endOf('week').format('YYYY-MM-DD');
    // // first today
    // let firstToday = moment().startOf('day').format('YYYY-MM-DD');
    // // last today
    // let lastToday = moment().endOf('day').format('YYYY-MM-DD');
    // year report
    let year = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstMonth),
                lte: new Date(lastMonth)
            },
            cdept: {
                equals: dept
            }
        }
    })

    // month report
    let month = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstDay),
                lte: new Date(lastDay)
            },
            cdept: {
                equals: dept
            }
        }
    })

    // week report
    let week = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,

        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstDayWeek),
                lte: new Date(lastDayWeek)
            },
            cdept: {
                equals: dept
            }
        }
    })

    // today report
    let today = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstToday),
                lte: new Date(lastToday)
            },
            cdept: {
                equals: dept
            }
        }
    })

    let report = {
        "dept": dept,
        "data": {
            "year": {
                "date": {
                    "start": firstMonth,
                    "end": lastMonth
                },
                "data": year
            },
            "month": {
                "date": {
                    "start": firstDay,
                    "end": lastDay
                },
                "data": month
            },
            "week": {
                "date": {
                    "start": firstDayWeek,
                    "end": lastDayWeek
                },
                "data": week
            },
            "day": {
                "date": {
                    "start": firstToday,
                    "end": lastToday
                },
                "data": today
            },
        }
    }

    return report;
}

async function ReportByOut(out) {
    // // first month this year
    // let firstMonth = moment().startOf('year').format('YYYY-MM-DD');
    // // last month this year
    // let lastMonth = moment().endOf('year').format('YYYY-MM-DD');
    // // first day this month
    // let firstDay = moment().startOf('month').format('YYYY-MM-DD');
    // // last day this month
    // let lastDay = moment().endOf('month').format('YYYY-MM-DD');
    // // first day this week
    // let firstDayWeek = moment().startOf('week').format('YYYY-MM-DD');
    // // last day this week
    // let lastDayWeek = moment().endOf('week').format('YYYY-MM-DD');
    // // first today
    // let firstToday = moment().startOf('day').format('YYYY-MM-DD');
    // // last today
    // let lastToday = moment().endOf('day').format('YYYY-MM-DD');
    // year report
    let year = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstMonth),
                lte: new Date(lastMonth)
            },
            kode_out: {
                equals: out
            }
        }
    })

    // month report
    let month = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstDay),
                lte: new Date(lastDay)
            },
            kode_out: {
                equals: out
            }
        }
    })

    // week report
    let week = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,

        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstDayWeek),
                lte: new Date(lastDayWeek)
            },
            kode_out: {
                equals: out
            }
        }
    })

    // today report
    let today = await prisma.listbill.aggregate({
        _sum: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        _avg: {
            total: true,
            net: true,
            gtotal: true,
            pax: true,
            cash: true,
        },
        where: {
            tanggal: {
                gte: new Date(firstToday),
                lte: new Date(lastToday)
            },
            kode_out: {
                equals: out
            }
        }
    })

    let report = {
        "out": out,
        "data": {
            "year": {
                "date": {
                    "start": firstMonth,
                    "end": lastMonth
                },
                "data": year
            },
            "month": {
                "date": {
                    "start": firstDay,
                    "end": lastDay
                },
                "data": month
            },
            "week": {
                "date": {
                    "start": firstDayWeek,
                    "end": lastDayWeek
                },
                "data": week
            },
            "day": {
                "date": {
                    "start": firstToday,
                    "end": lastToday
                },
                "data": today
            },
        }
    }

    return report;
}

// const AmbilDataSingle = async (tgl1) => {

//     let group = {};
//     for (let i of Selection.group) {
//         let data = await prisma.listbill.aggregate({
//             _sum: {
//                 total: true,
//                 gtotal: true,
//                 net: true,
//                 taxrp: true,
//             },
//             where: {
//                 bill: {
//                     every: {
//                         Produk: {
//                             groupp: {
//                                 equals: i.nm_groupp
//                             }
//                         }
//                     }
//                 },
//                 tanggal: {
//                     gte: new Date(tgl1),
//                     lte: new Date(tgl1)
//                 }
//             }
//         })

//         group[i.nm_groupp] = data;

//     }

//     return group;
// }

// const AmbilDataSingleDept = async (tgl1, dept) => {

//     let group = {};
//     for (let i of Selection.group) {
//         let data = await prisma.listbill.aggregate({
//             _sum: {
//                 total: true,
//                 gtotal: true,
//                 net: true,
//                 taxrp: true,
//             },
//             where: {
//                 bill: {
//                     every: {
//                         Produk: {
//                             groupp: {
//                                 equals: i.nm_groupp
//                             }
//                         },
//                     }
//                 },
//                 cdept: {
//                     equals: dept
//                 },
//                 tanggal: {
//                     gte: new Date(tgl1),
//                     lte: new Date(tgl1)
//                 }
//             }
//         })

//         group[i.nm_groupp] = data;

//     }

//     return group;
// }

// const AmbilDataSingleOutlet = async (tgl1, outlet) => {

//     let group = {};
//     for (let i of Selection.group) {
//         let data = await prisma.listbill.aggregate({
//             _sum: {
//                 total: true,
//                 gtotal: true,
//                 net: true,
//                 taxrp: true,
//             },
//             where: {
//                 bill: {
//                     every: {
//                         Produk: {
//                             groupp: {
//                                 equals: i.nm_groupp
//                             }
//                         },
//                     }
//                 },
//                 kode_out: {
//                     equals: outlet
//                 },
//                 tanggal: {
//                     gte: new Date(tgl1),
//                     lte: new Date(tgl1)
//                 }
//             }
//         })

//         group[i.nm_groupp] = data;

//     }

//     return group;
// }

// const AmbilDataAll = async (tgl1, tgl2) => {

//     let group = {};
//     for (let i of Selection.group) {
//         let data = await prisma.listbill.aggregate({
//             _sum: {
//                 total: true,
//                 gtotal: true,
//                 net: true,
//                 taxrp: true,
//             },
//             where: {
//                 bill: {
//                     every: {
//                         Produk: {
//                             groupp: {
//                                 equals: i.nm_groupp
//                             }
//                         }
//                     }
//                 },
//                 tanggal: {
//                     gte: new Date(tgl1),
//                     lte: new Date(tgl2)
//                 }
//             }
//         })

//         group[i.nm_groupp] = data;

//     }

//     return group;
// }

// const AmbilDataDept = async (tgl1, tgl2, dept) => {

//     let group = {};
//     for (let i of Selection.group) {
//         let data = await prisma.listbill.aggregate({
//             _sum: {
//                 total: true,
//                 gtotal: true,
//                 net: true,
//                 taxrp: true,
//             },
//             where: {
//                 bill: {
//                     every: {
//                         Produk: {
//                             groupp: {
//                                 equals: i.nm_groupp
//                             }
//                         },
//                     }
//                 },
//                 cdept: {
//                     equals: dept
//                 },
//                 tanggal: {
//                     gte: new Date(tgl1),
//                     lte: new Date(tgl2)
//                 }
//             }
//         })

//         group[i.nm_groupp] = data;

//     }

//     return group;
// }

// const AmbilDataOutlet = async (tgl1, tgl2, outlet) => {

//     let group = {};
//     for (let i of Selection.group) {
//         let data = await prisma.listbill.aggregate({
//             _sum: {
//                 total: true,
//                 gtotal: true,
//                 net: true,
//                 taxrp: true,
//             },
//             where: {
//                 bill: {
//                     every: {
//                         Produk: {
//                             groupp: {
//                                 equals: i.nm_groupp
//                             }
//                         },
//                     }
//                 },
//                 kode_out: {
//                     equals: outlet
//                 },
//                 tanggal: {
//                     gte: new Date(tgl1),
//                     lte: new Date(tgl2)
//                 }
//             }
//         })

//         group[i.nm_groupp] = data;

//     }

//     return group;
// }



module.exports = { Dashboard, }
