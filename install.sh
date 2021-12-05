ip="192.168.8.1"
logtag="sitebase"

source .secrets


mkdir -p dist/

for f in config/*
do
	echo "parse $f"
    envsubst < $f > dist/$(basename $f)
done

# Keep rsyslog file intact because it contains dollar sign strings
# which will otherwise be removed by envsubst
cp config/rsyslog.conf dist/

# Copy required files to device
scp dist/* root@${ip}:/tmp/
scp .secrets root@${ip}:~/
scp .profile root@${ip}:~/

#ssh root@${ip} "/etc/init.d/dropbear restart"

ssh root@${ip} "opkg update && opkg install gl-files-brower luci adblock luci-app-adblock mosquitto-ssl mosquitto-client-ssl libmosquitto-ssl rsyslog vsftpd"

#ssh root@${ip} "logger -t ${logtag} Update config"

ssh root@${ip} "cat /tmp/dropbear | uci -m import dropbear && uci commit"
ssh root@${ip} "cat /tmp/wireless | uci -m import wireless && uci commit"
ssh root@${ip} "cat /tmp/dhcp | uci -m import dhcp && uci commit"
ssh root@${ip} "cat /tmp/system | uci -m import system && uci commit"
ssh root@${ip} "cat /tmp/glconfig | uci -m import glconfig && uci commit"

#ssh root@${ip} "/etc/init.d/dnsmasq restart"
#ssh root@${ip} "/etc/init.d/odhcpd restart"
#ssh root@${ip} "/etc/init.d/uhttpd restart" # required for SSSL install

# ensure MQTT server is configured running
ssh root@${ip} "cat /tmp/mosquitto.conf > /etc/mosquitto/mosquitto.conf"
ssh root@${ip} "/etc/init.d/mosquitto enable && /etc/init.d/mosquitto restart"

# ensure vsftpd running and configured
ssh root@${ip} "cat /tmp/vsftpd.conf > /etc/vsftpd.conf"
ssh root@${ip} "/etc/init.d/vsftpd enable && /etc/init.d/vsftpd restart"

# ensure rsyslog running and configured
ssh root@${ip} "cat /tmp/rsyslog.conf > /etc/rsyslog.conf"
ssh root@${ip} "/etc/init.d/rsyslog enable && /etc/init.d/rsyslog restart"
