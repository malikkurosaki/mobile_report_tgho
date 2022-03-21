#!/usr/bin/env bash

help() {
    echo "$(tput setaf 2)
   Usage: ./command [options]
    Options: 
    -r, run: run server
    -h, help: show this help
    
   $(tput sgr0)"

}


case $1 in
run | -r)
   cd mobile_report_apk/server && pm2 start index.js -i 1 --name report
    ;;
help | -h)
    help
    ;;
*) help ;;
esac
