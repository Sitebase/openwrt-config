ip="192.168.8.1"
logtag="sitebase"

source .secrets


mkdir -p dist/

for f in config/* 
do
	echo "parse $f"
    envsubst < $f > dist/$(basename $f)
done

# Copy required files to device
scp dist/* root@${ip}:/tmp/
scp .secrets root@${ip}:~/
scp .profile root@${ip}:~/

#ssh root@${ip} "/etc/init.d/dropbear restart"

ssh root@${ip} "opkg update && opkg install gl-files-brower luci luci-app-simple-adblock mosquitto-ssl mosquitto-client-ssl libmosquitto-ssl rsyslog"

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
