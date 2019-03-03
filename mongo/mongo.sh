#!/bin/bash

# Mongo Service
nohup /usr/bin/mongod --bind_ip_all --port $MONGO_PORT --dbpath /data/db --replSet "consuldemo" --config /etc/mongod.conf &

# Replica set configuration
# Wait until Mongo starts
while [[ $(ps aux | grep [m]ongod | wc -l) -ne 1 ]]; do
    sleep 5
done

# Wait until Mongo ready
while [[ $(mongo --quiet --eval 'JSON.stringify(db.stats())' | jq -r .ok 2> /dev/null) -ne 1 ]]; do
    sleep 5
done

# Configure replica set
primary_mongo=$(ifconfig | grep $PRIMARY_MONGO | wc -l)
if [[ $primary_mongo -eq 1 ]]; then
    mongo /etc/replSetConfig.js
fi
