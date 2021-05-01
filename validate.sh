# This is to run validation in the workflow

#echo "Test show bla"
#uci -c "${GITHUB_WORKSPACE}" show bla

#echo "Test import"
#uci -m import bla && uci commit

#echo "Show all"
#uci -P "${GITHUB_WORKSPACE}/" show bla

#echo "Test show dhcp"
#uci -c "${GITHUB_WORKSPACE}" show dhcp

cd ${GITHUB_WORKSPACE}/config/
for i in *; do
	if ! uci -c "${GITHUB_WORKSPACE}/config" show "${i}" > /dev/null
		then 
			echo "invalid config -> $i"
			exit 1
	fi
done
