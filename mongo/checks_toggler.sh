#!/bin/bash

# Wait until Mongo starts
while [[ $(ps aux | grep [m]ongod | wc -l) -ne 1 ]]; do
    sleep 5
done

REGISTER_MASTER=0
REGISTER_SECONDARY=0

mongo_primary=$(mongo --quiet --eval 'JSON.stringify(db.isMaster())' | jq -r .ismaster 2> /dev/null)
mongo_secondary=$(mongo --quiet --eval 'JSON.stringify(db.isMaster())' | jq -r .secondary 2> /dev/null)  

if [[ $mongo_primary == false && $mongo_secondary == true ]]; then

  # Deregister as Mongo Master
  if [[ -a /etc/consul.d/check_scripts/mongo_primary_check.sh && -a /etc/consul.d/mongo_primary.json ]]; then
    rm -f /etc/consul.d/check_scripts/mongo_primary_check.sh
    rm -f /etc/consul.d/mongo_primary.json

    REGISTER_MASTER=1
  fi

  # Register as Mongo Secondary
  if [[ ! -a /etc/consul.d/check_scripts/mongo_secondary_check.sh && ! -a /etc/consul.d/mongo_secondary.json ]]; then
    cp -u /opt/checks/check_scripts/mongo_secondary_check.sh /etc/consul.d/check_scripts/
    cp -u /opt/checks/mongo_secondary.json /etc/consul.d/

    REGISTER_SECONDARY=1
  fi

else

  # Register as Mongo Master
  if [[ ! -a /etc/consul.d/check_scripts/mongo_primary_check.sh && ! -a /etc/consul.d/mongo_primary.json ]]; then
    cp -u /opt/checks/check_scripts/mongo_primary_check.sh /etc/consul.d/check_scripts/
    cp -u /opt/checks/mongo_primary.json /etc/consul.d/

    REGISTER_MASTER=2
  fi

  # Deregister as Mongo Secondary
  if [[ -a /etc/consul.d/check_scripts/mongo_secondary_check.sh && -a /etc/consul.d/mongo_secondary.json ]]; then
    rm -f /etc/consul.d/check_scripts/mongo_secondary_check.sh
    rm -f /etc/consul.d/mongo_secondary.json

    REGISTER_SECONDARY=2
  fi

fi

if [[ $REGISTER_MASTER -ne 0 && $REGISTER_SECONDARY -ne 0 ]]; then
  consul reload
fi
