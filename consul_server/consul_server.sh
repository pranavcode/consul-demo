#!/bin/bash

# Start Consul Agent in Server mode
consul agent -server \
    -bind $PRIVATE_IP_ADDRESS \
    -advertise $PRIVATE_IP_ADDRESS \
    -dns-port 53 \
    -data-dir /data \
    -bootstrap
