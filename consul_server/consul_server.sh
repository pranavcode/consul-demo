#!/bin/bash

# Start Consul Agent in Server mode
consul agent -server \
    -bind $PRIVATE_IP_ADDRESS \
    -advertise $PRIVATE_IP_ADDRESS \
    -node $NODE \
    -client 0.0.0.0 \
    -dns-port 53 \
    -data-dir /data \
    -ui -bootstrap
