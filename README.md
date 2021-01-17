# HashiCorp Consul Demo

This code demo is accompanied complements the blog post series - [The Practical Guide to HashiCorp Consul](https://velotio.com/blog?author=5c8625c1a4222f448ac70063) - [Part 1](https://velotio.com/blog/2019/3/11/hashicorp-consul-guide-1) and [Part 2](https://velotio.com/blog/2019/4/5/hashicorp-consul-guide-2) - published on [Velotio](https://www.velotio.com) [Blog](https://www.velotio.com/blog).

## Pre-requisites

- [Docker](https://docs.docker.com/install/#server)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Build and run

### Build

```
docker-compose build
```

### Run

```
docker-compose up
```

### Build and run in one command

```
docker-compose up --build -d
```

## Consul Server

You can visit Consul Server container with the IP it's container was assigned. For instance, in our case it was [http://33.10.0.2:8500/ui](http://33.10.0.2:8500/ui).

## Django Web App via Fabio LB

You can visit Django web app on [33.10.0.100:9999/web](http://33.10.0.100:9999/web).

## Bring down the docker

```
docker-compose down
```
