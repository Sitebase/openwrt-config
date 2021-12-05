# run validation in github workflow
cd ${GITHUB_WORKSPACE}/config/
for i in *; do
	if ! uci -c "${GITHUB_WORKSPACE}/config" show "${i}" > /dev/null
	then
		echo "invalid config -> $i"
		exit 1
	else
		echo "valid $i"
	fi
done
