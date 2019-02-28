from django.shortcuts import render
from djongo import database

# Create your views here.
def home(request):
    db_conn = database.connect()

    return render(request, 'home.html', { 
        'mongo_host': db_conn.HOST,
        'mongo_port': db_conn.PORT,
        'mongo_address': db_conn.address,
        'mongo_is_primary': db_conn.is_primary,
        'mongo_secondaries': db_conn.secondaries,
    })
