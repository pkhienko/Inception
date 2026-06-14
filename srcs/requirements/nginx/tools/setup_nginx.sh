#!/bin/bash

/usr/local/bin/generate_ssl.sh

echo "Start NginX"

exec nginx -g "daemon off;"
