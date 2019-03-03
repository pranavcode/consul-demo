#!/bin/bash

mongo_primary=$(mongo --quiet --eval 'JSON.stringify(db.isMaster())' | jq -r .ismaster 2> /dev/null)
if [[ $mongo_primary == false ]]; then
    exit 1
fi

echo "Mongo primary healthy and reachable"
