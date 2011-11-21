make_name_tripcode() {
	# TODO: Make the regex thingy
	name="Name"
	tripcode="faggot"
	secure="niggers1"
	salt="fatfuck"

	if [ "$tripcode" != "" ]; then
		tripcode=$(echo $tripcode | iconv -f utf8 -t shift_jis)

		# Make salt
		salt=$(echo "${tripcode}H.." | cut -b 2,3)
		salt=$(echo $salt | sed 's/[^\.-z]/./g')
		salt=$(echo -n $salt | tr ':;<=>?@[\\]^_`' 'ABCDEFGabcdef')

		# TODO: Add mcrypt support
		tripcode=$(perl -e 'print crypt($ARGV[0], $ARGV[1])' $tripcode $salt)
		tripcode=$(echo -n $tripcode | tail -c 10)
	fi

	
	# FIXME: This seems broken
	if [ "$secure" != "" ]; then
		secure=$(echo -n "${secure}${salt}" | sha1sum | xxd -p | tr -d '\n')
		secure=$(echo -n $secure | base64)
		secure=$(echo -n $secure | cut -b 1-10)
	fi
	
	echo "!$tripcode"
	echo "!!$secure"
	#name=$salt
	#tripcode=$tripcode
}

make_name_tripcode
