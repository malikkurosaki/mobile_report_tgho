const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();
const moment = require("moment");
const { storage } = require("../storage");
const { Tunggu } = require("../tunggu");


async function dept_report(req, res) {
    let dept = await prisma.acc_dept.findMany();

    let result = [];

    for (let i of dept) {
        let year = await prisma.listbill.aggregate({
            _avg: {
                total: true,
                net: true
            },
            _sum: {
                total: true,
                net: true,
                gtotal: true
            },

            orderBy: {
                total: "desc"
            },
            where: {
                tanggal: {
                    gte: new Date(moment().startOf("year").format("YYYY-MM-DD")),
                    lte: new Date(moment().endOf("year").format("YYYY-MM-DD"))
                },
                bill: {
                    every: {
                        Produk: {
                            nm_dept: {
                                equals: i.nama_dept
                            }
                        }
                    }
                }
            }
        });

        let month = await prisma.listbill.aggregate({
            _avg: {
                total: true,
                net: true
            },
            orderBy: {
                total: "desc"
            },
            where: {
                tanggal: {
                    gte: new Date(moment().startOf("month").format("YYYY-MM-DD")),
                    lte: new Date(moment().endOf("month").format("YYYY-MM-DD"))
                },
                bill: {
                    every: {
                        Produk: {
                            nm_dept: {
                                equals: i.nama_dept
                            }
                        }
                    }
                }
            }
        });

        let week = await prisma.listbill.aggregate({
            _sum: {
                total: true,
                net: true,
            },
            orderBy:{
                total: "desc"
            },
            where: {
                tanggal: {
                    gte: new Date(moment().startOf("week").format("YYYY-MM-DD")),
                    lte: new Date(moment().endOf("week").format("YYYY-MM-DD"))
                },
                bill: {
                    every: {
                        Produk: {
                            nm_dept: {
                                equals: i.nama_dept
                            }
                        }
                    }
                }
            }
        });


        result.push({
            "dept": i.nama_dept,
            "year": {
                "first": moment().startOf("year").format("YYYY-MM-DD"),
                "last": moment().endOf("year").format("YYYY-MM-DD"),
                "data": year
            },
            "month": {
                "first": moment().startOf("month").format("YYYY-MM-DD"),
                "last": moment().endOf("month").format("YYYY-MM-DD"),
                "data": month
            },
            "week": {
                "first": moment().startOf("week").format("YYYY-MM-DD"),
                "last": moment().endOf("week").format("YYYY-MM-DD"),
                "data": week
            }
        });
    }

    storage.setItem("dept", JSON.stringify(result, null, 2));
    console.log("dept report saved");
    return {
        "year": {
            "first": moment().startOf("year").format("YYYY-MM-DD"),
            "last": moment().endOf("year").format("YYYY-MM-DD")
        },
        "data": result
    }

}

const ByDeptReport = expressAsyncHandler(async (req, res) => {
    let dep = storage.getItem("dept");

    if (dep == null) {
        let result = await dept_report();
        res.json({
            success: true,
            data: result
        });
    } else {
        res.json({
            success: true,
            data: JSON.parse(dep)
        });
        
        if(!Tunggu.deptReport){
            Tunggu.deptReport = true;
            dept_report();
            Tunggu.deptReport = false;
        }
    }
    
});

module.exports = { ByDeptReport }