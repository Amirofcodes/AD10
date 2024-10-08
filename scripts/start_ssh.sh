#!/bin/bash

for machine in gateway loadbalancer web1 web2 db1 db2 logging monitoring bastion; do
    echo "Starting SSH on $machine"
    docker exec ad10_$machine service ssh start
    echo "Checking SSH status on $machine"
    docker exec ad10_$machine service ssh status
    echo "------------------------"
done
