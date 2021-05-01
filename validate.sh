# This is to run validation in the workflow

echo "Testing"
uci show bla -P "${GITHUB_WORKSPACE}"

echo "start validate $GITHUB_WORKSPACE"
for i in *.config; do
	echo "-> ${GITHUB_WORKSPACE}${i}"
	uci show "${GITHUB_WORKSPACE}${i}"
    #if ! uci show "${GITHUB_WORKSPACE}${i}" > /dev/null
        #then echo "$i"
    #fi
done
