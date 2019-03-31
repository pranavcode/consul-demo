#!/bin/bash

# Set configuration settings environment variables 
# for our example Django app.

# Note: This is for demonstration purposes only, 
# should use other mechanism/tool for managing 
# Consul's key/value store.

CONSUL_HOST=http://consul_server:8500

curl -X PUT -d 'True' $CONSUL_HOST/v1/kv/web/debug
curl -X PUT -d 'localhost, 33.10.0.100' $CONSUL_HOST/v1/kv/web/allowed_hosts
curl -X PUT -d 'tweetapp' $CONSUL_HOST/v1/kv/web/installed_apps

echo -e "\n[DONE] Setting Environment Variables"
