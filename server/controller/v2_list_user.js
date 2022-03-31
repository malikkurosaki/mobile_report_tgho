const { PrismaClient } = require("@prisma/client");
const expressAsyncHandler = require("express-async-handler");
const prisma = new PrismaClient();

const V2ListUser = expressAsyncHandler(async(req, res) => {
    let data = await prisma.auth.findMany();

    res.json(data);
})

module.exports = V2ListUser