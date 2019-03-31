FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    bash curl nano net-tools zip unzip \
    jq dnsutils iputils-ping

ADD https://releases.hashicorp.com/consul/1.4.4/consul_1.4.4_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

# Consul ports
EXPOSE 8300 8301 8302 8400 8500

ADD consul_server.sh /opt
RUN mkdir -p /data
VOLUME /data

CMD ["/opt/consul_server.sh"]
