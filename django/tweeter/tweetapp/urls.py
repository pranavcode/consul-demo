from django.urls import path
from tweetapp import views

urlpatterns = [
    path('', views.home, name='home'),
]
