#!/bin/sh
set -e

# Start NordVPN daemon
/etc/init.d/nordvpn start
sleep 3

# Login using token (if not already logged in)
if [ -n "$NORDVPN_TOKEN" ]; then
  yes n | nordvpn login --token "$NORDVPN_TOKEN"
fi

# Set VPN technology (NordLynx or OpenVPN)
if [ -n "$NORDVPN_TECHNOLOGY" ]; then
  nordvpn set technology "$NORDVPN_TECHNOLOGY"
fi

# Enable LAN discovery
nordvpn set lan-discovery on

# Connect to specified country/server
if [ -n "$NORDVPN_COUNTRY" ]; then
  nordvpn connect "$NORDVPN_COUNTRY"
else
  nordvpn connect 
fi

chattr -i /etc/resolv.conf

# Start proxy.py
exec proxy --hostname 0.0.0.0 --port "${PROXY_PORT:-8899}"

