#!/bin/bash

mongo_primary=$(mongo --quiet --eval 'JSON.stringify(db.isMaster())' | jq -r .ismaster)
if [[ $mongo_primary == false ]]; then
    exit 123
fi
