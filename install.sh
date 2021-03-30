ip="192.168.2.1"
sshkey="openwrt.pub"
logtag="sitebase"

# Copy required files to device
scp -i "~/.ssh/openwrt" *.config root@${ip}:/tmp/
scp -i "~/.ssh/openwrt" ~/.ssh/${sshkey} root@${ip}:/tmp/

ssh -i "~/.ssh/openwrt" root@${ip} "cat /tmp/${sshkey} > /etc/dropbear/authorized_keys"
ssh -i "~/.ssh/openwrt" root@${ip} "/etc/init.d/dropbear restart"

ssh -i "~/.ssh/openwrt" root@${ip} "logger -t ${logtag} Update dropbear config"
ssh -i "~/.ssh/openwrt" root@${ip} "cat /tmp/common.dropbear.config | uci -m import dropbear && uci commit"
