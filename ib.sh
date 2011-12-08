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
. display.sh

http_header "Content-Type" "text/plain; charset=utf-8"
http_header "X-Powered-By" "IB"

# Stuff goes here.
# 
# ...

declare -A row

case $REQUEST_URI in
	"/" )
		http_header "Content-Type" "text/html; charset=utf-8"
		http_headers 200 "OK"
		
		# show threads on page 1
		index 1
		
		;;
	"/style.css" )
		http_header "Content-Type" "text/css"
		http_headers 200 "OK"
		
		cat style.css
		
		;;
	* )
		http_headers 404 "Not Found"
		echo -n '404 Not Found'
esac

exit 0

