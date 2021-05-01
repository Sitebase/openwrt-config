# This is to run validation in the workflow

echo "Test all"
uci -P "${GITHUB_WORKSPACE}/" show all
echo "Testing"
uci -P "${GITHUB_WORKSPACE}/" show bla
echo "Test DHCP"
uci -P "${GITHUB_WORKSPACE}/" show dhcp

echo "Test import"
uci -m import bla && uci commit

echo "Show all"
uci -P "${GITHUB_WORKSPACE}/" show bla

echo "start validate $GITHUB_WORKSPACE"
for i in *.config; do
	echo "-> ${GITHUB_WORKSPACE}/${i}"
	uci show "${GITHUB_WORKSPACE}/${i}"
    #if ! uci show "${GITHUB_WORKSPACE}${i}" > /dev/null
        #then echo "$i"
    #fi
done
