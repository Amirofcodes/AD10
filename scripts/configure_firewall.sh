#!/bin/bash

echo "Configuring firewall container for routing and NAT"

# Enable IP forwarding
docker exec ad10_firewall sysctl -w net.ipv4.ip_forward=1

# Flush existing rules
docker exec ad10_firewall iptables -F
docker exec ad10_firewall iptables -t nat -F

# Allow established and related connections
docker exec ad10_firewall iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Allow traffic from public to private network
docker exec ad10_firewall iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

# Allow return traffic from private to public
docker exec ad10_firewall iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT

# Set up NAT for private network
docker exec ad10_firewall iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

echo "Firewall configuration complete"
