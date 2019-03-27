FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    bash curl nano net-tools zip unzip \
    jq dnsutils iputils-ping

# Install MongoDB
RUN apt-get install -y mongodb

# Setup Consul and Goreman
RUN mkdir -p /data/db

ADD https://releases.hashicorp.com/consul/1.4.4/consul_1.4.4_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

ADD https://github.com/mattn/goreman/releases/download/v0.0.10/goreman_linux_amd64.zip /tmp/goreman.zip
RUN cd /bin && unzip /tmp/goreman.zip && chmod +x /bin/goreman && rm /tmp/goreman.zip

VOLUME data:/data/db

RUN mkdir -p /etc/consul.d/check_scripts
ADD ./config/mongod /etc

RUN mkdir -p /etc/checks
ADD ./config/checks /opt/checks

ADD checks_toggler.sh /opt
ADD mongo.sh /opt
ADD consul.sh /opt

ADD Procfile /root/Procfile

EXPOSE $MONGO_PORT

# Launch both mongo server and consul
ENTRYPOINT [ "goreman" ]
CMD [ "-f", "/root/Procfile", "start" ]
