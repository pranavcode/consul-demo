#!/bin/bash

mongo_secondary=$(mongo --quiet --eval 'JSON.stringify(db.isMaster())' | jq -r .secondary)
if [[ $mongo_secondary == false ]]; then
    exit 123
fi
