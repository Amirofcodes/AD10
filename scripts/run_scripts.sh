#!/bin/bash

echo "Current directory: $(pwd)"
echo "Listing directory contents:"
ls -l

SCRIPT_DIR="$(dirname "$0")"
chmod +x $SCRIPT_DIR/*.sh

echo 'Running start_ssh.sh...'
$SCRIPT_DIR/start_ssh.sh

echo 'Running update_hosts.sh...'
$SCRIPT_DIR/update_hosts.sh

echo 'Running setup_ssh_keys.sh...'
$SCRIPT_DIR/setup_ssh_keys.sh

echo 'Running configure_firewall.sh...'
$SCRIPT_DIR/configure_firewall.sh

echo 'Running connect_ssh.sh...'
$SCRIPT_DIR/connect_ssh.sh
