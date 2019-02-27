#!/bin/bash
mongo_master=$(mongo --host localhost:27017 --eval 'db.runCommand({isMaster:1})' | grep '"ismaster" : true' | wc -l)
consul_agent=$(ps ax | grep "[c]onsul agent" | wc -l)

if [[ $mongo_master -eq 1 ]] && [[ $consul_agent -ne 1 ]]; then
    consul agent -bind $PRIVATE_IP_ADDRESS \
        -advertise $PRIVATE_IP_ADDRESS \
        -join consul_server \
        -dns-port 53 \
        -data-dir /data \
        -config-dir /etc/consul.d \
        -enable-local-script-checks
fi
