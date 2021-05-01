# This is to run validation in the workflow
echo "validate $GITHUB_WORKSPACE"
for i in *.config; do
    if ! uci show "${UCI_CONF}" > /dev/null
        then echo "${UCI_CONF}"
    fi
done
