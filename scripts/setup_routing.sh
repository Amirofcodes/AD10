#!/bin/bash

echo "Setting up routing for inter-network communication"

# Get firewall IP address
FIREWALL_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ad10_firewall)

# Add route on bastion to reach private network through firewall
docker exec ad10_bastion ip route add 172.19.0.0/16 via $FIREWALL_IP

echo "Routing setup complete"
