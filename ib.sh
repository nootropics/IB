#!/bin/bash

# Includes
. http.sh
. functions.sh
. strings.sh

http_header "Content-Type" "text/html; charset=utf-8"
http_header "X-Powered-By" "IB"

# Stuff goes here.
# 
# ...

http_headers 200 "OK"
echo -n 'h'

exit 0

