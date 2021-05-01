# This is to run validation in the workflow
echo "start validate $GITHUB_WORKSPACE"
for i in *.config; do
	echo "validate $i"
    if ! uci show "${GITHUB_WORKSPACE}${i}" > /dev/null
        then echo "$i"
    fi
done
