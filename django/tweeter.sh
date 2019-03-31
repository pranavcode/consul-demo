#!/bin/bash

# Check the availability of Mongo server
while [[ $(ping -qc1 database.mongo-primary.service.consul > /dev/null 2>&1 && echo $?) -ne 0 ]]; do
    echo "Waiting for MongoDB Primary"
    sleep 10
done

# Migrate database
if [[ $PRIMARY -eq 1 ]]; then
    python ./manage.py migrate
fi

# Fetch static files
python ./manage.py collectstatic --noinput

# Run background task processor and Django API server
gunicorn -w 1 --bind 0.0.0.0:8000 --access-logfile - tweeter.wsgi:application
