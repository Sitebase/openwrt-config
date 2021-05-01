# This is to run validation in the workflow
echo "validate $GITHUB_WORKSPACE"
for i in *.config; do
    if ! uci show "$i" > /dev/null
        then echo "$i"
    fi
done
