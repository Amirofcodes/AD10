#!/bin/bash

echo "Setting up SSH keys for inter-container communication"

# Generate SSH key on bastion
docker exec ad10_bastion ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

# Generate SSH key on firewall
docker exec ad10_firewall ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

# Get the public keys
BASTION_PUBLIC_KEY=$(docker exec ad10_bastion cat /root/.ssh/id_rsa.pub)
FIREWALL_PUBLIC_KEY=$(docker exec ad10_firewall cat /root/.ssh/id_rsa.pub)

# List of all containers
CONTAINERS=("firewall" "loadbalancer" "web1" "web2" "db1" "db2" "logs" "monitoring" "bastion")

# Distribute the public keys to all containers
for container in "${CONTAINERS[@]}"; do
    echo "Adding public keys to $container"
    docker exec ad10_$container mkdir -p /root/.ssh
    docker exec ad10_$container bash -c "echo '$BASTION_PUBLIC_KEY' >> /root/.ssh/authorized_keys"
    docker exec ad10_$container bash -c "echo '$FIREWALL_PUBLIC_KEY' >> /root/.ssh/authorized_keys"
    docker exec ad10_$container chmod 700 /root/.ssh
    docker exec ad10_$container chmod 600 /root/.ssh/authorized_keys
done

# Copy bastion's private key to firewall for jump host functionality
BASTION_PRIVATE_KEY=$(docker exec ad10_bastion cat /root/.ssh/id_rsa)
docker exec ad10_firewall bash -c "echo '$BASTION_PRIVATE_KEY' > /root/.ssh/id_rsa_bastion && chmod 600 /root/.ssh/id_rsa_bastion"

echo "SSH key setup complete"
