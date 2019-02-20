#!/bin/bash

# Mongo Service
mongod_process=$(ps ax | grep "[m]ongod" | wc -l)
if [[ mongod_process -eq 0 ]]; then
    nohup /usr/bin/mongod --bind_ip_all --port $MONGO_PORT --dbpath /data/db --config /etc/mongod.conf &
fi

# Replica set configuration
primary_mongo=$(ifconfig | grep $PRIMARY_MONGO | wc -l)
mongo_master=$(mongo --host localhost:27017 --eval 'db.runCommand({isMaster:1})' | grep '"ismaster" : true' | wc -l)
if [[ $primary_mongo -eq 1 ]] && [[ $mongo_master -ne 1 ]]; then
    mongo --host localhost:27017 /etc/replSetConfig.js
fi
