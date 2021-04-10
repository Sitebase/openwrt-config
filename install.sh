ip="192.168.8.1"
logtag="sitebase"

source .secrets


mkdir -p dist/

for f in common.* 
do
	echo "parse $f"
    envsubst < $f > dist/$f 
done

# Copy required files to device
scp dist/*.config root@${ip}:/tmp/
scp .secrets root@${ip}:~/
scp .profile root@${ip}:~/

#ssh root@${ip} "/etc/init.d/dropbear restart"

ssh root@${ip} "opkg update && opkg install gl-files-brower luci luci-app-simple-adblock"

#ssh root@${ip} "logger -t ${logtag} Update config"

ssh root@${ip} "cat /tmp/common.dropbear.config | uci -m import dropbear && uci commit"
ssh root@${ip} "cat /tmp/common.wireless.config | uci -m import wireless && uci commit"
ssh root@${ip} "cat /tmp/common.dhcp.config | uci -m import dhcp && uci commit"
ssh root@${ip} "cat /tmp/common.system.config | uci -m import system && uci commit"
ssh root@${ip} "cat /tmp/common.glconfig.config | uci -m import glconfig && uci commit"

#ssh root@${ip} "/etc/init.d/dnsmasq restart"
#ssh root@${ip} "/etc/init.d/odhcpd restart"
#ssh root@${ip} "/etc/init.d/uhttpd restart" # required for SSSL install
