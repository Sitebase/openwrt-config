ip="192.168.8.1"
sshkey="openwrt.pub"
logtag="sitebase"

source .secrets

mkdir -p dist/

for f in common.* 
do
	echo "parse $f"
    envsubst < $f > dist/$f 
done

# Copy required files to device
scp -i "~/.ssh/openwrt" dist/*.config root@${ip}:/tmp/
scp -i "~/.ssh/openwrt" .secrets root@${ip}:~/
scp -i "~/.ssh/openwrt" .profile root@${ip}:~/

#ssh -i "~/.ssh/openwrt" root@${ip} "cat /tmp/${sshkey} > /etc/dropbear/authorized_keys"
#ssh -i "~/.ssh/openwrt" root@${ip} "/etc/init.d/dropbear restart"

#ssh -i "~/.ssh/openwrt" root@${ip} "opkg update && opkg install luci-app-simple-adblock luci-mod-rpc"

#ssh -i "~/.ssh/openwrt" root@${ip} "logger -t ${logtag} Update config"

ssh -i "~/.ssh/openwrt" root@${ip} "cat /tmp/common.dropbear.config | uci -m import dropbear && uci commit"
ssh -i "~/.ssh/openwrt" root@${ip} "cat /tmp/common.wireless.config | uci -m import wireless && uci commit"
ssh -i "~/.ssh/openwrt" root@${ip} "cat /tmp/common.dhcp.config | uci -m import dhcp && uci commit"
ssh -i "~/.ssh/openwrt" root@${ip} "cat /tmp/common.system.config | uci -m import system && uci commit"

#ssh -i "~/.ssh/openwrt" root@${ip} "/etc/init.d/dnsmasq restart"
#ssh -i "~/.ssh/openwrt" root@${ip} "/etc/init.d/odhcpd restart"
