query() {
	sqlite3 "${CONFIG["db"]}" "$1"
	if [ $? != 0 ]; then
		# Error
		exit 0
	fi
}

install() {
	query "CREATE TABLE posts (id INTEGER PRIMARY KEY AUTOINCREMENT, time INTEGER KEY, name TEXT NULL, email TEXT NULL, subject TEXT NULL, body NOT NULL)"
}

#install

