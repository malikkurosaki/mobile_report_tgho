const asynchandler = require('express-async-handler')
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

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


// with query
const Dashboard = asynchandler(async (req, res) => {
    
    let { tgl1, tgl2, dept, out } = req.query

    try {
        await Selection.get();
        let data = [];
        console.log("comparation")
        if(tgl2 == "null" && dept == "all" && out == "all"){
            data = await AmbilDataSingle(tgl1);
            console.log("single")
        }else if(tgl2 == "null" && dept != "all" && out == "all"){
            data = await AmbilDataSingleDept(tgl1, dept);
            console.log("single dept")
        }else if(tgl2 == "null" && dept == "all" && out != "all"){
            data = await AmbilDataSingleOutlet(tgl1, out);
            console.log("single outlet")
        }else if(tgl2 != "null" && dept == "all" && out == "all"){
            data = await AmbilDataAll(tgl1, tgl2);
            console.log("all")
        }else if(tgl2 != "null" && dept != "all" && out == "all"){
            data = await AmbilDataDept(tgl1, tgl2, dept);
            console.log("all dept")
        }else if(tgl2 != "null" && dept == "all" && out != "all"){
            data = await AmbilDataOutlet(tgl1, tgl2, out);
            console.log("all outlet")
        }

        res.status(200).json({
            "master":{
                "group": Selection.group,
                "dept": Selection.dept,
                "out": Selection.outlet
            },
            "data": data
        })
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
})

const AmbilDataSingle = async (tgl1) => {
    
    let group = {};
    for (let i of Selection.group) {
        let data = await prisma.listbill.aggregate({
            _sum: {
                total: true,
                gtotal: true,
                net: true,
                taxrp: true,
            },
            where: {
                bill: {
                    every: {
                        Produk: {
                            groupp: {
                                equals: i.nm_groupp
                            }
                        }
                    }
                },
                tanggal: {
                    gte: new Date(tgl1),
                    lte: new Date(tgl1)
                }
            }
        })

        group[i.nm_groupp] = data;

    }

    return group;
}

const AmbilDataSingleDept = async (tgl1, dept) => {
    
    let group = {};
    for (let i of Selection.group) {
        let data = await prisma.listbill.aggregate({
            _sum: {
                total: true,
                gtotal: true,
                net: true,
                taxrp: true,
            },
            where: {
                bill: {
                    every: {
                        Produk: {
                            groupp: {
                                equals: i.nm_groupp
                            }
                        },
                    }
                },
                cdept: {
                    equals: dept
                },
                tanggal: {
                    gte: new Date(tgl1),
                    lte: new Date(tgl1)
                }
            }
        })

        group[i.nm_groupp] = data;

    }

    return group;
}

const AmbilDataSingleOutlet = async (tgl1, outlet) => {
    
    let group = {};
    for (let i of Selection.group) {
        let data = await prisma.listbill.aggregate({
            _sum: {
                total: true,
                gtotal: true,
                net: true,
                taxrp: true,
            },
            where: {
                bill: {
                    every: {
                        Produk: {
                            groupp: {
                                equals: i.nm_groupp
                            }
                        },
                    }
                },
                kode_out: {
                    equals: outlet
                },
                tanggal: {
                    gte: new Date(tgl1),
                    lte: new Date(tgl1)
                }
            }
        })

        group[i.nm_groupp] = data;

    }

    return group;
}

const AmbilDataAll = async (tgl1, tgl2) => {
    
    let group = {};
    for (let i of Selection.group) {
        let data = await prisma.listbill.aggregate({
            _sum: {
                total: true,
                gtotal: true,
                net: true,
                taxrp: true,
            },
            where: {
                bill: {
                    every: {
                        Produk: {
                            groupp: {
                                equals: i.nm_groupp
                            }
                        }
                    }
                },
                tanggal: {
                    gte: new Date(tgl1),
                    lte: new Date(tgl2)
                }
            }
        })

        group[i.nm_groupp] = data;

    }

    return group;
}

const AmbilDataDept = async (tgl1, tgl2, dept) => {
    
    let group = {};
    for (let i of Selection.group) {
        let data = await prisma.listbill.aggregate({
            _sum: {
                total: true,
                gtotal: true,
                net: true,
                taxrp: true,
            },
            where: {
                bill: {
                    every: {
                        Produk: {
                            groupp: {
                                equals: i.nm_groupp
                            }
                        },
                    }
                },
                cdept: {
                    equals: dept
                },
                tanggal: {
                    gte: new Date(tgl1),
                    lte: new Date(tgl2)
                }
            }
        })

        group[i.nm_groupp] = data;

    }

    return group;
}

const AmbilDataOutlet = async (tgl1, tgl2, outlet) => {
    
    let group = {};
    for (let i of Selection.group) {
        let data = await prisma.listbill.aggregate({
            _sum: {
                total: true,
                gtotal: true,
                net: true,
                taxrp: true,
            },
            where: {
                bill: {
                    every: {
                        Produk: {
                            groupp: {
                                equals: i.nm_groupp
                            }
                        },
                    }
                },
                kode_out: {
                    equals: outlet
                },
                tanggal: {
                    gte: new Date(tgl1),
                    lte: new Date(tgl2)
                }
            }
        })

        group[i.nm_groupp] = data;

    }

    return group;
}



module.exports = { Dashboard }
