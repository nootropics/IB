query() {
	sqlite3 -line "${CONFIG["db"]}" "$1"
	if [ $? != 0 ]; then
		# Error
		exit 0
	fi
}

fetch_rows() {
	if [ "$2" != "" ]; then
		arr_name="$2"
	else
		arr_name="row"
	fi
	
	declare -A row
	
	continue=1
	query "$1" | while [ $continue == 1 ]; do
		read line
		resp=$?
				
		if [ "$line" != "" ]; then
			if [[ "$line" =~ ^(.+)\ =\ (.+)$ ]]; then
				row[${BASH_REMATCH[1]}]="${BASH_REMATCH[2]}"
			elif [[ "$line" =~ ^(.+)\ =$ ]]; then
				row[${BASH_REMATCH[1]}]=""
			fi
			
		else
			if [[ $resp != 0 ]]; then
				continue=0
			fi
			
    			declare -p row | sed -e 's/^declare -A row=/declare -A '"$arr_name"'=/'
    			row=()
		fi
	done
}

install() {
	query "CREATE TABLE posts (id INTEGER PRIMARY KEY AUTOINCREMENT, time INTEGER KEY, name TEXT NULL, email TEXT NULL, subject TEXT NULL, body NOT NULL)"
}

#install

