#!/usr/bin/env bash
http_client() {
    echo "http serve client"
    python3 -m http.server --directory ./client/build/web --bind 127.0.0.1 9000
}

http_server() {
    echo "http serve server"
    node ./server/index.js --name mobile_report -i 1
}

if [[ $# -ne 0 ]]; then
    case $1 in
    client)
        http_client
        ;;
    server)
        http_server
        ;;
    *) echo 'client or server' ;;
    esac
else
    echo 'client or server'
fi
