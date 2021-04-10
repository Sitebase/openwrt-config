# My OpenWRT Config
In this repository you'll find my OpenWRT configuration.

## Hardware
The router I've chose is the GL iNet 750s. Some of the reasons for this are the small form factor and the low power consumption (my current setup +-3W). 
Besides that it ships with OpenWRT installed out of the box.

![hardware.png](GL iNet 750s)

## Secrets
As you might notice in some of the config files. I'm using variables for some sesitive information like MAC addresses or passwords. These are all defined as environment variables in the `.secrets` file which is encrypted using `git-crypt`. To give you an idea how this secret file looks once decrypted you can see the snippet below:

```
export WIFI_2G_PASSWORD=passhere
export WIFI_5G_PASSWORD=passhere

# accounts
export MQTT_USER=myuser
export MQTT_PASSWORD=mypassword
export MQTT_HOST=192.168.8.101

# device mac addresses
export MAC_RPI_HOMEASSISTANT_ETH="00:00:00:00:00:00"
export MAC_HUE_BRIDGE_ETH="00:00:00:00:00:01"
export MAC_PHONE_WIM_WIFI="00:00:00:00:00:02"
```

## MQTT Publish on OpenWRT
If you have a home automation system on your network it could be useful to send events to a MQTT broker based on events happening on your router.

```
mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASSWORD -t "homeassistant/openwrt/started" -m "${HOSTNAME}" -p 1883
```

### Example for pushing events to MQTT
Create a script in `/etc/hotplug.d/button/99-buttons` with following content:
```
source /root/.secrets
logger -t gpio "${BUTTON} state changed to ${ACTION}"
mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASSWORD -t "openwrt/gpio/${BUTTON}" -m "${ACTION}" -p 1883
```
This script will automatically trigger MQTT events based on buttons pressed on the router.

## Packages
List of the packages I'm using and the reason why:
* luci-mod-rpc: Way to push devices statuses to Home Assistant
* luci-app-simple-adblock: Block ads and trackers
