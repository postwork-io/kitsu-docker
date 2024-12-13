FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y nginx git

ADD ./zou /etc/nginx/sites-available
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/zou /etc/nginx/sites-enabled/zou


RUN cd /opt && git clone -b build https://github.com/cgwire/kitsu

WORKDIR /opt/kitsu

RUN git checkout build

CMD ["nginx", "-g", "daemon off;"]