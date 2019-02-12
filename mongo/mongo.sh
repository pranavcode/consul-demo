#!/bin/bash

# Mongo Service
/usr/bin/mongod --bind_ip_all --port $MONGO_PORT --dbpath /data/db --config /etc/mongod.conf

# Replica set configuration
configure_replica_set() {
    var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [{
            "_id": 0,
            "host": "mongo_1:27017",
            "priority": 2
        }, {
            "_id": 1,
            "host": "mongo_2:27017",
            "priority": 0
        }, {
            "_id": 2,
            "host": "mongo_3:27017",
            "priority": 0
        }], 
        settings: { chainingAllowed: true }
    };
    rs.initiate(cfg, { force: true });
    rs.reconfig(cfg, { force: true });
    rs.slaveOk();
    db.getMongo().setReadPref('nearest');
    db.getMongo().setSlaveOk(); 
}

if [ $PRIMARY -e '1' ]
then
    mongo --host locahost:27017 "$(declare -f configure_replica_set); configure_replica_set"
fi
