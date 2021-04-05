What's the reason for setting country on wifi?
    option country 'BE'
    
Add domain for syslog to /etc/config/dhcp
For example
syslog.sitebase.be resolve to 192.168.8.1
this way we can use domain names in my iot devices and laptop
If not on Sitebase network it will not resolve




Install central logging


## Packages
Needed for home assistant support
opkg install luci-mod-rpc
