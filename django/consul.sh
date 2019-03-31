#!/bin/bash

consul agent -bind $PRIVATE_IP_ADDRESS \
    -advertise $PRIVATE_IP_ADDRESS \
    -join consul_server_$DATACENTER \
    -node $NODE \
    -dns-port 53 \
    -data-dir /data \
    -config-dir /etc/consul.d \
    -datacenter $DATACENTER \
    -enable-local-script-checks
