const asynchandler = require('express-async-handler')
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
// moment js
const moment = require('moment');
const fs = require('fs');
const { Tunggu } = require('../tunggu');
const LocalStorage = require('node-localstorage').LocalStorage;
const storage = new LocalStorage("./scratch");

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
        storage.setItem('group', JSON.stringify(this.group, null, 2));
        console.log("data select group berhasil di simpan");

        this.dept = await prisma.acc_dept.findMany({
            select: {
                nama_dept: true,

            }
        })
        storage.setItem('dept', JSON.stringify(this.dept, null, 2));
        console.log("data select dept berhasil di simpan");
        this.outlet = await prisma.outlet.findMany({
            select: {
                nama_out: true,
                kode_out: true,
            }
        })
        storage.setItem('outlet', JSON.stringify(this.outlet, null, 2));
        console.log("data select outlet berhasil di simpan");
    },

}

async function dataDashboard() {

    // let { tgl1, tgl2, dept, out } = req.query
    await Selection.get();
    if(storage.getItem('group') == null || storage.getItem('dept') == null || storage.getItem('outlet') == null){
        await Selection.get();
    }else{
        Selection.group = JSON.parse(storage.getItem('group'));
        Selection.dept = JSON.parse(storage.getItem('dept'));
        Selection.outlet = JSON.parse(storage.getItem('outlet'));
        Selection.get();
    }

    let reportGroup = [];
    for (let i of Selection.group) {
        if(storage.getItem(i.nm_groupp) == null){
            storage.setItem(i.nm_groupp, JSON.stringify(await ReportByGroup(i.nm_groupp), null, 2));
            reportGroup.push(storage.getItem(i.nm_groupp));
        }else{
            reportGroup.push(JSON.parse(storage.getItem(i.nm_groupp)))
            ReportByGroup(i.nm_groupp).then(data => {
                storage.setItem(i.nm_groupp, JSON.stringify(data, null, 2));
            })
        }
    }

    let reportDept = [];
    for (let i of Selection.dept) {
        if(storage.getItem(i.nama_dept) == null){
            storage.setItem(i.nama_dept, JSON.stringify(await ReportByDept(i.nama_dept), null, 2));
            reportDept.push(storage.getItem(i.nama_dept));
        }else{
            reportDept.push(JSON.parse(storage.getItem(i.nama_dept)))
            ReportByDept(i.nama_dept).then(data => {
                storage.setItem(i.nama_dept, JSON.stringify(data, null, 2));
            })
        }
    }

    let reportOut = [];
    for (let i of Selection.outlet) {
        if(storage.getItem(i.nama_out) == null){
            storage.setItem(i.nama_out, JSON.stringify(await ReportByOut(i.nama_out), null, 2));
            reportOut.push(storage.getItem(i.nama_out));
        }else{
            reportOut.push(JSON.parse(storage.getItem(i.nama_out)))
            ReportByOut(i.nama_out).then(data => {
                storage.setItem(i.nama_out, JSON.stringify(data, null, 2));
            })
        }
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

    storage.setItem('dashboard', JSON.stringify(hasilData, null, 2));
    console.log("data dashboard berhasil di simpan");
    return hasilData;

}

// with query
const Dashboard = asynchandler(async (req, res) => {
    let data = storage.getItem('dashboard');
    if (data == null) {
        let dashboard = await dataDashboard();
        res.json({
            success: true,
            data: dashboard
        });
    } else {
        res.json({
            success: true,
            data: JSON.parse(data)
        });

        if (!Tunggu.dashboard) {
            Tunggu.dashboard = true;
            dataDashboard();
            Tunggu.dashboard = false;
        }
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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
        orderBy: {
            total: 'desc'
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

module.exports = { Dashboard, }
