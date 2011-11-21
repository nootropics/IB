http_header() {
	http_headers=( ["$1"]="$2")
	
}

# print HTTP headers; start sending content.
http_headers() {
	echo "HTTP/1.1 $1 $2"
	
	for header in "${!http_headers[@]}"; do
		echo "$header: ${http_headers[$header]}"
	done
	
	echo ""
}

declare -A http_headers
