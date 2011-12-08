index() {
	
	cat << HTML
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" media="screen" href="/style.css" />
</head>
<body>
HTML

	fetch_rows "SELECT * FROM posts ORDER BY time DESC" "post" | while read row; do
		eval $row
	
		formatted_time=$(echo "${post['time']}" | awk '{print strftime("%c", $1)}')
	
	cat << HTML
	<div class="post reply">
		<p class="intro">
			<span class="name">${post['name']}</span>
			$formatted_time No.${post['id']}
		</p>
		<p class="body">${post['body']}</p>
	</div>
HTML
	
	done

	cat << HTML
</body>
</html>
HTML
	
}

