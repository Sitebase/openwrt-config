# This is to run validation in the workflow

echo "Test show bla"
uci -c "${GITHUB_WORKSPACE}" show bla

#echo "Test import"
#uci -m import bla && uci commit

#echo "Show all"
#uci -P "${GITHUB_WORKSPACE}/" show bla

echo "Test show dhcp"
uci -c "${GITHUB_WORKSPACE}" show dhcp

echo "start validate $GITHUB_WORKSPACE"
for i in ( bla dhcp ); do
	if ! uci -c "${GITHUB_WORKSPACE}" show "${i}" > /dev/null
		then echo "$i"
	fi
done
