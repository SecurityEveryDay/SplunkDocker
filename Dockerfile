FROM debian:latest

USER root
RUN apt update -y 
RUN apt install curl -y
RUN apt install wget -y
RUN apt-get install -y procps

WORKDIR /opt/
RUN wget -O splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz "https://download.splunk.com/products/splunk/releases/9.4.0/linux/splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz"
RUN tar xzvf splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "entrypoint.sh"]