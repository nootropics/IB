#!/bin/bash

scriptname="${BASH_SOURCE[0]}"
while [ -h "$scriptname" ]; do
	scriptname=$(readlink "$scriptname")
done
cd $(dirname "$scriptname")

# Includes
. config.sh

. http.sh
. functions.sh
. database.sh
. strings.sh

http_header "Content-Type" "text/html; charset=utf-8"
http_header "X-Powered-By" "IB"

# Stuff goes here.
# 
# ...

http_headers 200 "OK"
make_name_tripcode "moot#faggot"


exit 0

