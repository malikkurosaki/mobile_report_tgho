#!/usr/bin/env bash

help() {
    menu="$(tput setaf 2)
    Penggunaan: 
    h,     help        untuk menampilkan bantuan
    $(tput sgr0)"

    echo "${menu}" | sed 's/^ *//g'
}
help

run() {
    r="
    - server
    - client
    "
    echo "${r}" | sed 's/^ *//g'
    read -p "> " run
    case "$run" in
    server)
        echo "run server"
        exit 0

        ;;
    client)
        echo "run client"
        exit 0

        ;;
    *)
        echo "run server"
        ;;
    esac
}

while true; do
    read -p "Masukkan Piliannya: " pil
    case "$pil" in
    r) run ;;
    x)
        echo "selamat tinggal ..."
        exit 0
        ;;
    *)
        help
        ;;
    esac
done
