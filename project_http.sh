#!/usr/bin/env bash
http_serve(){
    echo "http server"
    python3 -m http.server --directory ./client/build/web  --bind 127.0.0.1 9000
    pm2 start ./server/index.js --name mobile_report -i 1
}