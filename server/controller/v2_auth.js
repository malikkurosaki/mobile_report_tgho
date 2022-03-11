const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const expressAsyncHandler = require('express-async-handler')

const Register = expressAsyncHandler(async (req, res) => {
    try {
        const body = req.query;

        const data = await prisma.auth.create({
            data: {
                email: body.email,
                name: body.userName,
                password: body.password
            }
        });

        let success = data != null;
        res.json({
            success: success,
            data: data
        })
    } catch (error) {
        res.json({
            success: false,
            message: error
        })
    }
})

const Login = expressAsyncHandler(async (req, res) => {
    /**@type {import('./models').ModelUser} */
    const data = req.body

    const usr = await prisma.auth.findFirst({
        where: {
            email: {
                equals: data.email
            },
            password: {
                equals: data.password
            }
        }
    })

    console.log(usr);

    const success = usr != null

    res.json({
        success: success,
        data: usr,
        message: "wrong email or password"
    });

})

module.exports = { Register, Login }