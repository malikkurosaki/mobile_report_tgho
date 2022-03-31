const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();


const V2MasterOutlet = expressAsyncHandler(async (req, res) => {
    let out = await prisma.outlet.findMany({
        select: {
            kode_out: true,
            nama_out: true,

        }
    });

    out.push({
        kode_out: "All",
        nama_out: "All"
    })
    res.json(out.reverse());
})

module.exports = V2MasterOutlet