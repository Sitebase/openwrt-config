# This is to run validation in the workflow
local UCI_CONFS="${@:-/etc/config/*}"
for UCI_CONF in ${UCI_CONFS}
do
    if ! uci show "${UCI_CONF}" > /dev/null
        then echo "${UCI_CONF}"
    fi
done
