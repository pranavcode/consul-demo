FROM python:3.7

RUN apt-get update && \
    apt-get install -y \
    bash curl nano net-tools zip unzip \
    jq dnsutils iputils-ping

# Python Environment Setup
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Setup Consul and Goreman
RUN mkdir -p /data/db /etc/consul.d

ADD https://releases.hashicorp.com/consul/1.4.4/consul_1.4.4_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

ADD https://github.com/mattn/goreman/releases/download/v0.0.10/goreman_linux_amd64.zip /tmp/goreman.zip
RUN cd /bin && unzip /tmp/goreman.zip && chmod +x /bin/goreman && rm /tmp/goreman.zip

ADD ./consul /etc/consul.d
ADD Procfile /root/Procfile

# Install pipenv
RUN pip3 install --upgrade pip
RUN pip3 install pipenv

# Setting workdir
ADD consul.sh /opt
ADD . /web
WORKDIR /web/tweeter

# Exposing appropriate ports
EXPOSE 8000/tcp

# Install dependencies
RUN pipenv install --system --deploy --ignore-pipfile

# Migrates the database, uploads staticfiles, run API server and background tasks
ENTRYPOINT [ "goreman" ]
CMD [ "-f", "/root/Procfile", "start" ]
