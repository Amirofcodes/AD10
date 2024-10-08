#!/bin/bash

machines=("firewall" "loadbalancer" "web1" "web2" "db1" "db2" "logs" "monitoring" "bastion")
base_port=2200

for i in "${!machines[@]}"; do
    machine="${machines[$i]}"
    port=$((base_port + i))

    echo "Connecting to $machine on port $port"

    # Try to connect with a 5-second timeout
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=5 -i ~/.ssh/id_rsa root@localhost -p $port exit
    exit_status=$?

    if [ $exit_status -eq 0 ]; then
        echo "Successfully connected to $machine"
    else
        echo "Failed to connect to $machine"
    fi

    echo "------------------------"
done
