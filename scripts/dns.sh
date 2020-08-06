#!/bin/bash
# Run these command to get you network
# networksetup -listallnetworkservices

cmd="$1"
case $cmd in
  "reset")
    sudo networksetup -setdnsservers Wi-Fi empty
    ;;

  "google")
    sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
    ;;

  "cloudflare")
    sudo networksetup -setdnsservers Wi-Fi 1.1.1.1
    ;;

  "proxy")
    sudo networksetup -setdnsservers Wi-Fi 127.0.0.1 8.8.8.8 8.8.4.4
    ;;


  *)
    echo "Specify your command: reset/google/cloudflare"
    exit 1
    ;;
esac

sudo killall -HUP mDNSResponder
