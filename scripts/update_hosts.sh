#!/bin/bash

machines=("firewall" "loadbalancer" "web1" "web2" "db1" "db2" "logs" "monitoring" "bastion")

for machine in "${machines[@]}"; do
    echo "Updating /etc/hosts for $machine"

    # Get the IP address of the container
    ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ad10_$machine)

    # Update the /etc/hosts file
    for other_machine in "${machines[@]}"; do
        other_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ad10_$other_machine)
        docker exec ad10_$machine bash -c "echo '$other_ip $other_machine' >> /etc/hosts"
    done

    echo "------------------------"
done
