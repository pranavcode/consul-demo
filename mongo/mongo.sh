#!/bin/bash

# Mongo Service
nohup /usr/bin/mongod --bind_ip_all --port $MONGO_PORT --dbpath /data/db --replSet "consuldemo" --config /etc/mongod.conf &

# Replica set configuration
# Wait until Mongo ready
until [[ $(mongo --quiet --eval 'JSON.stringify(db.stats())' | jq -r .ok 2> /dev/null) -eq 1 ]]; do
    sleep 3
done

# Configure replica set
primary_mongo=$(ifconfig | grep $PRIMARY_MONGO | wc -l)
if [[ $primary_mongo -eq 1 ]]; then
    mongo /etc/replSetConfig.js
fi
