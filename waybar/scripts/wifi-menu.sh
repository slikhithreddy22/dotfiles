#!/usr/bin/env bash

# Scan and list available wifi networks via rofi + nmcli

ACTIVE=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

NETWORKS=$(nmcli -t -f ssid,signal,security dev wifi list 2>/dev/null \
    | awk -F: '!seen[$1]++ && $1!=""' \
    | sort -t: -k2 -rn \
    | awk -F: '{
        icon = ($3 == "--" || $3 == "") ? "󰤟" : "󰤢"
        printf "%s  %s  (%s%%)\n", icon, $1, $2
      }')

CHOSEN=$(echo "$NETWORKS" | rofi -dmenu -i -p "  WiFi" -theme-str 'window {width: 400px;}')

[ -z "$CHOSEN" ] && exit 0

SSID=$(echo "$CHOSEN" | sed 's/^..  //' | sed 's/  (.*//')

# If already connected to this network, disconnect
if [ "$ACTIVE" = "$SSID" ]; then
    nmcli dev disconnect wlan0
    notify-send "WiFi" "Disconnected from $SSID"
    exit 0
fi

# Try connecting to saved connection first
if nmcli con up "$SSID" 2>/dev/null; then
    notify-send "WiFi" "Connected to $SSID"
    exit 0
fi

# Ask for password via rofi
PASS=$(rofi -dmenu -p "  Password for $SSID" -password -theme-str 'window {width: 400px;}')

[ -z "$PASS" ] && exit 0

if nmcli dev wifi connect "$SSID" password "$PASS"; then
    notify-send "WiFi" "Connected to $SSID"
else
    notify-send -u critical "WiFi" "Failed to connect to $SSID"
fi
