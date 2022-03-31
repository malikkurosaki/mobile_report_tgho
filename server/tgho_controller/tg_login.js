const { PrismaClient } = require('@prisma/client');
const expressAsyncHandler = require('express-async-handler');
const { Tunggu } = require('../tunggu');
const prisma = new PrismaClient();

const TgLogin = expressAsyncHandler(async (req, res) => {
    let {name, password} = req.body;
    let login = await prisma.auth.findFirst({
    
        where: {
            name: {
                equals: name
            },
            password: {
                equals: password
            }
        }
    })

    res.status(200).json({
        success: login != null,
        data: login
    })
});

module.exports = { TgLogin }