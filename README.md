What's the reason for setting country on wifi?
    option country 'BE'
    
Add domain for syslog to /etc/config/dhcp
For example
syslog.sitebase.be resolve to 192.168.8.1
this way we can use domain names in my iot devices and laptop
If not on Sitebase network it will not resolve




Install central logging

## Use mqtt on openwrt
mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASSWORD -t "homeassistant/openwrt/started" -m "${HOSTNAME}" -p 1883

## Push router gpio state changes to mqtt
add script to /etc/hotplug.d/button/buttons

```
source /root/.secrets
logger -t gpio "${BUTTON} state changed to ${ACTION}"
mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASSWORD -t "openwrt/gpio/${BUTTON}" -m "${ACTION}" -p 1883
```


## Packages
Needed for home assistant support
opkg install luci-mod-rpc
