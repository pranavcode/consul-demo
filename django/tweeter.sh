#!/bin/bash

# Migrate DB for Django API
python ./manage.py migrate

# Fetch static files
./manage.py collectstatic --noinput

# Run background task processor and Django API server
gunicorn -w 3 --bind 0.0.0.0:8000 --access-logfile - tweeter.wsgi:application
