#!/bin/bash

# Includes
. http.sh
. functions.sh

http_header "Content-Type" "text/html"
http_header "X-Powered-By" "IB"

# Stuff goes here.
# 
# ...

http_headers 200 "OK"
echo -n 'h'

exit 0

