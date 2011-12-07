make_name_tripcode() {
	# TODO: Make the regex thingy
	name=$1
	securesalt="fatfuck"
	
	# parse tripcode
	if [[ ! "$name" =~ ^([^#]+)#(.+)$ ]]; then
		# no tripcode supplied; return with just name
		echo $name
		return 0
	fi
	
	# extract name
	name="${BASH_REMATCH[1]}"
	tripcode="${BASH_REMATCH[2]}"
	
	if [[ "$tripcode" =~ ^(.+?)?##(.+)?$ ]]; then
		# secure tripcode
		tripcode="${BASH_REMATCH[1]}"
		secure="${BASH_REMATCH[2]}"
	else
		# standard tripcode
		secure=""
	fi
	
	echo -n $name

	if [ "$tripcode" != "" ]; then
		tripcode=$(echo $tripcode | iconv -f utf8 -t shift_jis)

		# Make salt
		salt=$(echo "${tripcode}H.." | cut -b 2,3)
		salt=$(echo $salt | sed 's/[^\.-z]/./g')
		salt=$(echo -n $salt | tr ':;<=>?@[\\]^_`' 'ABCDEFGabcdef')

		# TODO: Add mcrypt support
		tripcode=$(perl -e 'print crypt($ARGV[0], $ARGV[1])' $tripcode $salt)
		tripcode=$(echo -n $tripcode | tail -c 10)
		
		echo -n "!$tripcode"
	fi
	
	# FIXME: This seems broken
	if [ "$secure" != "" ]; then		
		secure=$(echo -n "${secure}${securesalt}" | openssl sha1 -binary | base64 | cut -b 1-10)
		
		echo -n "!!$secure"
	fi
	
	# end with a new line
	echo
}

make_name_tripcode $1