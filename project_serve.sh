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
    *) echo 'start, stop, restart, delete' ;;
    esac
else
    echo 'start, stop, restart, delete'
fi
