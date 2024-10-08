#!/bin/bash

echo "Setting up SSH keys for inter-container communication"

# Generate SSH key on bastion
docker exec ad10_bastion ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

# Get the public key
PUBLIC_KEY=$(docker exec ad10_bastion cat /root/.ssh/id_rsa.pub)

# List of all containers
CONTAINERS=("firewall" "loadbalancer" "web1" "web2" "db1" "db2" "logs" "monitoring" "bastion")

# Distribute the public key to all containers
for container in "${CONTAINERS[@]}"; do
    echo "Adding public key to $container"
    docker exec ad10_$container mkdir -p /root/.ssh
    docker exec ad10_$container bash -c "echo '$PUBLIC_KEY' >> /root/.ssh/authorized_keys"
    docker exec ad10_$container chmod 700 /root/.ssh
    docker exec ad10_$container chmod 600 /root/.ssh/authorized_keys
done

echo "SSH key setup complete"
