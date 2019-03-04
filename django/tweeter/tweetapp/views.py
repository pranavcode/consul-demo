from django.shortcuts import render
from pymongo import MongoClient

def home(request):
    client = MongoClient("mongo-primary.service.consul")
    replica_set = client.admin.command('ismaster')

    return render(request, 'home.html', { 
        'mongo_hosts': replica_set['hosts'],
        'mongo_primary_host': replica_set['primary'],
        'mongo_connected_host': replica_set['me'],
        'mongo_is_primary': replica_set['ismaster'],
        'mongo_is_secondary': replica_set['secondary'],
    })
