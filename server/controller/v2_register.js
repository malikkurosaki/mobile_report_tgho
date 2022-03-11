const {PrismaClient} = require('@prisma/client');
const expressAsyncHandler = require('express-async-handler');
const prisma = new PrismaClient();


const V2Register = expressAsyncHandler(async (req, res) => {
    let body = req.body;
    let data = await prisma.auth.create({
        data: {
            email: body.email,
            name: body.name,
            password: body.password
        }
    }) 

    res.json(data);
})


module.exports = V2Register