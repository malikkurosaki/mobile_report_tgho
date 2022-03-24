module.exports = {
    apps: [
        {
            name: "client",
            script: "./project_ecosystem.sh client",
            instances: 1,
        },
        {
            name: "server",
            script: "./project_ecosystem.sh server",
            instances: 1,
        }
    ]
}