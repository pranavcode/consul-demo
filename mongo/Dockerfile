FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    bash curl net-tools \
    zip unzip jq dnsutils \
    iputils-ping

# Install MongoDB
RUN apt-get install -y mongodb

# Setup Consul and Goreman
RUN mkdir -p /data/db /etc/consul.d

ADD https://releases.hashicorp.com/consul/1.4.1/consul_1.4.1_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

ADD https://github.com/mattn/goreman/releases/download/v0.0.10/goreman_linux_amd64.zip /tmp/goreman.zip
RUN cd /bin && unzip /tmp/goreman.zip && chmod +x /bin/goreman && rm /tmp/goreman.zip

VOLUME data:/data/db

ADD ./config/consul /etc/consul.d
ADD ./config/mongod /etc
ADD Procfile /root/Procfile

ENV PRIVATE_IP_ADDRESS $PRIVATE_IP_ADDRESS
ENV MONGO_PORT $MONGO_PORT
ENV PRIMARY $PRIMARY

EXPOSE $MONGO_PORT

# Launch both mongo server and consul
ENTRYPOINT [ "goreman" ]
CMD [ "-f", "/root/Procfile", "start" ]
