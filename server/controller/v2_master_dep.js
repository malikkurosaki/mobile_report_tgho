const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();

const V2MasterDep = expressAsyncHandler(async (req, res) => {
    let dep = await prisma.acc_dept.findMany({
        select: {
            nama_dept: true,
            unit_bisnis: true
        }
    });
    dep.push({
        nama_dept: "All",
        unit_bisnis: "All"
    })
    res.json(dep.reverse());
})

module.exports = V2MasterDep