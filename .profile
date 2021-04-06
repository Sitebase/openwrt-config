source ~/.secrets

mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASSWORD -t "homeassistant/openwrt/started" -m "${HOSTNAME}" -p 1883
