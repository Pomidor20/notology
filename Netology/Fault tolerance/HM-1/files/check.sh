#!/bin/bash

file="/var/www/html/index.nginx-debian.html"
server=127.0.0.1
port=80


if [ ! -f $file ]; then
exit 1
fi

nc -z "$server" "$port" >/dev/null 2>&1

if [ $? -ne 0 ]; then
exit 1
fi
