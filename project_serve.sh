#!/usr/bin/env bash

if [[ $# -ne 0 ]]; then
    case $1 in
    -start)
        pm2 start ecosystem.config.js
        ;;
    -stop)
        pm2 stop ecosystem.config.js
        ;;
    -restart)
        pm2 restart ecosystem.config.js
        ;;
    -delete)
        pm2 delete ecosystem.config.js
        ;;
    -start-server)
        pm2 start ecosystem.config.js --only server
        ;;
    -restart-server)
        pm2 restart ecosystem.config.js --only server
        ;;
    -stop-server)
        pm2 stop ecosystem.config.js --only server
        ;;
    -delete-server)
        pm2 delete ecosystem.config.js --only server
        ;;
    *) echo 'start, stop, restart, delete, start-server, restart-server, stop-server, delete-server' ;;
    esac
else
    echo 'start, stop, restart, delete, start-server, restart-server, stop-server, delete-server'
fi
