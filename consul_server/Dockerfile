FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    bash curl net-tools \
    zip unzip jq dnsutils

ADD https://releases.hashicorp.com/consul/1.4.1/consul_1.4.1_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

# Consul ports
EXPOSE 8300 8301 8302 8400 8500

RUN mkdir -p /data
VOLUME /data

CMD consul agent -server \
    -bind $PRIVATE_IP_ADDRESS \
    -advertise $PRIVATE_IP_ADDRESS \
    -data-dir /data \
    -bootstrap
