#!/bin/bash

echo "Current directory: $(pwd)"
echo "Listing directory contents:"
ls -l

SCRIPT_DIR="$(dirname "$0")"
chmod +x $SCRIPT_DIR/start_ssh.sh $SCRIPT_DIR/connect_ssh.sh

echo 'Running start_ssh.sh...'
$SCRIPT_DIR/start_ssh.sh

echo 'Running connect_ssh.sh...'
$SCRIPT_DIR/connect_ssh.sh
