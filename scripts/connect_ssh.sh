#!/bin/bash

machines=("gateway" "loadbalancer" "web1" "web2" "db1" "db2" "logging" "monitoring" "bastion")
ports=(2223 2224 2225 2226 2227 2228 2229 2230 2231)

for i in "${!machines[@]}"; do
    machine="${machines[$i]}"
    port="${ports[$i]}"

    echo "Connecting to $machine on port $port"

    # Try to connect with a 60-second timeout
    (ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/id_rsa root@localhost -p $port exit) &
    ssh_pid=$!

    # Wait for 60 seconds
    for ((i=1; i<=60; i++)); do
        if ! kill -0 $ssh_pid 2>/dev/null; then
            wait $ssh_pid
            exit_status=$?
            break
        fi
        sleep 1
    done

    # If the process is still running after 60 seconds, kill it
    if kill -0 $ssh_pid 2>/dev/null; then
        kill $ssh_pid
        wait $ssh_pid 2>/dev/null
        exit_status=124  # Timeout exit code
    fi

    if [ $exit_status -eq 0 ]; then
        echo "Successfully connected to $machine"
    else
        echo "Failed to connect to $machine"
    fi

    echo "------------------------"
done
