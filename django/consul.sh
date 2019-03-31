#!/bin/bash

consul agent -bind $PRIVATE_IP_ADDRESS \
    -advertise $PRIVATE_IP_ADDRESS \
    -join consul_server \
    -node $NODE \
    -dns-port 53 \
    -data-dir /data \
    -config-dir /etc/consul.d \
    -enable-local-script-checks
