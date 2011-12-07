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
query "SELECT * FROM posts ORDER BY time DESC" | while read row; do
	declare -A post
	
	post["id"]=$(echo $row | awk '{split($0, a, "|"); print a[1]}')
	post["time"]=$(echo $row | awk '{split($0, a, "|"); print a[2]}')
	post["name"]=$(echo $row | awk '{split($0, a, "|"); print a[3]}')
	post["email"]=$(echo $row | awk '{split($0, a, "|"); print a[4]}')
	post["subject"]=$(echo $row | awk '{split($0, a, "|"); print a[5]}')
	post["body"]=$(echo $row | awk '{split($0, a, "|"); print a[6]}')
	
	formatted_time=$(echo "${post['time']}" | awk '{print strftime("%c", $1)}')
	
	echo -n	'<div class="post">'
	echo -n '<span class="name">'"${post['name']}"'</span>' \
		"$formatted_time" \
		"No.${post['id']}"
	echo -n "<p>${post['body']}</p>"
	echo -n '</div>'
done

exit 0

